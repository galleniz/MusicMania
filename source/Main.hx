package;

import flixel.FlxGame;
import flixel.ui.FlxBar;
import openfl.display.Screen;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.events.NativeWindowBoundsEvent;
import openfl.geom.Rectangle;
import sys.thread.Thread;
import window.TitleBar;

class Main extends Sprite
{
	var game:FlxGame;
	var titlebar:TitleBar;

	public function new()
	{
		super();
		haxe.Log.trace = function(v, ?infos)
		{
			console.log(v, infos);
		};
		trace("Starting game");
		trace("Trying to resize window"); // get monitor size
		var screen:Rectangle = Screen.mainScreen.bounds;
		trace("Screen size: " + screen.width + "x" + screen.height);
		stage.window.minHeight = 480;
		stage.window.minWidth = 640;
		stage.window.borderless = false;
		// stage.window.resizable = false;
		stage.window.title = "Music Mania";

		stage.window.resize(Math.floor(screen.width / 1.5), Math.floor(screen.height / 1.5));
		trace("Window size: " + stage.window.width + "x" + stage.window.height);
		if (screen.width < 1280 || screen.height < 720)
		{
			trace("Screen size is too small, setting window size to 1280x720");
			stage.window.resize(Math.floor(1280 / 2), Math.floor(720 / 2));
		}
		trace("Window size: " + stage.window.width + "x" + stage.window.height);
		// center the window
		stage.window.move(Math.floor((screen.width - stage.window.width) / 2), Math.floor((screen.height - stage.window.height) / 2));
		trace('Window position: ' + stage.window.x + 'x' + stage.window.y);
		addChild(game = new FlxGame(1280, 720, Loader));
		addChild(titlebar = new TitleBar());
		stage.addEventListener(MouseEvent.CLICK, (e) ->
		{
			titlebar.onMouseClick();
		});
		stage.addEventListener(NativeWindowBoundsEvent.RESIZE, (e) ->
		{
			titlebar.onResize(stage.window.width, stage.window.height);
		});
		stage.addEventListener(Event.ENTER_FRAME, (e) ->
		{
			@:privateAccess titlebar.update(e);
		});
		Thread.create(function()
		{
			trace("Thread started");
			Client.init();
		});
		FlxG.mouse.useSystemCursor = true;
		titlebar.onResize(0, 0);

		addChild(window.DebugMetrics.get());
	}
}

class Loader extends FlxState
{
	public function new()
	{
		super();
	}

	var t:FlxText;
	var bar:FlxBar;

	override public function create()
	{
		super.create();
		t = new FlxText(0, 0, FlxG.width, "Loading...");
		t.setFormat(null, 16, 0xFFFFFFFF, "center");
		add(t);
		bar = new FlxBar(0, FlxG.height - 20, FlxBarFillDirection.LEFT_TO_RIGHT, FlxG.width, 20, this, "f", 0, 1);
		add(bar);

		update(1 / 60);
	}

	var f:Float = 0;

	override public function update(elapsed:Float)
	{
		t.screenCenter();
		t.y = bar.y - t.height;
		bar.screenCenter(X);
		super.update(elapsed);
		if (f < 0.6)
			f += elapsed;
		else
			f += elapsed * 0.5;
		if (f > 1)
		{
			FlxG.switchState(new PlayState());
		}
	}

	override public function destroy()
	{
		super.destroy();
	}
}
