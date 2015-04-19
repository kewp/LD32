package ;

import flixel.FlxSprite;

class Terminal extends FlxSprite
{
	public var name:String;

	public function new(_name:String,x:Int,y:Int)
	{
		super(x,y);
		name = _name;
		loadGraphic("assets/images/terminal.png",true,32,32);
		animation.add("ping",[0,1,2,1],6,true);
		animation.play("ping");
		immovable=true;
	}
}