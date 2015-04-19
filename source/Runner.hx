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
	private var _mGround:FlxTilemap;
	private var _terminals:FlxTypedGroup<Terminal>;
	private var _entrances:FlxTypedGroup<Entrance>;
	private var _talk:Talk;
	private var _talking:Bool = false;

	private var _map:String;
	private var _prevMap:String; // map we just came from

	public function new(map:String,prevMap:String=null)
	{
		super();
		_map = map;
		_prevMap = prevMap;
	}

	override public function create():Void
	{
		var _tiled = new TiledLoader("assets/data/"+_map+".tmx");
		_mGround = _tiled.loadTilemap("assets/images/"+_map+"_extra.png","ground");
		_mGround.setTileProperties(1,FlxObject.NONE);
		_mGround.setTileProperties(2,FlxObject.ANY);
		add(_mGround);

		_player = new Player();
		_terminals = new FlxTypedGroup<Terminal>();
		_entrances = new FlxTypedGroup<Entrance>();
		add(_terminals);
		add(_entrances);

		_tiled.loadEntities(placeEntities,"entities");

		if(_prevMap!=null)
			for (e in _entrances)
				if (e.map==_prevMap) // entrance points to map we just came from
				{
					_player.x = e.x + e.width/2;
					_player.y = e.y + e.height + 100;
					add(_player);
					FlxG.collide(_player,e);
				}

		if(_talk==null&&_prevMap==null)
		{
			_talk = new Talk("Mark ran straight for the west pilon ...");
			add(_talk);
		}
		else
			FlxG.camera.follow(_player, FlxCamera.STYLE_TOPDOWN, 1);

		super.create();
	}

	private function placeEntities(xml:Xml):Void
	{
		var name = xml.get("name");
		var type = xml.get("type");
		var x = Std.parseInt(xml.get("x"));
		var y = Std.parseInt(xml.get("y"));

		if (type == "player")
		{
			_player.x = x;
			_player.y = y;
			add(_player);
		}
		else if (type == "terminal") _terminals.add(new Terminal(name,x,y));
		else if (type == "entrance") _entrances.add(new Entrance(name,x,y));
	}

	override public function update():Void
	{
		if(_talk==null)
		{
			FlxG.overlap(_player,_terminals,playerTouchTerminal);
			FlxG.collide(_player,_terminals);
			FlxG.overlap(_player,_entrances,playerTouchEntrance);
			FlxG.collide(_player,_mGround);
		}
		else if(FlxG.keys.anyJustPressed(["ENTER"])||FlxG.mouse.justPressed)
		{
			_talk = flixel.util.FlxDestroyUtil.destroy(_talk);
			FlxG.camera.follow(_player, FlxCamera.STYLE_TOPDOWN, 1);
			_player.active = true;
		}

		super.update();
	}

	private function playerTouchTerminal(player:Player,term:Terminal):Void
	{
		_player.active = false;

		_talk = new Talk(term.text);
		add(_talk);
	}

	private function playerTouchEntrance(player:Player,entrance:Entrance):Void
	{
		FlxG.switchState(new Runner(entrance.map,_map));
	}
}