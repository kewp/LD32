package ;

import flixel.FlxG;
import flixel.util.FlxPoint;
import flixel.FlxSprite;
import flixel.group.FlxTypedGroup;
import flixel.addons.text.FlxTypeText;
import flixel.util.FlxDestroyUtil;
import flixel.FlxCamera;

using flixel.util.FlxSpriteUtil;

class Talk extends FlxTypedGroup<FlxSprite>
{
	private var _back:FlxSprite;
	private var _type:FlxTypeText;

	public function new(text:String="Who deserves love?")
	{
		super();

		_back = new FlxSprite().makeGraphic(FlxG.width,FlxG.height,0xff131c1b);
		_back.screenCenter(true,true);
		_back.scrollFactor.set();		// not effected by camera

		_type = new FlxTypeText(_back.x+15,_back.x+10,FlxG.width-30,text);
		_type.delay = 0.1;
		_type.showCursor = true;
		_type.cursorBlinkSpeed = 1.0;
		_type.prefix = "> ";
		_type.waitTime = 2.0;
		_type.setTypingVariation(0.75, true);
		_type.color = 0x8811EE11;
		_type.skipKeys = ["SPACE"];
		_type.start();
		_type.scrollFactor.set();		// not effected by camera

		add(_back);
		add(_type);
	}

	override public function destroy()
	{
		super.destroy();
		_back = FlxDestroyUtil.destroy(_back);
		_type = FlxDestroyUtil.destroy(_type);
	}
}