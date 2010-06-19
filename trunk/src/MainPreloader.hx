package ;

import manaGearz.preloader.Preloader;
import flash.Lib;


/**
 * ...
 * @author alijaya
 */

class MainPreloader extends Preloader
{
	static function main()
	{
		new MainPreloader();
	}
	
	public function new()
	{
		super("manaGearz");
	}
	
	override function progress(loaded:Int, total:Int)
	{
		var w = Lib.current.stage.stageWidth;
		var h = Lib.current.stage.stageHeight;
		var g = sprite.graphics;
		
		g.clear();
		g.beginFill(0xFF0000);
		g.drawRect(0,h-20,w*loaded/total,20);
	}
}