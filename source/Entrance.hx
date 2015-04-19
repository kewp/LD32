package ;

import flixel.FlxObject;
import flixel.FlxSprite;

class Entrance extends FlxSprite
{
	public var map:String;

	public function new(_map:String,x:Int,y:Int)
	{
		super(x,y);
		map = _map;
		loadGraphic("assets/images/entrance.png",false,32,32);
		immovable=true;
	}
}