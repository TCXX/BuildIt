//done!

package 
{
	
	/**
	 * ...
	 * @author TCXX
	 */
	public class ItemProducer
	{
	
		private var constructionSpeed:Number;//=0.2
		private var offsetRateConstruction:Number;
		private var rateDrop:int;//14
		private var rateSeed:int;//1
		private var rateBrick:int;//7
		private var rateRainbow:int;//18
		private var rateBumb:int;//19
		
		public function ItemProducer(
		_offsetRateConstruction:Number=0.2,
		_rateDrop:int=5,
		_rateSeed:int=40,
		_rateBrick:int=50,//50
		_rateRainbow:int = 0,//2,
		_rateBumb:int = 5//3
		) {
			constructionSpeed = _offsetRateConstruction;
			offsetRateConstruction = _offsetRateConstruction;
			rateBrick = _rateBrick;
			rateBumb = _rateBumb;
			rateDrop = _rateDrop;
			rateRainbow = _rateRainbow;
			rateSeed = _rateSeed;
		}
		
		function produceItem():int {
			
			var temp:Number;
			
			temp= Math.random() * 100;
			var base:int;
			
			if (temp <rateRainbow) {
				return 18;
			}else if (temp<(rateRainbow + rateBumb)) {
				return 19;
			}else if (temp<(rateRainbow + rateBumb+rateDrop)) {
				base = 14;
			}else if (temp<(rateRainbow + rateBumb + rateDrop+rateBrick)) {
				base = 7;
			}else if (temp<(rateRainbow + rateBumb + rateDrop+rateBrick+rateSeed)) {
				base = 1;
			}
			
			temp = Math.random();
			if (temp < constructionSpeed) {
				base++;
			}
			if (temp < (constructionSpeed*constructionSpeed)) {
				base++;
			}
			if ((base<14)&&(temp < (constructionSpeed*constructionSpeed*constructionSpeed))) {
				base++;
			}

			return base;
		}
	}
	
}