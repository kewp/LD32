package ;

#if desktop
import flash.system.System;
#end

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxDestroyUtil;
using flixel.util.FlxSpriteUtil;

class Menu extends FlxState
{
	private var _title:FlxText;
	private var _play:FlxText;
	private var _credits:FlxText;

	#if desktop
	private var _exit:FlxText;
	#end

	private var _pointer:FlxSprite;
	private var _select:Int = 1; // which menu item is selected
	private var _runner:FlxState;

	override public function create():Void
	{
		_title = new FlxText(0,20,0,"Terminal",22);
		_title.alignment = "center";
		_title.screenCenter(true,false);

		var start = 100;
		#if desktop start = 80; #end

		_play = new FlxText(0,start,0,"Play",22);
		_play.alignment = "center";
		_play.screenCenter(true,false);

		_credits = new FlxText(0,start+50,0,"Credits",22);
		_credits.alignment = "center";
		_credits.screenCenter(true,false);

		add(_title);
		add(_play);
		add(_credits);

		#if desktop
		_exit = new FlxText(0,start+100,0,"Exit",22);
		_exit.alignment = "center";
		_exit.screenCenter(true,false);
		add(_exit);
		#end

		_pointer = new FlxText(0,0,0,">",22);
		_pointer.x = _play.x - _pointer.width - 30;
		add(_pointer);

		super.create();
	}

	override public function update():Void
	{
		switch(_select)
		{
			case 1: _pointer.y = _play.y;
			case 2: _pointer.y = _credits.y;
			#if desktop case 3: _pointer.y = _exit.y; #end
		}

		if (FlxG.keys.justPressed.UP)
		{
			_select -= 1;
			if (_select<1) _select = 1;
		}

		if (FlxG.keys.justPressed.DOWN)
		{
			_select += 1;
			var max = 2;
			#if desktop max = 3; #end
			if (_select>max) _select = max;
		}

		if (FlxG.keys.anyJustPressed(["SPACE","ENTER"]))
		{
			switch(_select)
			{
				case 1:
					if(_runner==null) _runner = new Runner("grassy");
					FlxG.switchState(_runner);
				case 2: FlxG.switchState(new Credits());
				case 3: System.exit(0);
			}
		}

		#if desktop
		if (FlxG.keys.justPressed.ESCAPE) System.exit(0);
		#end
	}

	override public function destroy():Void
	{
		super.destroy();

		_title = FlxDestroyUtil.destroy(_title);
		_play = FlxDestroyUtil.destroy(_play);
		_credits = FlxDestroyUtil.destroy(_credits);
		#if desktop
		_exit = FlxDestroyUtil.destroy(_exit);
		#end
	}
}