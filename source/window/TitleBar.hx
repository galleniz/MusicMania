package window;

import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import lime.ui.MouseButton;
import lime.ui.MouseCursor;
import openfl.display.Screen;
import openfl.display.Sprite;
import openfl.display.Stage;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.geom.Point;
import openfl.geom.Point;
import openfl.text.TextField;
import openfl.ui.Mouse;
import sys.thread.Thread;

class TitleBar extends Sprite
{
	var bg:Sprite;

	public var buttons:Array<Button> = [];

	var title:TextField;
	private var isDragging:Bool = false;
	private var dragOffset:Point = new Point();

	public function new()
	{
		super();
		bg = new Sprite();
		bg.graphics.beginFill(0x333333, 0.5);
		bg.graphics.drawRect(0, 0, 100, 20);
		bg.graphics.endFill();
		addChild(bg);

		var resetState = new Button(0, 0);
		var resetStateText = new TextField();
		resetStateText.text = "Reset State";
		resetStateText.setTextFormat(new openfl.text.TextFormat("Arial", 12, 0xFFFFFF));
		resetState.addChild(resetStateText);
		resetState.click = function()
		{
			FlxG.resetState();
		};
		addButton(resetState);
		var resetGame = new Button(0, 0);
		var resetGameText = new TextField();
		resetGameText.text = "Reset Game";
		resetGameText.setTextFormat(new openfl.text.TextFormat("Arial", 12, 0xFFFFFF));
		resetGame.addChild(resetGameText);
		resetGame.click = function()
		{
			FlxG.resetGame();
		};
		addButton(resetGame);
		var forceZoomTo0dot5 = new Button(0, 0);
		var forceZoomTo0dot5Text = new TextField();
		forceZoomTo0dot5Text.text = "Force Zoom to 0.5";
		forceZoomTo0dot5Text.setTextFormat(new openfl.text.TextFormat("Arial", 12, 0xFFFFFF));
		forceZoomTo0dot5.addChild(forceZoomTo0dot5Text);
		forceZoomTo0dot5.click = function()
		{
			FlxG.state.camera.zoom = 0.5;
		};
		addButton(forceZoomTo0dot5);
	}

	public function addButton(button:Button)
	{
		buttons.push(button);
		addChild(button);
	}

	var twn:FlxTween;

	function update(_)
	{
		for (button in buttons)
		{
			button.update();
		}
		// if mouse dosnt overlaps me (bg), then alpha is 0.1
		if (stage.mouseX > bg.x && stage.mouseX < bg.x + bg.width)
		{
			if (stage.mouseY > bg.y && stage.mouseY < bg.y + bg.height + 10)
			{
				if (twn != null)
				{
					twn.cancel();
				}
				alpha = 1;
				y = 0;
			}
			else
			{
				if (twn == null || !twn.active || (y == 0 && twn.finished))
					twn = FlxTween.tween(this, {y: -20, alpha: 0}, 1, {type: FlxTween.ONESHOT, ease: FlxEase.quadOut, startDelay: 1});
				// alpha = 0.1;
			}
		}
		onResize(0, 0);
	}

	public function onMouseClick()
	{
		for (button in buttons)
		{
			@:privateAccess if (button._click())
			{
				break;
			}
		}
	}

	public function onResize(a, b)
	{
		var w = Math.floor(stage.stageWidth);
		var h = Math.floor(stage.stageHeight);
		bg.width = w;
		bg.height = 20;
		for (button in buttons)
		{
			button.x = w - ((button.width * (buttons.indexOf(button) + 1)) + 20);
			button.y = height / 2 - button.height / 2;
		}
	}
}

class Button extends Sprite
{
	public function new(x, y)
	{
		super();
		restPos = new Point(x, y);
	}

	public var restPos:Point;

	public function update()
	{
		if (stage.mouseX > x && stage.mouseX < x + width && stage.mouseY > y && stage.mouseY < y + height)
		{
			alpha = 0.5;
		}
		else
		{
			alpha = 1;
		}
	}

	public dynamic function click() {}

	private function _click()
	{
		if (!(stage.mouseX > x && stage.mouseX < x + width && stage.mouseY > y && stage.mouseY < y + height))
		{
			return false;
		}
		click();

		return true;
	}
}
