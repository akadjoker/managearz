//
//  JSONBinaryReader.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 3/18/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package manaGearz.utils;

class JSONBinaryReader 
{
	var input : haxe.io.Input;
	
	public function new(i:haxe.io.Input)
	{
		input = i;
	}
	
	public function read() : Dynamic
	{
		return readValue();
	}
	
	function readValue() : Dynamic
	{
		switch(input.readByte())
		{
			case 0: return null;
			case 1: return true;
			case 2: return false;
			case 3: return readInt();
			case 4: return readFloat();
			case 5: return readString();
			case 6: return readArray();
			case 7: return readDynamic();
			default: throw "Unexpected value";
		}
	}
	
	function readInt() : Int
	{
		return input.readInt31();
	}
	
	function readFloat() : Float
	{
		return input.readFloat();
	}
	
	function readString() : String
	{
		return input.readString(input.readUInt16());
	}
	
	function readArray() : Array<Dynamic>
	{
		var a:Array<Dynamic> = [];
		for(n in 0...input.readUInt16())
		{
			a.push(readValue());
		}
		return a;
	}
	
	function readDynamic() : Dynamic
	{
		var d:Dynamic = {};
		for(n in 0...input.readUInt16())
		{
			Reflect.setField(d, input.readString(input.readUInt16()), readValue());
		}
		return d;
	}
}