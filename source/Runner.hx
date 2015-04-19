package ;

import flixel.FlxG;
import flixel.tile.FlxTilemap;
import flixel.FlxCamera;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.addons.text.FlxTypeText;

using flixel.util.FlxSpriteUtil;

class Runner extends FlxState
{
	private var _player:Player;
	private var _map:String;
	private var _mGround:FlxTilemap;
	private var _terminals:FlxTypedGroup<Terminal>;
	private var _talk:Talk;
	private var _talking:Bool = false;

	override public function create():Void
	{
		
		var _tiled = new TiledLoader("assets/data/map.tmx");
		_mGround = _tiled.loadTilemap("assets/images/ground_extra.png",16,16,"ground");
		add(_mGround);

		_player = new Player();
		_terminals = new FlxTypedGroup<Terminal>();
		add(_terminals);

		_tiled.loadEntities(placeEntities,"entities");

		add(_player);

		if(_talk==null) _talk = new Talk("Mark ran straight for the west pilon ...");
		add(_talk);

		super.create();
	}

	private function placeEntities(entityData:Xml):Void
	{
		var name = entityData.get("name");
		var type = entityData.get("type");
		var x = Std.parseInt(entityData.get("x"));
		var y = Std.parseInt(entityData.get("y"));

		if (type == "player")
		{
			_player.x = x;
			_player.y = y;
		}
		else if (type == "terminal")
		{
			_terminals.add(new Terminal(name,x,y));
		}
	}

	override public function update():Void
	{
		if(_talk==null)
		{
			FlxG.overlap(_player,_terminals,playerOverlapTerminal);
			FlxG.collide(_player,_terminals);
		}
		else if(FlxG.keys.anyJustPressed(["ENTER"])||FlxG.mouse.justPressed)
		{
			_talk = flixel.util.FlxDestroyUtil.destroy(_talk);
			FlxG.camera.follow(_player, FlxCamera.STYLE_TOPDOWN, 1);
			_player.active = true;
		}

		super.update();
	}

	private function playerOverlapTerminal(player:Player,term:Terminal):Void
	{
		_player.active = false;
		_talk = new Talk(term.text);
		add(_talk);
	}
}