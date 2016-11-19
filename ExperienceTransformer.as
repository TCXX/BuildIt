package 
{
	
	/**
	 * ...
	 * @author TCXX
	 */
	public class ExperienceTransformer
	{
		private var populationList:Array = [ 0, 0, 0, 0, 0, 0, 1, 1, 2, 3, 10, 100, 0, 0, 0, 0, 0];
		private var environmentList:Array = [ 1, 3, 10, 40, 150, 500, -1, -3, -5, -10, -20, 0, 0, 0, 0, 0, 0];
		private var expList:Array = [ 1, 3, 9, 30, 100, 300, 1, 3, 9, 30, 100,300, 1, 5, 15, 50, 200];
		
		public function ExperienceTransformer(){
		    //1 7 14
     	}
		
		public function populationTransform(_item:int) {
			if (_item < 0) {
				trace("Error:not abs when calculate");
				return void;
			}
			return populationList[_item - 1];
		}
		
		public function environmentTransform(_item:int) {
			if (_item < 0) {
				trace("Error:not abs when calculate");
				return void;
			}
			return environmentList[_item - 1];
		}
		
		public function expTransform(_item:int) {
			if (_item < 0) {
				trace("Error:not abs when calculate");
				return void;
			}
			return expList[_item - 1];
		}
		
	}
	
}