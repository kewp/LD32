package ;

import flixel.FlxState;
import flixel.FlxG;
import flixel.text.FlxText;
using flixel.util.FlxSpriteUtil;

class Credits extends FlxState
{
	private var _title:FlxText;
	private var _haxe:FlxText;
	private var _tut:FlxText;
	private var _term:FlxText;

	override public function create():Void
	{
		_title = new FlxText(0,20,0,"Credits", 22);
		_title.alignment = "center";
		_title.screenCenter(true,false);

		_haxe = new FlxText(0,100,0,"Coded with HaxeFlixel", 22);
		_haxe.alignment = "center";
		_haxe.screenCenter(true,false);

		_tut = new FlxText(0,150,0,"Base from haxeflixel.com tut", 22);
		_tut.alignment = "center";
		_tut.screenCenter(true,false);

		_term = new FlxText(0,200,0,"Terminal from FlxTypeText demo", 22);
		_term.alignment = "center";
		_term.screenCenter(true,false);

		add(_title);
		add(_haxe);
		add(_tut);
		add(_term);
	}

	override public function update():Void
	{
		if (FlxG.keys.anyJustPressed(["ESCAPE","ENTER","SPACE"]) || FlxG.mouse.justPressed)
		{
			FlxG.switchState(new Menu());
		}
	}
}