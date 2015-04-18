package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.text.FlxTypeText;

class Intro extends FlxState
{
	private var _typeText:FlxTypeText;

	override public function create():Void
	{
		FlxG.cameras.bgColor = 0xff131c1b;

		var square:FlxSprite = new FlxSprite(10,10);
		square.makeGraphic(FlxG.width-20, FlxG.height - 76, 0xff333333);

		_typeText = new FlxTypeText(15,10,FlxG.width-30,"Mark ran straight for the west pilon without stopping ... ");

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

		super.create();
	}

	override public function update():Void
	{
		if (FlxG.keys.justPressed.SPACE || FlxG.mouse.justPressed)
		{
			FlxG.switchState(new PilonRun());
		}

		super.update();
	}
}