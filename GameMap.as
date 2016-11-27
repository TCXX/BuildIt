/*

违背了单一原则。

*/

package 
{
	
	public class GameMap
	{
		var height:int;
		var width:int;
		
		var itemList:Array=new Array();
		var geoList:Array=new Array();
		
		public function GameMap(_height:int, _width:int) {
			trace(geoList);
			height = _height;
			width = _width;
			geoList[0]=new Array();
			
			for(var j:int=1;j<height-1;j++){
				geoList[j]=new Array();
				for(i=1;i<width-1;i++){
				    geoList[j][i]=0;
			    }
				geoList[j][0]=1;
				geoList[j][width-1]=1;
			}
			geoList[height-1]=new Array();
			for(var i:int=0;i<=width-1;i++){
				geoList[0][i]=1;
			    geoList[height-1][i]=1;
			}
			for(j=0;j<=height-1;j++){
				itemList[j]=new Array();
				for (i = 0; i <= width - 1; i++) {
				    itemList[j][i]=0;
			    }
			}
		}
		
		function getGridStatus(x:int, y:int):int {
			if ((x<0)||(x>9)) {
				return 0;
			}
			if ((y<0)||(y>9)) {
				return 0;
			}
			return itemList[x][y];
		}
		
		function ifGridIsPerfect(_item:int):Boolean {
			if (_item == 6) {
				return true;
			}
			if (_item == 13) {
				return true;
			}
			if (_item == 17) {
				return true;
			}
			return false;
		}
		
		function countCounterpart(x:int, y:int,kind:int):int {
			//参考的不是present
			absAllItem();
			markAdjascent(Main.gameEngine.presentSite.x, Main.gameEngine.presentSite.y, kind);
			var temp:int = minusItem();
			absAllItem();
			return temp;
		}
		
		protected function markAdjascent(x:int, y:int,kind:int) {
			if (itemList[x][y]>0) {
				itemList[x][y] = (-1)*Math.abs(itemList[x][y]);
			}else if(itemList[x][y]<0) {
				trace("Marked already!");
				return void;
			}else {
				trace("Error:mark Void");
				trace("Error imformation:",itemList);
				return void;
			}
			if (getGridStatus(x+1,y)==kind) {
				markAdjascent(x+1,y,kind);
			}
			if (getGridStatus(x,y+1)==kind) {
				markAdjascent(x,y+1,kind);
			}
			if (getGridStatus(x-1,y)==kind) {
				markAdjascent(x-1,y,kind);
			}
			if (getGridStatus(x,y-1)==kind) {
				markAdjascent(x,y-1,kind);
			}
		}
		
		function absAllItem() {
			for (var y:int = 0; y < 10; y++ ) {
				for (var x:int = 0; x < 10;x++ ) {
			        itemList[x][y] = Math.abs(itemList[x][y] );
			    }
			}
		}
		
		protected function minusItem() {
			var temp:int = 0;
			for (var y:int = 0; y < 10; y++ ) {
				for (var x:int = 0; x < 10;x++ ) {
			        if (itemList[x][y]<0) {
						temp += 1;
					}
			    }
			}
			return temp;
		}
		
		function deleteCounterpart(x:int, y:int,kind:int) {
			absAllItem();
			markAdjascent(Main.gameEngine.presentSite.x, Main.gameEngine.presentSite.y, kind);
			for (var y:int = 0; y < 10; y++ ) {
				for (var x:int = 0; x < 10;x++ ) {
			        if (itemList[x][y]<0) {
						itemList[x][y] = 0;
					}
			    }
			}
			absAllItem();
		}
		
		function buildItem(x:int, y:int):Boolean {
			trace(Main.gameEngine.presentItem.presentItemList[0],"item[0]");
			var temp:int = Main.gameEngine.presentItem.presentItemList[0];
			if (temp==19) {
				itemList[x][y] = Main.gameEngine.presentItem.popPresentItem();
				Main.update();
				return false;
			}
			if ((temp >= 14) && (geoList[x][y] != 1)) {
				trace("geo!=1");
				return false;
			}else if ((temp < 14) && (geoList[x][y] != 0)) {
				trace("geo!=0");
				return false;
			}
			itemList[x][y] = Main.gameEngine.presentItem.popPresentItem();
			return true;
		}
		
		
		function deleteItem(x:int, y:int) {
			itemList[x][y] = 0;
		}

	}
	
}
