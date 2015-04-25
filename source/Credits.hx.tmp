package ;

import flixel.FlxState;
import flixel.FlxG;
import flixel.text.FlxText;
using flixel.util.FlxSpriteUtil;

class Credits extends FlxState
{
	override public function create():Void
	{
		var _title = new FlxText(0,20,0,"Credits",30);
		_title.alignment = "center";
		_title.screenCenter(true,false);

		var _credits = new FlxText(20,80,0,
"Coded with HaxeFlixel
Base from haxeflixel.com 
  dunegon crawler tut
Terminal from FlxTypeText 
  demo",16);
		_credits.alignment = "left";

		add(_title);
		add(_credits);
	}

	override public function update():Void
	{
		if (FlxG.keys.anyJustPressed(["ESCAPE","ENTER","SPACE"]) || FlxG.mouse.justPressed)
		{
			FlxG.switchState(new Menu());
		}
	}
}