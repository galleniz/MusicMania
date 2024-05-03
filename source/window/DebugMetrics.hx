package window;

import openfl.display.Sprite;
import openfl.events.Event;
import openfl.text.TextField;

class DebugMetrics extends Sprite
{
	public static var metrics:DebugMetrics;

	public static function get()
	{
		if (metrics == null)
		{
			metrics = new DebugMetrics();
		}
		return metrics;
	}

	var tf:TextField;

	public var values:Map<String, String>;

	public function new()
	{
		super();
		values = new Map<String, String>();
		tf = new TextField();
		tf.text = "DebugMetrics";
		tf.width = 1280;
		tf.height = 20;
		tf.selectable = false;
		tf.mouseEnabled = false;
		tf.textColor = 0xFFFF7C7C;
		tf.height = 740;
		addChild(tf);
		this.addEventListener(Event.ENTER_FRAME, update);
	}

	public function update(event:Event)
	{
		var str = "DebugMetrics\n\n";
		for (name in values.keys())
		{
			str += name + ": " + values.get(name) + "\n";
		}
		tf.text = str;
	}

	public static function setValue(name:String, value:Dynamic)
	{
		var values = get().values;
		value = Std.string(value);
		if (name == null || value == null)
		{
			values.remove(name);
			return;
		}
		values.set(name, value);
	}
}
