package ;

import flixel.FlxState;
import flixel.FlxG;

class Credits extends FlxState
{
	override public function update():Void
	{
		if (FlxG.keys.anyJustPressed(["ESCAPE","ENTER","SPACE"]))
		{
			FlxG.switchState(new Menu());
		}
	}
}