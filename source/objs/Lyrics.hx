package objs;

import flixel.tweens.FlxTween;

class Lyrics extends FlxText
{
	public var lifeExistence:Float = 0;
	public var parent:Array<Lyrics> = null;

	public function new(x:Float, y:Float, width:Int, text:String, lifeExistence:Float)
	{
		super(x, y, width, text);
		this.size = 16;
		this.alignment = "center";
		this.color = 0xffffee05;
		this.screenCenter(X);
		y = 20;
		this.lifeExistence = lifeExistence;
	}

	var twn:FlxTween;

	public function move()
	{
		if (twn == null)
		{
			twn = FlxTween.tween(this, {y: y + (height * 1.5), alpha: 0}, lifeExistence, {
				onComplete: function(_)
				{
					this.kill();
					this.destroy();
					if (parent != null)
					{
						parent.remove(this);
					}
				}
			});
		}
	}
}
