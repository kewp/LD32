package;

import flixel.FlxG;
import flixel.tile.FlxTilemap;
import haxe.xml.Fast;
import haxe.xml.Parser;
import openfl.Assets;

class TiledLoader
{
	private var _level:String;
	private var _xml:Xml;
	private var _fast:Fast;

	private var _width:Int;
	private var _height:Int;
	private var _tilewidth:Int;
	private var _tileheight:Int;

	public function new(level:String)
	{
		_level = level;
		_xml = Parser.parse(Assets.getText(level));
		_fast = new Fast(_xml.firstElement());

		_width = Std.parseInt(_fast.att.width);
		_height = Std.parseInt(_fast.att.height);
		_tilewidth = Std.parseInt(_fast.att.tilewidth);
		_tileheight = Std.parseInt(_fast.att.tileheight);

		FlxG.camera.setBounds(0,0,_width*_tilewidth,_height*_tileheight,true);
	}

	public function loadTilemap(path:String, layer:String):FlxTilemap
	{
		var tileMap:FlxTilemap = new FlxTilemap();

		var layerXml:Fast = null;
		for (_layerXml in _fast.nodes.layer)
			if(_layerXml.att.name==layer) layerXml = _layerXml;
		
		if (layerXml==null) throw ("No layer in "+_level+" named "+layer);

		var data:String = layerXml.node.data.innerData;

		tileMap.loadMap(data.substring(1,data.length-1),path,_tilewidth,_tileheight);

		return tileMap;
	}

	public function loadEntities(callback:Xml->Void, group:String):Void
	{
		for (g in _fast.nodes.objectgroup)
			if (g.att.name==group)
				for (e in g.elements)
					callback(e.x);
	}

	public function getObject(group:String,type:String):Xml
	{
		var object = null;
		for (g in _fast.nodes.objectgroup)
			if (g.att.name==group)
				for (e in g.elements)
					if (e.att.type==type) object = e.x;
		return object;
	}

	public function getObjects(group:String,type:String):Array<Xml>
	{
		var objects = new Array();
		for (g in _fast.nodes.objectgroup)
			if (g.att.name==group)
				for (e in g.elements)
					if (e.att.type==type) objects.push(e.x);
		return objects;
	}
}