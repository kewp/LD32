package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.text.FlxTypeText;

class Talk extends FlxState
{
	private var _text:String;
	public var _runner:FlxState;

	private var _typeText:FlxTypeText;

	public function new(text:String="Who deserves love?",runner:FlxState=null)
	{
		super();

		_text = text;
		_runner = runner;
	}

	override public function create():Void
	{
		FlxG.cameras.bgColor = 0xff131c1b;

		_typeText = new FlxTypeText(15,10,FlxG.width-30,_text);

		_typeText.delay = 0.1;
		_typeText.eraseDelay = 0.2;
		_typeText.showCursor = true;
		_typeText.cursorBlinkSpeed = 1.0;
		_typeText.prefix = "> ";
		_typeText.autoErase = true;
		_typeText.waitTime = 2.0;
		_typeText.setTypingVariation(0.75, true);
		_typeText.color = 0x8811EE11;
		_typeText.skipKeys = ["SPACE"];

		add(_typeText);

		_typeText.start();

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
			if(_runner==null) FlxG.switchState(new Menu());
			else FlxG.switchState(_runner);
		}

		super.update();
	}
}