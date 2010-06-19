//
//  untitled.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 1/16/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package manaGearz.manager;

class DataManager 
{
	private static var _instance : DataManager;
	public static var instance(get_instance, null) : DataManager;
	public static function get_instance() : DataManager
	{
		if (_instance == null) _instance = new DataManager();
		return _instance;
	}
	
	private var data:Hash<Dynamic>;
	
	private function new()
	{
		data = new Hash<Dynamic>();
	}
	
	public function getDirStr(s:String) : Hash<Dynamic>
	{
		return getDir(s.split("."));
	}
	
	public function getDir(a:Array<String>) : Hash<Dynamic>
	{
		var c = data;
		for(n in 0...a.length)
		{
			var s = a[n];
			var h:Hash<Dynamic> = cast c.get(s);
			if(h == null)
			{
				h = new Hash<Dynamic>();
				c.set(s, h);
			}
			c = h;
		}
		return c;
	}
	
	public function setStr(s:String, d:Dynamic) : Dynamic
	{
		return set(s.split("."), d);
	}
	
	public function set(a:Array<String>, d:Dynamic) : Dynamic
	{
		var c = data;
		for(n in 0...a.length-1)
		{
			var s = a[n];
			var h:Hash<Dynamic> = cast c.get(s);
			if(h == null)
			{
				h = new Hash<Dynamic>();
				c.set(s, h);
			}
			c = h;
		}
		c.set(a[a.length-1], d);
	}
	
	public function getStr(s:String) : Dynamic
	{
		return get(s.split("."));
	}
	
	public function get(a:Array<String>) : Dynamic
	{
		var c = data;
		for(n in 0...a.length-1)
		{
			var s = a[n];
			var h:Hash<Dynamic> = cast c.get(s);
			if(h == null)
			{
				#if debug
				throw "can't search directory in "+a.join("/");
				#end
				return null;
			}
			c = h;
		}
		return c.get(a[a.length-1]);
	}
	
	public function removeStr(s:String)
	{
		remove(s.split("."));
	}
	
	public function remove(a:Array<String>)
	{
		var c = data;
		for(n in 0...a.length-1)
		{
			var s = a[n];
			var h:Hash<Dynamic> = cast c.get(s);
			if(h == null)
			{
				#if debug
				throw "can't search directory in "+a.join("/");
				#end
				return;
			}
			c = h;
		}
		c.remove(a[a.length-1]);
	}
	
	public function getTreeStr(s:String) : String
	{
		return getTree(s.split("."));
	}
	
	public function getTree(a:Array<String>) : String
	{
		var h:Hash<Dynamic> = getDir(a);
		var s:String = (a.length>0)?a[a.length-1]:"root";
		s+="\n";
		s+=getTreeSub(h, 0);
		return s;
	}
	
	private function getTreeSub(h:Hash<Dynamic>, depth:Int) : String
	{
		var s = "";
		var t = "";
		for(d in 0...depth+1) t+="\t";
		for(n in h.keys())
		{
			s+=t+n+"\n";
			var hs = h.get(n);
			if(Std.is(hs, Hash))
			{
				s+=getTreeSub(cast hs,depth+1);
			}
		}
		return s;
	}
}