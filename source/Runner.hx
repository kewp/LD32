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

class Runner extends FlxState
{
	private var _player:Player;
	private var _map:String;
	private var _mGround:FlxTilemap;
	private var _terminals:FlxTypedGroup<Terminal>;
	private var _text:FlxTypeText;
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

		FlxG.camera.follow(_player, FlxCamera.STYLE_TOPDOWN,1);

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
		if(_talking && (FlxG.keys.anyJustPressed(["ENTER"])||FlxG.mouse.justPressed))
		{
			_text.destroy();
			_talking = false;
		}

		FlxG.overlap(_player,_terminals,playerOverlapTerminal);
		FlxG.collide(_player,_terminals);

		super.update();
	}

	private function playerOverlapTerminal(player:Player,term:Terminal):Void
	{
		_text = new FlxTypeText(15,10,FlxG.width-30,term.name);

		_text.delay = 0.1;
		_text.showCursor = true;
		_text.cursorBlinkSpeed = 1.0;
		_text.prefix = "> ";
		_text.waitTime = 2.0;
		_text.setTypingVariation(0.75, true);
		_text.color = 0x8811EE11;
		_text.skipKeys = ["SPACE"];

		add(_text);

		_talking = true;
		_text.start();
	}
}