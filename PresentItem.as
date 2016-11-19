//done!

package 
{
	
	/**
	 * ...
	 * @author TCXX
	 */

	 
	public class PresentItem
	{
		//private
		var presentItemList:Array = new Array();
		private var itemProducer:ItemProducer = new ItemProducer();
		
		public function PresentItem() {
			presentItemList.push(itemProducer.produceItem());
			presentItemList.push(itemProducer.produceItem());
		}
		
		
		function popPresentItem():int {
            var temp:int = presentItemList.shift();
			if (presentItemList.length<=1){
				presentItemList.push(itemProducer.produceItem());
			}
			return temp;
		}
		
		function newItem(_item:int=0) {
			if(_item==0){
				presentItemList.unshift(itemProducer.produceItem());
			}else{
				presentItemList.unshift(_item);
			}
		}
	}
	
}