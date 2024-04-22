package;

class BPMSound extends FlxSound
{
	public var bpm(default, set):Int = 0;
	public var beat(get, null):Float = 1;
	public var stepBeat(get, null):Float = 1;

	private var crochet:Float;
	private var stepCrochet:Float;

	public var localTime:Float = 0;

	public function set_bpm(value:Int):Int
	{
		bpm = value;
		crochet = (60 / bpm) * 1000;
		stepCrochet = crochet / 4;
		console.log("Changed BPM to " + bpm + " with crochet " + crochet + " and stepCrochet " + stepCrochet);

		return bpm = value;
	}

	public function get_stepBeat():Float
	{
		if (crochet == 0)
			return 0;
		if (!playing)
			return 0;
		var oldStep = stepBeat;
		stepBeat = Math.floor(localTime / stepCrochet);

		if (oldStep != stepBeat)
			stepHit(Math.floor(Math.abs(stepBeat)));
		return stepBeat;
	}

	public function get_beat():Float
	{
		var oldBeat = beat;
		beat = Math.floor(stepBeat / 4);
		if (oldBeat != beat)
			beatHit(Math.floor(Math.abs(beat)));
		return beat;
	}

	public function updateSong()
	{
		update(FlxG.elapsed);
		localTime += FlxG.elapsed * 1000;
		if (Math.abs(localTime - time) > 200)
		{
			localTime = time;
		}
		stepBeat = get_stepBeat();
		beat = get_beat();
	}

	public dynamic function beatHit(beat:Int) {}

	public dynamic function stepHit(step:Int) {}
}
