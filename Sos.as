package 
{
	import flash.net.SharedObject;
	
	/**
	 * ...
	 * @author TCXX
	 */
	public class Sos
	{
		var so:SharedObject = SharedObject.getLocal("meaoData");
		function Sos() {
			
		}
		
		function read() {
			if (so.data.status=="saved") {
				Main.gameEngine.experience = so.data.experience;
		    	Main.gameEngine.gameMap.itemList = so.data.soMap;
				Main.gameEngine.presentItem.presentItemList = so.data.item;
			    trace("sos loaded!");
			}
			
		}
		
		function clean() {
			so.data.status = "";
		}
		
		protected function save() {
			so.data.soDate = new Date();
			so.data.status = "saved";
			trace("sos saved!");
			so.data.experience = Main.gameEngine.experience;
			so.data.soMap = Main.gameEngine.gameMap.itemList;
			so.data.item = Main.gameEngine.presentItem.presentItemList;
		}
		
		function write() {
			save();
			var rs = so.flush();
		}
	}
	
}