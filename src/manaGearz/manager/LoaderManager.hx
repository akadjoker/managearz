//
//  LoaderManager.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 1/17/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package manaGearz.manager;
import flash.display.Loader;
import flash.events.Event;
import flash.events.SampleDataEvent;
import flash.media.Sound;
import flash.net.URLRequest;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;

import haxe.io.Bytes;

import hxjson2.JSON;

class LoaderManager 
{
	private static var _instance : LoaderManager;
	public static var instance(get_instance, null) : LoaderManager;
	public static function get_instance() : LoaderManager
	{
		if (_instance == null) _instance = new LoaderManager();
		return _instance;
	}
	
	var basePath:String;
	
	var loaderSet:URLLoader;
	
	var jsons:Array<{path:String, json:Dynamic, finished:Bool}>;
	
	var temporaryPath:Array<String>;
	
	var count:Int;
	
	private var complete : Dynamic;
	
	public function new()
	{
		
	}
	
	function callComplete()
	{
		//trace(Manager.data.getTree([]));
		// json extension
		for(json in jsons)
		{
			if(json.finished) continue;
			checkJSON(json);
		}
		
		// remove temporary
		for(n in temporaryPath)
		{
			Manager.data.removeStr(n);
		}
		temporaryPath = null;
		
		if(complete!=null) complete();
		complete==null;
	}
	
	public function load(baseFile:String, complete:Dynamic)
	{
		count = 0;
		jsons = [];
		temporaryPath = [];
		basePath = baseFile.substr(0,baseFile.lastIndexOf("/")+1);
		this.complete = complete;
		loaderSet = new URLLoader(new URLRequest(baseFile));
		loaderSet.addEventListener(Event.COMPLETE, onSetCom, false, 0, true);
	}
	
	private function onSetCom(_)
	{
		var d = JSON.decode(loaderSet.data);
		basePath += d.name;
		loadDir(d.files, "", false);
	}
	
	private function loadDir(a:Array<Dynamic>, curPath:String, temporary:Bool)
	{
		var dataPath = curPath.split("/").join(".").substr(1);
		if(temporary) temporaryPath.push(dataPath);
		for(n in a)
		{
			if(Std.is(n, String))
			{
				loadFile(basePath+curPath+"/"+n, dataPath+"."+n.substr(0, n.lastIndexOf(".")), (!temporary&&n.charAt(0)=="#"));
			} else
			{
				loadDir(n.files, curPath+"/"+n.name, (!temporary&&n.name.charAt(0)=="#"));
			}
		}
	}
	
	private function startLoad()
	{
		count++;
	}
	
	private function endLoad()
	{
		count--;
		if(count==0) callComplete();
	}
	
	private function loadFile(path:String, dataPath:String, temporary:Bool)
	{
		//trace(dataPath+" "+count);
		if(temporary) temporaryPath.push(dataPath);
		startLoad();
		var ext = path.substr(path.lastIndexOf(".")+1);
		ext = ext.toLowerCase();
		var req = new URLRequest(path);
		switch(ext)
		{
			case "jpg", "jpeg", "png", "gif": loadImage(path, dataPath);
			case "mp3": loadSound(path, dataPath);
			case "txt": loadText(path, dataPath);
			case "json": loadJSON(path, dataPath);
			default: loadBinary(path, dataPath);
		}
	}
	
	private function loadImage(path:String, dataPath:String)
	{
		var loader:Loader = new Loader();
		loader.contentLoaderInfo.addEventListener(Event.COMPLETE, callback(onImgCom, dataPath), false, 0, true);
		loader.load(new URLRequest(path));
	}
	
	private function onImgCom(dataPath:String, e:Event)
	{
		//trace("image");
		Manager.data.setStr(dataPath, e.target.content);
		endLoad();
		//trace("end "+dataPath+" "+count);
	}
	
	private function loadSound(path:String, dataPath:String)
	{
		var sound:Sound = new Sound();
		sound.addEventListener(Event.COMPLETE, callback(onSndCom, dataPath), false, 0, true);
		sound.load(new URLRequest(path));
	}
	
	private function onSndCom(dataPath:String, e:Event) // todo
	{
		//trace("sound");
		Manager.data.setStr(dataPath, e.target);
		endLoad();
		//trace("end "+dataPath+" "+count);
	}
	
	private function loadText(path:String, dataPath:String)
	{
		var urlLoader:URLLoader = new URLLoader();
		urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
		urlLoader.addEventListener(Event.COMPLETE, callback(onTxtCom, dataPath), false, 0, true);
		urlLoader.load(new URLRequest(path));
	}
	
	private function onTxtCom(dataPath:String, e:Event)
	{
		//trace("text");
		Manager.data.setStr(dataPath, e.target.data);
		endLoad();
		//trace("end "+dataPath+" "+count);
	}
	
	private function loadBinary(path:String, dataPath:String)
	{
		var urlLoader:URLLoader = new URLLoader();
		urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
		urlLoader.addEventListener(Event.COMPLETE, callback(onBinCom, dataPath), false, 0, true);
		urlLoader.load(new URLRequest(path));
	}
	
	private function onBinCom(dataPath:String, e:Event)
	{
		//trace("binary");
		Manager.data.setStr(dataPath, e.target.data);
		endLoad();
		//trace("end "+dataPath+" "+count);
	}
	
	private function loadJSON(path:String, dataPath:String)
	{
		var urlLoader:URLLoader = new URLLoader();
		urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
		urlLoader.addEventListener(Event.COMPLETE, callback(onJSONCom, dataPath), false, 0, true);
		urlLoader.load(new URLRequest(path));
	}
	
	private function onJSONCom(dataPath:String, e:Event)
	{
		//trace("JSON");
		jsons.push({path:dataPath, json:JSON.decode(e.target.data), finished:false});
		endLoad();
		//trace("end "+dataPath+" "+count);
	}
	
	private function checkJSON(json:{path:String, json:Dynamic, finished:Bool})
	{
		Manager.data.setStr(json.path, checkJSONVal(json.json, json.path.substr(0, json.path.lastIndexOf("."))));
		json.finished = true;
	}
	
	private function checkJSONVal(v:Dynamic, curPath:String) : Dynamic
	{
		return if(Std.is(v, String))
		{
			checkJSONStr(v, curPath);
		} else if(Std.is(v, Array))
		{
			checkJSONArr(v, curPath);
		} else if(Reflect.isObject(v))
		{
			checkJSONObj(v, curPath);
		} else
		{
			v;
		}
	}
	
	private function checkJSONStr(s:String, curPath:String) : Dynamic
	{
		var f = s.charAt(0);
		return if(f=="@")
		{
			var path = s.substr(1, s.lastIndexOf(".")-1);
			path = path.split("/").join(".");
			if(path.charAt(0)=="$")
			{
				path = path.substr(2);
			} else
			{
				path = curPath+"."+path;
			}
			for(j in jsons)
			{
				if(j.path==path)
				{
					checkJSON(j);
					break;
				}
			}
			return Manager.data.getStr(path);
		}else if(f=="\\")
		{
			return s.substr(1);
		}else
		{
			return s;
		}
	}
	
	private function checkJSONArr(a:Array<Dynamic>, curPath:String) : Array<Dynamic>
	{
		for(n in 0...a.length)
		{
			a[n] = checkJSONVal(a[n], curPath);
		}
		return a;
	}
	
	private function checkJSONObj(o:Dynamic, curPath:String) : Dynamic
	{
		for(n in Reflect.fields(o))
		{
			Reflect.setField(o, n, checkJSONVal(Reflect.field(o, n), curPath));
		}
		return o;
	}
	
}