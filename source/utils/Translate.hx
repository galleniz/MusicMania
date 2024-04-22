package utils;

class Translator
{
	static var cache:Map<String, String> = new Map();

	public static function translate(text:String, sourceLang:String = 'auto', targetLang:String)
	{
		var cacheFormat = "translate_" + sourceLang + "_" + targetLang + "_" + text;
		trace("Cache format: " + cacheFormat);
		if (cache.exists(cacheFormat))
		{
			return cache.get(cacheFormat);
		}
		final request = new Http("https://translate.google.com/translate_a/single"
			+ "?client=at&dt=t&dt=ld&dt=qca&dt=rm&dt=bd&dj=1&hl="
			+ targetLang
			+ "&ie=UTF-8"
			+ "&oe=UTF-8&inputm=2&otf=2&iid=1dd3b944-fa62-4b55-b330-74909a99969e");
		request.setPostData('sl=' + sourceLang + '&tl=' + targetLang + '&q=' + text);
		request.setHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
		request.setHeader("User-Agent", "AndroidTranslate/5.3.0.RC02.130475354-53000263 5.1 phone TRANSLATE_OPM5_TEST_1");
		var peruvianSans = "";
		request.onData = function(data:String)
		{
			final dataPeroJson:{sentences:Array<Dynamic>} = cast Json.parse(data);
			var tilin = "";
			for (translation in dataPeroJson.sentences)
			{
				tilin += translation.trans;
			}
			peruvianSans = tilin;
		}

		request.onError = function(error:String)
		{
			trace(error);
			peruvianSans = "Error";
		}
		request.request(true);
		while (peruvianSans.length < 1) {}
		cache.set(cacheFormat, peruvianSans);
		return peruvianSans;
	}
}
