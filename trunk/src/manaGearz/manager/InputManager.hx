//
//  InputManager.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 2/25/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package manaGearz.manager;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;
import flash.Lib;

class InputManager 
{
	public static var inited:Bool = false;
	
	private static var _instance : InputManager;
	public static var instance(get_instance, null) : InputManager;
	public static function get_instance() : InputManager
	{
		if (_instance == null) _instance = new InputManager();
		return _instance;
	}
	
	public var lookups(default, null):Hash<Int>;
	public var keys(default, null):Array<KeyState>;
	
	public var lastPressed(default, null):Int;
	public var lastReleased(default, null):Int;
	
	public var capsLock(get_capsLock, null):Bool;
	public var numLock(get_numLock, null):Bool;
	
	public var mouseLeave(default, null):Bool;
	
	public var mouseDown(default, null):Bool;
	public var mousePressed(default, null):Bool;
	public var mouseUp(default, null):Bool;
	public var mouseReleased(default, null):Bool;
	
	public var mouseX(get_mouseX, null):Float;
	public var mouseY(get_mouseY, null):Float;
	public var wheelDelta(default, null):Int;
	
	private function new()
	{
		mouseDown = false;
		mousePressed = false;
		mouseUp = true;
		mouseReleased = false;
		
		wheelDelta = 0;
		
		lookups = new Hash<Int>();
		keys = new Array<KeyState>();
		
		for(n in 0...256)
		{
			keys.push(KeyState.UP(false));
		}
		
		
		// Special Key
		addKey("BACKSPACE", 8);
		addKey("TAB",       9);
		addKey("ENTER",     13);
		addKey("SHIFT",     16);
		addKey("CONTROL",   17);
		addKey("CAPS_LOCK", 20);
		addKey("ESCAPE",    27);
		
		addKey("SPACE", 32);
		
		// Navigation Key
		addKey("PAGE_UP",   33);
		addKey("PAGE_DOWN", 34);
		addKey("END",       35);
		addKey("HOME",      36);
		
		// Direction Key
		addKey("LEFT",  37);
		addKey("UP",    38);
		addKey("RIGHT", 39);
		addKey("DOWN",  40);
		
		addKey("INSERT", 45);
		addKey("DELETE", 46);
		
		// Number Key
		for(n in 0...10)
		{
			addKey(""+n, 48+n);
		}
		
		// Letter Key
		for(n in 0...26)
		{
			addKey(String.fromCharCode(65+n), 65+n);
		}
		
		// Numpad Key
		for(n in 0...10)
		{
			addKey("NUMPAD_"+n, 96+n);
		}
		
		addKey("NUMPAD_MULTIPLY", 106);
		addKey("NUMPAD_ADD",      107);
		addKey("NUMPAD_ENTER",    108);
		addKey("NUMPAD_SUBTRACT", 109);
		addKey("NUMPAD_DECIMAL",  110);
		addKey("NUMPAD_DIVIDE",   111);
		
		// Function Key
		for(n in 0...15)
		{
			addKey("F"+(n+1), 112+n);
		}
		
		// Punctuation Key
		addKey("SEMICOLON", 186);
		addKey(";",         186);
		addKey("EQUAL",     187);
		addKey("=",         187);
		addKey("COMMA",     188);
		addKey(",",         188);
		addKey("MINUS",     189);
		addKey("-",         189);
		addKey("PERIOD",    190);
		addKey(".",         190);
		addKey("SLASH",     191);
		addKey("/",         191);
		addKey("BACKQUOTE", 192);
		addKey("`",         192);
		
		addKey("LEFTBRACKET",  219);
		addKey("[",            219);
		addKey("BACKSLASH",    220);
		addKey("\\",           220);
		addKey("RIGHTBRACKET", 221);
		addKey("]",            221);
		addKey("QUOTE",        222);
		addKey("'",            222);
		
		
		
		Lib.current.addEventListener(Event.ADDED_TO_STAGE, onStage);
	}
	
	public function update()
	{
		mousePressed = false;
		mouseReleased = false;
		
		wheelDelta = 0;
		
		for(n in 0...keys.length)
		{
			keys[n] = switch(keys[n])
			{
				case DOWN(_): KeyState.DOWN(false);
				case UP(_): KeyState.UP(false);
			}
		}
	}
	
	public function onStage(_)
	{
		Lib.current.removeEventListener(Event.ADDED_TO_STAGE, onStage);
		
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
		
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);
		Lib.current.stage.addEventListener(Event.MOUSE_LEAVE, mouseLeaveHandler);
		
		inited = true;
	}
	
	function addKey(keyName:String, keyCode:Int)
	{
		lookups.set(keyName, keyCode);
	}
	
	function keyDownHandler(e:KeyboardEvent)
	{
		switch(keys[e.keyCode])
		{
			case UP(_) : keys[e.keyCode] = KeyState.DOWN(true);
			default :
		}
		lastPressed = e.keyCode;
	}
	
	function keyUpHandler(e:KeyboardEvent)
	{
		switch(keys[e.keyCode])
		{
			case DOWN(_) : keys[e.keyCode] = KeyState.UP(true);
			default :
		}
		lastReleased = e.keyCode;
	}
	
	function mouseDownHandler(e:MouseEvent)
	{
		mouseDown = true;
		mousePressed = true;
		mouseUp = false;
		mouseReleased = false;
	}
	
	function mouseUpHandler(e:MouseEvent)
	{
		mouseDown = false;
		mousePressed = false;
		mouseUp = true;
		mouseReleased = true;
	}
	
	function mouseWheelHandler(e:MouseEvent)
	{
		wheelDelta = e.delta;
	}
	
	function mouseLeaveHandler(e:Event)
	{
		mouseLeave = true;
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
	}
	
	function mouseMoveHandler(e:MouseEvent)
	{
		Lib.current.stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
		mouseLeave = false;
	}
	
	public function isDown(key:String) : Bool
	{
		return switch(keys[getKeyCode(key)])
		{
			case DOWN(_) : true;
			default : false;
		}
	}
	
	public function isPressed(key:String) : Bool
	{
		return switch(keys[getKeyCode(key)])
		{
			case DOWN(pressed) : pressed;
			default : false;
		}
	}
	
	public function isUp(key:String) : Bool
	{
		return switch(keys[getKeyCode(key)])
		{
			case UP(_) : true;
			default : false;
		}
	}
	
	public function isReleased(key:String) : Bool
	{
		return switch(keys[getKeyCode(key)])
		{
			case UP(released) : released;
			default : false;
		}
	}
	
	public inline  function get_capsLock() : Bool
	{
		return Keyboard.capsLock;
	}
	
	public inline function get_numLock() : Bool
	{
		return Keyboard.numLock;
	}
	
	public inline function get_mouseX() : Float
	{
		return Lib.current.mouseX;
	}
	
	public inline function get_mouseY() : Float
	{
		return Lib.current.mouseY;
	}
	
	public function getKeyCode(key:String) : Int
	{
		key = key.toUpperCase();
		var code = lookups.get(key);
		if(code == null) throw "Error : the key \""+key+"\" doesn't exist";
		return code;
	}
}

enum KeyState
{
	UP(released:Bool);
	DOWN(pressed:Bool);
}