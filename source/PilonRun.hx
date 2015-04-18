package ;

import flixel.FlxG;
import flixel.tile.FlxTilemap;
import flixel.FlxCamera;
import flixel.FlxState;

class PilonRun extends FlxState
{
	private var _player:Player;
	private var _map:TiledLoader;
	private var _mGround:FlxTilemap;

	override public function create():Void
	{
		_map = new TiledLoader("assets/data/pilon.tmx");
		_mGround = _map.loadTilemap("assets/images/ground_extra.png",16,16,"ground");
		add(_mGround);

		_player = new Player();
		_map.loadEntities(placeEntities,"entities");
		add(_player);

		FlxG.camera.follow(_player, FlxCamera.STYLE_TOPDOWN,1);

		super.create();
	}

	private function placeEntities(entityName:String, entityData:Xml):Void
	{
		var x = Std.parseInt(entityData.get("x"));
		var y = Std.parseInt(entityData.get("y"));

		if (entityName == "player")
		{
			_player.x = x;
			_player.y = y;
		}
	}

	override public function update():Void
	{
		super.update();

		FlxG.collide(_player,_mGround);
	}
}