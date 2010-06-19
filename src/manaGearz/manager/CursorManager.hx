/**
 * ...
 * @author alijaya
 */

package manaGearz.manager;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.Lib;
import flash.ui.Mouse;

import manaGearz.math.Point;

class CursorManager 
{
	private static var inited:Bool = false;
	
	private static var _instance : CursorManager;
	public static var instance(get_instance, null) : CursorManager;
	public static function get_instance() : CursorManager
	{
		if (_instance == null) _instance = new CursorManager();
		return _instance;
	}
	
	var cursorLibrary:Hash<CursorOffset>;
	
	public var curCursor(default, null):String;
	
	public var hide(default, null):Bool;
	
	public var position(default, null):Point;
	
	var cursorCO:CursorOffset;
	
	var container:Sprite;
	
	private function new() 
	{
		cursorLibrary = cast DataManager.instance.getDir(["manaGearz","cursor"]);
		setHide(false);
		position = {x:0.0, y:0.0};
		container = new Sprite();
		container.mouseEnabled = false;
		container.mouseChildren = false;
		container.visible = false;
	}
	
	public function update()
	{
		if(Manager.input.mouseLeave)
		{
			container.visible = false;
			return;
		}
		if(hide) Mouse.hide() else Mouse.show();
		position.x = Manager.input.mouseX;
		position.y = Manager.input.mouseY;
		
		container.visible = true;
		container.x = position.x;
		container.y = position.y;
	}
	
	public function setHide(hide:Bool)
	{
		this.hide = hide;
	}
	
	public function addCursor(name:String, cursor:DisplayObject, ?offset:Point)
	{
		if(offset==null) offset = {x:0.0,y:0.0};
		cursorLibrary.set(name, { cursor:cursor, offset:offset } );
	}
	
	public function setCursor(name:String)
	{
		if (!cursorLibrary.exists(name)) return;
		if(cursorCO != null) container.removeChild(cursorCO.cursor);
		curCursor = name;
		cursorCO = cursorLibrary.get(curCursor);
		cursorCO.cursor.x = cursorCO.offset.x;
		cursorCO.cursor.y = cursorCO.offset.y;
		container.addChild(cursorCO.cursor);
	}
}

typedef CursorOffset = {cursor:DisplayObject, offset:Point}