//
//  Preloader.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 6/11/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package manaGearz.preloader;
import flash.Lib;
import flash.events.Event;
import flash.display.Sprite;
import flash.display.MovieClip;
import flash.display.Loader;

class Preloader 
{
	var mainClass:String;
	
	var loader:Loader;
	
	var sprite:Sprite;
	
	var current:MovieClip;
	
	public function new(mainClass:String)
	{
		this.mainClass = mainClass;
		
		current = Lib.current;
		
		sprite = new Sprite();
		
		current.addChild(sprite);
		
		current.addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	
	function onEnterFrame(e:Event)
	{
		var total = current.loaderInfo.bytesTotal;
		var loaded = current.loaderInfo.bytesLoaded;
		
		progress(loaded, total);
		
		if(loaded == total)
		{
			current.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			loader = new Loader();
			loader.loadBytes(Type.createInstance(Type.resolveClass(mainClass),[]), new flash.system.LoaderContext(new flash.system.ApplicationDomain()));
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
		}
	}
	
	function onComplete(e:Event)
	{
		loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onComplete);
		
		complete();
	}
	
	function progress(loaded:Int, total:Int) // progressing here
	{
		
	}
	
	function complete()
	{
		current.removeChild(sprite);
		
		current.addChild(loader);
	}
}