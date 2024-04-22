package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.math.FlxMath;
import objs.Lyrics;
import openfl.Assets;
import openfl.geom.Rectangle;
import utils.Translate.Translator;

class PlayState extends FlxState
{
	var music:BPMSound;

	override public function create()
	{
		super.create();
		// refresh the focus, or obtain in, like, putting the focus on the game
		FlxG.stage.window.focus();
		console.log("hola");
		final _text = text(0, 0, ":3");
		_text.setFormat(null, 16, 0xFFFFFFFF);
		_text.x = (FlxG.width - _text.width) / 2;
		_text.y = (FlxG.height - _text.height) / 2;
		FlxG.autoPause = false;
		music = new BPMSound();
		music.group = FlxG.sound.defaultMusicGroup;
		FlxG.sound.defaultMusicGroup.add(music);
		music.loadEmbedded("assets/songs/whoneedsthebusboi/inst.ogg");
		// dont ask for the name, uh, i may have been a bit drunk when i named it
		music.bpm = 120;
		music.beatHit = function(beat:Int)
		{
			FlxG.camera.zoom += 0.015;
		}
		var text = Assets.getText("assets/songs/whoneedsthebusboi/lyrics.txt");
		var lines = text.split("\n");
		for (line in lines)
		{
			var parts = line.split(" ");
			var time = Std.parseFloat(parts.shift());
			if (Math.isNaN(time))
			{
				txtLyr.push({
					time: 999999,
					text: line,
					translate: line,
				});
				continue;
			}
			var txt = parts.join(" ");
			var translatedText = txt;
			try
			{
				translatedText = Translator.translate(txt, "en", "es");
			}
			catch (e:Dynamic)
			{
				trace("error translating: " + e);
			}
			txtLyr.push({time: time, text: txt, translate: translatedText});
		}
		// sort by time
		txtLyr.sort(function(a, b)
		{
			if (a.time > b.time)
				return 1;
			if (a.time < b.time)
				return -1;
			return 0;
		});

		var border = new FlxSprite(0, 0);
		border.makeGraphic(1280, 720, 0xffffffff);
		add(border);
		border.graphic.bitmap.fillRect(new Rectangle(10, 10, 1260, 700), 0x00000000);
		border.scale.scale(0.9, 0.9);
		border.updateHitbox();
		border.screenCenter();
		music.play();
	}

	public override function destroy()
	{
		super.destroy();
		music.destroy();
	}

	var txtLyr:Array<
		{
			time:Float,
			text:String,
			translate:String
		}> = [];

	public var lyrics:Array<Lyrics>;
	public var lyricstr:Array<Lyrics>;

	var displayedlyrics:Array<
		{
			time:Float,
			text:String,
			translate:String
		}> = [];

	public function addLyricText(lyric:String, translate:String = null)
	{
		if (lyrics == null)
			lyrics = new Array<Lyrics>();
		if (lyricstr == null)
			lyricstr = new Array<Lyrics>();
		for (l in lyricstr)
			l.move();
		for (l in lyrics)
			l.move();
		@:privateAccess
		var l = new Lyrics(0, 1, 1280, lyric, music.stepCrochet / 1000);
		lyrics.push(l);
		@:privateAccess l.parent = lyrics;
		l.screenCenter();
		l.size = 18;
		l.y += 230;
		add(l);
		if (translate != null)
		{
			@:privateAccess
			var l2 = new Lyrics(0, 1, 1280, translate, music.stepCrochet / 1000);
			lyricstr.push(l2);
			@:privateAccess l2.parent = lyricstr;
			l2.screenCenter();
			l2.y += 260;
			l2.size = 14;
			l2.color = 0xff848d33;
			add(l2);
		}
	}

	public var zoomBeat = 2;

	override public function update(elapsed:Float)
	{
		music.updateSong();
		var lir = txtLyr[0];
		if (FlxG.keys.justPressed.J)
		{
			var formatedText = "";
			for (l in displayedlyrics)
			{
				formatedText += l.time + " " + l.text + "\n";
			}
			File.saveContent("lyrics.txt", formatedText);
		}
		if (lir != null && music.time >= lir.time || FlxG.keys.justPressed.L)
		{
			lir.time = music.time;
			displayedlyrics.push(lir);
			addLyricText(lir.text, lir.translate);
			txtLyr.shift();
		}
		if (FlxG.keys.justPressed.R)
		{
			music.time = 0;
		}
		if (FlxG.keys.justPressed.Z)
		{
			zoomBeat -= 1;
			if (zoomBeat < 1)
				zoomBeat = 1;
		}
		if (FlxG.keys.justPressed.X)
		{
			zoomBeat += 1;
		}
		FlxG.watch.addQuick("step", music.stepBeat);
		FlxG.watch.addQuick("beat", music.beat);
		FlxG.watch.addQuick("time", music.time);
		FlxG.camera.zoom = FlxMath.lerp(FlxG.camera.zoom, 1, 0.45);
		if (FlxG.keys.justPressed.SPACE)
		{
			music.playing ? music.pause() : music.play();
		}
		super.update(elapsed);
	}
}
