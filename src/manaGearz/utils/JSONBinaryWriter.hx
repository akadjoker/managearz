//
//  JSONBinaryWriter.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 3/18/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package manaGearz.utils;

class JSONBinaryWriter 
{
	var output : haxe.io.Output;
	
	public function new(o:haxe.io.Output)
	{
		output = o;
	}
	
	public function write(d:Dynamic)
	{
		writeValue(d);
	}
	
	function writeValue(v:Dynamic)
	{
		if(v == null)
		{
			writeNull();
		} else if(Std.is(v, String))
		{
			writeString(v);
		} else if(Std.is(v, Int))
		{
			writeInt(v);
		} else if(Std.is(v, Float))
		{
			writeFloat(v);
		} else if(Std.is(v, Bool))
		{
			writeBool(v);
		} else if(Std.is(v, Array))
		{
			writeArray(v);
		} else if(Reflect.isObject(v))
		{
			writeDynamic(v);
		}
	}
	
	function writeNull()
	{
		output.writeByte(0);
	}
	
	function writeBool(b:Bool)
	{
		output.writeByte(b?1:2);
	}
	
	function writeInt(i:Int)
	{
		output.writeByte(3);
		output.writeInt31(i);
	}
	
	function writeFloat(f:Float)
	{
		output.writeByte(4);
		output.writeFloat(f);
	}
	
	function writeString(s:String)
	{
		output.writeByte(5);
		output.writeUInt16(s.length);
		output.writeString(s);
	}
	
	function writeArray(a:Array<Dynamic>)
	{
		output.writeByte(6);
		output.writeUInt16(a.length);
		for(n in a)
		{
			writeValue(n);
		}
	}
	
	function writeDynamic(d:Dynamic)
	{
		output.writeByte(7);
		var fields:Array<String> = Reflect.fields(d);
		output.writeUInt16(fields.length);
		for(n in fields)
		{
			output.writeUInt16(n.length);
			output.writeString(n);
			writeValue(Reflect.field(d, n));
		}
	}
}