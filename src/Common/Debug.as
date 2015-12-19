package
{
	import Date;

	public class Debug extends Object
	{
		public function Debug()
        {
            super();
        }
		
	  /* PRIVATE VARIABLES */
		private static var _buffer: Array = [];

	  /* PUBLIC STATIC FUNCTIONS */
		public static function log(/* a_text: String , a_text2: String ... */)
		{
			var date: Date = new Date;
			var hh: String = String(date.getHours());
			var mm: String = String(date.getMinutes());
			var ss: String = String(date.getSeconds());
			var ff: String = String(date.getMilliseconds());

			var dateTime: String = "[" + ((hh.length < 2) ? "0" + hh : hh);
			dateTime += ":" + ((mm.length < 2) ? "0" + mm : mm);
			dateTime += ":" + ((ss.length < 2) ? "0" + ss : ss);
			dateTime += "." + ((ff.length < 2) ? "00" + ff : (ff.length < 3) ? "0" + ff : ff);
			dateTime += "]";

			// Flush buffer
			if (_buffer.length > 0) {
				for(var i:uint = 0; i < _buffer.length; i++)
					trace(_buffer[i]);			
				_buffer.splice(0);
			}

			for(var j:uint = 0; j < arguments.length; j++) {
				var str = dateTime + " " + arguments[j];
				trace(str);
			}
		}

		public static function logNT(/* a_text: String , a_text2: String ... */)
		{
			// Flush buffer
			if (_buffer.length > 0) {
				for(var j:uint = 0; j < _buffer.length; j++)
					trace(_buffer[j]);			
				_buffer.splice(0);
			}

			for(var k:uint = 0; i < arguments.length; k++) {
				var str = arguments[k];
				trace(str);
			}
		}

		public static function dump(a_name: String, a_obj, a_noTimestamp: Boolean, a_padLevel: Number)
		{
			var pad: String = "";
			var padLevel: Number = a_padLevel;
			var logFn: Function = (a_noTimestamp)? logNT: log;

			for(var i:uint = 0; i < padLevel; i++)
				pad += "    ";
				
			switch(typeof(a_obj))
			{
				case "object":
				case "movieclip":
				case "function":
				{
					logFn(pad + a_name);
					for (var s:* in a_obj)
						dump(s, a_obj[s], a_noTimestamp, padLevel + 1);
				}
				break;
				case "array":
				{
					logFn(pad + a_name);
					for(var j:uint = 0; j < a_obj.length; j++)
						dump(j, a_obj[j], a_noTimestamp, padLevel + 1);
				}
				break;
				default:
				{
					logFn(pad + a_name + ": (" + typeof(a_obj) + ")" + a_obj);
				}
				break;
			}
		}
	}
}