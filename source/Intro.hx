package ;

import flixel.FlxG;
import flixel.FlxState;

class Intro extends FlxState
{
	private var _text:String;
	private var _talk:Talk;

	public function new(text:String="Who deserves love?")
	{
		super();

		_text = text;
	}

	override public function create():Void
	{
		_talk = new Talk(_text);
		add(_talk);

		if (FlxG.sound.music == null)
		{
			#if flash
			FlxG.sound.playMusic("assets/music/song.mp3",1,true);
			#else
			FlxG.sound.playMusic("assets/music/song.ogg",1,true);
			#end
		}

		super.create();
	}

	override public function update():Void
	{
		if (FlxG.keys.anyJustPressed(["SPACE","ENTER"]) || FlxG.mouse.justPressed)
		{
			FlxG.switchState(new Menu());
		}

		super.update();
	}

	override public function destroy():Void
	{
		_talk.destroy(); _talk = null;

		super.destroy();
	}
}