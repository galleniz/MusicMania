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
	public static var song:Song;

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
		loadSong("whoneedsthebusboi");
		var border = new FlxSprite(0, 0);
		border.makeGraphic(1280, 720, 0xffffffff);
		add(border);
		border.graphic.bitmap.fillRect(new Rectangle(10, 10, 1260, 700), 0x00000000);
		border.scale.scale(0.9, 0.9);
		border.updateHitbox();
		border.screenCenter();
		music.play();
	}

	function loadSong(song:String)
	{
		var _songData = Song.SongParser.parser(song);
		PlayState.song = _songData;
		music = new BPMSound();
		music.group = FlxG.sound.defaultMusicGroup;
		FlxG.sound.defaultMusicGroup.add(music);
		music.loadEmbedded(_songData.path + "inst.ogg");
		music.bpm = _songData.bpm;
		music.beatHit = function(beat:Int)
		{
			FlxG.camera.zoom += 0.015;
		}
	}

	public override function destroy()
	{
		super.destroy();
		music.destroy();
	}

	public var lyrics:Array<Lyrics>;

	public function addLyricText(lyric:String, translate:String = null)
	{
		if (lyrics == null)
			lyrics = new Array<Lyrics>();
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
			lyrics.push(l2);
			@:privateAccess l2.parent = lyrics;
			l2.screenCenter();
			l2.y += 260;
			l2.size = 14;
			l2.color = 0xff848d33;
			add(l2);
		}
	}

	override public function update(elapsed:Float)
	{
		music.updateSong();
		var debug = window.DebugMetrics;
		window.DebugMetrics.setValue("BPM", music.bpm);
		window.DebugMetrics.setValue("Time", music.time + '(${music.localTime})');
		window.DebugMetrics.setValue("Beat", music.beat);
		window.DebugMetrics.setValue("Step", music.stepBeat);

		var lir = song.lyrics.lyrics[0];
		if (lir != null)
			window.DebugMetrics.setValue("Next Lyric", lir.text);
		if (lir != null && music.time >= lir.start - 25)
		{
			lir.start = music.time;
			addLyricText(lir.text, null);
			song.lyrics.lyrics.shift();
		}
		FlxG.camera.zoom = FlxMath.lerp(FlxG.camera.zoom, 1, 0.45);
		super.update(elapsed);
	}
}
