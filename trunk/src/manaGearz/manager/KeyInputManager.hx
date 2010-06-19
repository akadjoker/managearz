//
//  InputManager.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 2/25/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package manaGearz.manager;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;
import flash.Lib;

class KeyInputManager 
{
	private static var inited:Bool = false;
	
	private static var _instance : KeyInputManager;
	public static var instance(get_instance, null) : KeyInputManager;
	public static function get_instance() : KeyInputManager
	{
		if (_instance == null) _instance = new KeyInputManager();
		if(!inited) _instance.init();
		return _instance;
	}
	
	public var keyInputs(default, null):IntHash<Void->Void>;
	public var keyDowns(default, null):IntHash<Void>;
	
	private function new()
	{
		keyInputs = new IntHash<Void->Void>();
		keyDowns = new IntHash<Void>();
		init();
	}
	
	public function init()
	{
		if(Lib.current.stage==null) return;
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
		inited = true;
	}
	
	private function keyDownHandler(e:KeyboardEvent)
	{
		if(!keyDowns.exists(e.keyCode))
		{
			keyDowns.set(e.keyCode, null);
			var f:Void->Void = keyInputs.get(e.keyCode);
			if(f!=null) f();
		}
	}
	
	private function keyUpHandler(e:KeyboardEvent)
	{
		keyDowns.remove(e.keyCode);
	}
	
	public function isDown(key:String) : Bool
	{
		return keyDowns.exists(getKeyCode(key));
	}
	
	public function isCapsLock() : Bool
	{
		return Keyboard.capsLock;
	}
	
	public function isNumLock() : Bool
	{
		return Keyboard.numLock;
	}
	
	public function reset()
	{
		for(n in keyInputs.keys())
		{
			keyInputs.remove(n);
		}
	}
	
	public function addInputs(keys:Hash<Void->Void>)
	{
		for(n in keys.keys())
		{
			addInput(n, keys.get(n));
		}
	}
	
	public function addInput(key:String, func:Void->Void)
	{
		keyInputs.set(getKeyCode(key), func);
	}
	
	public function removeInput(key:String)
	{
		keyInputs.remove(getKeyCode(key));
	}
	
	public function getKeyCode(key:String) : Int
	{
		key = key.toUpperCase();
		return switch(key)
		{
			case "BACKSPACE":	8;
			case "TAB":			9;
			case "ENTER":		13;
			case "SHIFT":		16;
			case "CONTROL":		17;
			case "CAPS_LOCK":	20;
			case "ESCAPE":		27;
			
			case "SPACE":		32;
			
			case "PAGE_UP":		33;
			case "PAGE_DOWN":	34;
			case "END":			35;
			case "HOME":		36;
			
			case "LEFT":	37;
			case "UP":		38;
			case "RIGHT":	39;
			case "DOWN":	40;
			
			case "INSERT":	45;
			case "DELETE":	46;
			
			case "NUMPAD_0":	96;
			case "NUMPAD_1":	97;
			case "NUMPAD_2":	98;
			case "NUMPAD_3":	99;
			case "NUMPAD_4":	100;
			case "NUMPAD_5":	101;
			case "NUMPAD_6":	102;
			case "NUMPAD_7":	103;
			case "NUMPAD_8":	104;
			case "NUMPAD_9":	105;
			
			case "NUMPAD_MULTIPLY":	106;
			case "NUMPAD_ADD":		107;
			case "NUMPAD_ENTER":	108;
			case "NUMPAD_SUBTRACT":	109;
			case "NUMPAD_DECIMAL":	110;
			case "NUMPAD_DIVIDE":	111;
			
			case "F1":	112;
			case "F2":	113;
			case "F3":	114;
			case "F4":	115;
			case "F5":	116;
			case "F6":	117;
			case "F7":	118;
			case "F8":	119;
			case "F9":	120;
			case "F10":	121;
			case "F11":	122;
			case "F12":	123;
			case "F13":	124;
			case "F14":	125;
			case "F15":	126;
			
			case "SEMICOLON", ";":		186;
			case "EQUAL", "=":			187;
			case "COMMA", ",":			188;
			case "MINUS", "-":			189;
			case "PERIOD", ".":			190;
			case "SLASH", "/":			191;
			case "BACKQUOTE", "`":		192;
			case "LEFTBRACKET", "[":	219;
			case "BACKSLASH", "\\":		220;
			case "RIGHTBRACKET", "]":	221;
			case "QUOTE", "'":			222;
			
			default: key.charCodeAt(0);
		}
	}
}