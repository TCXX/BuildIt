package 
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author TCXX
	 */
	public class GameEngine
	{
	var gameMap:GameMap=new GameMap(10,10);
	//var gameStatus:int=0;
	var presentItem:PresentItem = new PresentItem();
	var experienceTransformer:ExperienceTransformer = new ExperienceTransformer();
	
	var environment:int = 100;
	var population:int=0;
	var experience:int = 0;
	var presentSite:Point;

		public function GameEngine(){
			
		}
		
		function gridClick(_site:Point) {
			trace("<gridClick>");
			
			if ((gameMap.itemList[_site.x][_site.y] != 0)&&(presentItem.presentItemList[0]!=19)) {
				trace("item!=0");
				//trace(gameMap.itemList);
				return void;//nothing's on the ground
			}
			presentSite = _site;
			trace(_site);
			var b:Boolean = gameMap.buildItem(_site.x, _site.y);//right
			if (b == false) {
				trace("gridClick return void");
				return void;
			}
			
			//var status = gameMap.itemList[_site.y][_site.x];

			
			trace("preceed:",gameMap.itemList);
			var base:int = gameMap.itemList[_site.x][_site.y];
			
			var counterpartNumber:int = gameMap.countCounterpart(_site.x, _site.y, base);
			trace("base", base, "counterPNumber", counterpartNumber);
			if (counterpartNumber<3) {
				Main.update();
			}else{
			while ((counterpartNumber >= 3)&& (!gameMap.ifGridIsPerfect(base))) {
				//in fact, the number should not be 3 always
				trace("Success:combine the item!");
				gameMap.deleteCounterpart(_site.x, _site.y, base);
				experience += experienceTransformer.expTransform(base)*counterpartNumber;
				base+=1;
				//here add up the experience for the player immediately
				gameMap.itemList[_site.x][_site.y] = base;

				counterpartNumber = gameMap.countCounterpart(_site.x, _site.y, base);
				trace("base", base, "counterPNumber", counterpartNumber);
			    }
			}

			trace("after sort:",gameMap.itemList);
			//gameMap.absAllItem();
			calculateExperience();

			Main.update();
			trace("population",population);
			trace("</gridClick>");
		}
		
		function calculateExperience() {
			var temp1:int = 100;
			var temp2:int = 0;
			
			for (var j:int = 1; j < 9; j++) {
				for (var i:int = 1; i < 9; i++) {
					var base:int = Math.abs(gameMap.itemList[j][i]);
					if (base!=0) {
						temp1 += experienceTransformer.environmentTransform(base);
					    temp2 += experienceTransformer.populationTransform(base);
					}
				    
			    }
			}
			
			environment = temp1;
			population = temp2;
			
		}
		
		
	}
	
}