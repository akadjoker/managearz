package ;

import flash.Lib;
import manaGearz.manager.Manager;

import flash.display.Bitmap;
import flash.media.Sound;

/**
 * ...
 * @author alijaya
 */

class Main 
{
	static function main()
	{
		#if embed
		
		// Doing this if use embed
		// need reference to swf file in Reference and json file (contains data structure) in Reference
		Manager.embed.load("swf", "json", complete);
		
		#else
		
		// Doing this if use loader
		// need json path (contains data structure)
		Manager.loader.load("assets.json", complete);
		
		#end
	}
	
	static function complete() 
	{
		trace("complete!");
		
		// Try get the hello/sound.mp3
		// without extension
		// it is flash.media.Sound
		var sound:Sound = Manager.data.getStr("hello.sound");
		sound.play();
		
		// Try get the hello/text.txt
		// you can do this with array
		// it is String
		var text:String = Manager.data.get(["hello","text"]);
		trace(text);
		
		// Try get the world/graphic.png
		// it is flash.display.Bitmap
		var graphic:Bitmap = Manager.data.getStr("world.graphic");
		graphic.y = 100;
		Lib.current.addChild(graphic);
		
		// Try get the world/!ReadMe.txt
		// It doesn't work, it's not loaded *as expected
		var readme:String = Manager.data.getStr("world.!ReadMe");
		trace(readme);
		
		// Try get the world/#reference.txt
		// It doesn't work, it's loaded but not stored
		var reference:String = Manager.data.getStr("world.reference");
		trace(reference);
		
		// Try get the hello/json.json
		// reference in json can be done (the file with '#')
		// it is Dynamic
		var json:Dynamic = Manager.data.getStr("hello.json");
		trace(json);
	}
}