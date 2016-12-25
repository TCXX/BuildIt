package  {
	import flash.text.TextField;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.events.*;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.display.*;
	
	public class Main extends MovieClip{
        static var gameStatus:Boolean = false;
        
	    static var gameEngine:GameEngine=new GameEngine();
      	static var presentExample:ItemGrid = new ItemGrid();
		
	    static var bgLevel:Sprite = new Sprite();
		static var itemLevel:Sprite = new Sprite();
		static var buttonLevel:Sprite = new Sprite();
		static var hintLevel:Sprite = new Sprite();
		
		static var sos:Sos=new Sos();
		
		static var gridLine:GridLine = new GridLine();
		static var txtBoard:Board = new Board();
		static var sound:MySound = new MySound();
		static var gridGroup:Array = new Array();

		var myLoad:Loader=new Loader();
		var swfURLReq:URLRequest = new URLRequest("beginning.swf");   
		
		public function Main() {
			
			trace("<Main>");

			addChild(bgLevel);
			addChild(itemLevel);
			addChild(buttonLevel);
			addChild(hintLevel);
			
			bgLevel.x = 0;
			bgLevel.y = 0;
			itemLevel.x = 0;
			itemLevel.y = 0;
			buttonLevel.x = 0;
			buttonLevel.y = 0;
			hintLevel.x = 0;
			hintLevel.y = 0;
			
			
			trace("<grid>");
			
			for (var y:int = 0; y < 10; y++ ) {
				gridGroup[y] = new Array();
				for (var x:int = 0; x < 10;x++ ) {
			        var grid:ItemGrid = new ItemGrid();
					grid.site = new Point(x,y);
					grid.x = 30 + x * 53.15;
					grid.y = 66.15 + y * 34;
					itemLevel.addChild(grid);
					gridGroup[y].push(grid);
			    }
			}
			trace("</grid>");
			
			gridLine.x = 8;
			gridLine.y = 54;
			txtBoard.x = 18;
			txtBoard.y = 6;
			bgLevel.addChild(gridLine);
			hintLevel.addChild(txtBoard);
			hintLevel.addChild(presentExample);
			
			updateExp();
			
			trace("txt:", txtBoard.experience.text);
			
			myLoad.load(swfURLReq);
			addChild(myLoad);
			stage.addEventListener(MouseEvent.CLICK, loadClick);
			addChild(sound);
			
			presentExample.gotoAndStop(gameEngine.presentItem.presentItemList[0] + 1);
			
			sos.read();
			update();
			presentExample.gotoAndStop(gameEngine.presentItem.presentItemList[0]+1);
			
			gridLine.nextFrame();
			
			trace("</Main>");
		 
		}
		
		protected function showGrid(e:KeyboardEvent) {
			if (e.keyCode!=48) {
				gridLine.nextFrame();
			}else {
				sos.clean();
			}
			
		}
		
		static protected function updateExp() {
			txtBoard.experience.text = gameEngine.experience;
			txtBoard.population.text = gameEngine.population;
			txtBoard.environment.text = gameEngine.environment;
		}
		
		protected function mouseClick(e:MouseEvent) {
			if (!gameStatus) {
				return void;
			}
			var gridX:int=Math.round((mouseX-34)/53.15);
			var gridY:int=Math.round((mouseY-71)/34);
			trace("<click>", gridX, ",", gridY, "</click>");//图中x，y
			if ((gridX<0)||(gridX>9)||(gridY<0)||(gridY>9)) {
				return void;
			}
			sound.gotoAndPlay(2);
			gameEngine.gridClick(new Point(gridY, gridX));
			gameEngine.presentSite = new Point(gridY, gridX);
			presentExample.gotoAndStop(gameEngine.presentItem.presentItemList[0]+1);
		}
		
		protected function loadClick(e:MouseEvent) {
			if ((mouseX<550)&&(mouseX>425)&&(mouseY<400)&&(mouseY>335)) {
				removeChild (myLoad);
				myLoad = null;
				stage.removeEventListener(MouseEvent.CLICK, loadClick);
				stage.addEventListener(MouseEvent.CLICK, mouseClick);
			    stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			    stage.addEventListener(KeyboardEvent.KEY_DOWN, showGrid);
				gameStatus = true;
			}
			return void;
		}
		
		protected function mouseMove(e:MouseEvent) {
			presentExample.x = mouseX;
			presentExample.y = mouseY;
		}
		
		static public function update() {
			trace("<update>");
			updateExp();
			sos.write();
			trace(gameEngine.population);
			for(j=0;j<10;j++){
				for (i = 0; i <10; i++) {
				    //var grid:ItemGrid = gridGroup[j][i];
					var status = gameEngine.gameMap.itemList[j][i];
					if (status==19) {
						gameEngine.gameMap.itemList[j][i] = 0;
					}
					gridGroup[j][i].gotoAndStop(status + 1);
			    }
			}
			trace("</update>");
		}
		
		


	}
	
}
