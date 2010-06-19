//
//  Main.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 2/24/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package ;
import neko.Sys;
import neko.FileSystem;
import neko.io.File;

import haxe.io.Bytes;
import haxe.io.BytesInput;

import format.swf.Data;

class Main 
{
	static var dir:String;
	
	static function main()
	{
		var a = Sys.args();
		var path = a[0];
		dir = path.substr(0, path.lastIndexOf("."))+"_assets";
		trace(dir);
		if(!FileSystem.exists(dir)) FileSystem.createDirectory(dir);
		var swf:SWF = (new format.swf.Reader(new BytesInput(File.read(path, true).readAll()))).read();
		
		for(n in swf.tags)
		{
			switch(n)
			{
				case TBitsLossless(data):
					extractLossless(data);
				case TBitsLossless2(data):
					extractLossless2(data);
				case TBitsJPEG2(id,data):
					extractJPEG2(id,data);
				case TBinaryData(id,data):
					extractBinaryData(id,data);
				case TSound(data):
					extractSound(data);
				default:
			}
		}
	}
	
	static function extractLossless(data:Lossless)
	{
		switch(data.color)
		{
			case CM24Bits:
			default: return; //another format hasn't supported
		}
		var o = File.write(dir+"/"+data.cid+"(image).png", true);
		(new format.png.Writer(o)).write(format.png.Tools.build32BE(data.width,data.height,format.tools.Inflate.run(data.data)));
		o.flush();
		o.close();
	}
	
	static function extractLossless2(data:Lossless)
	{
		switch(data.color)
		{
			case CM32Bits:
			default: return; //another format hasn't supported
		}
		var o = File.write(dir+"/"+data.cid+"(image).png", true);
		(new format.png.Writer(o)).write(format.png.Tools.build32BE(data.width,data.height,format.tools.Inflate.run(data.data)));
		o.flush();
		o.close();
	}
	
	static function extractJPEG2(id:Int,data:Bytes)
	{
		var o = File.write(dir+"/"+id+"(image).jpeg", true);
		o.writeBytes(data, 0, data.length);
		o.flush();
		o.close();
	}
	
	static function extractBinaryData(id:Int,data:Bytes)
	{
		var o = File.write(dir+"/"+id+"(binary).bin", true);
		o.writeBytes(data, 0, data.length);
		o.flush();
		o.close();
	}
	
	static function extractSound(data:Sound)
	{
		var d:Bytes;
		switch(data.data)
		{
			case SDMp3(_,dd): d = dd;
			default: return;
		}
		var o = File.write(dir+"/"+data.sid+"(sound).mp3", true);
		o.writeBytes(d, 0, d.length);
		o.flush();
		o.close();
	}
}