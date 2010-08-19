//
//  Main.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 1/24/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package ;
import neko.Sys;
import neko.FileSystem;
import neko.io.File;
import neko.io.Path;

import haxe.io.BytesOutput;

import format.abc.Context;
import format.swf.Data;
import format.swf.Reader;
import format.swf.Tools;

class Main 
{
	static var preloaderPath:String;
	static var swfPath:String;
	static var outputPath:String;
	
	static var className:String;
	
	static var context:Context;
	static var symbols:Array<{ cid : Int, className : String }>;
	
	static function main()
	{
		var a = Sys.args();

		if(a.length < 2)
		{
			print("How To Use :");
			print("Use like this : neko Preloader.n preloaderPath.swf swfPath.swf");
			print("Where the preloaderPath.swf is the path of your preloader");
			print("And where the swfPath.swf is your main swf that want to be added preloader");
			print("It will produce a swf with this name : swfPath(Preloader).swf");
			return;
		}
		
		preloaderPath = FileSystem.fullPath(a[0]);
		swfPath = FileSystem.fullPath(a[1]);
		
		outputPath = swfPath.substr(0, swfPath.lastIndexOf("."));
		outputPath += "(Preloader).swf";
		
		className = swfPath.substr(swfPath.lastIndexOf("/")+1);
		className = className.substr(0, className.lastIndexOf("."));
		
		var i = File.read(preloaderPath, true);
		var s:SWF = new Reader(i).read();
		
		var curIndex = 0;
		for(n in s.tags)
		{
			switch(n)
			{
				case TBitsLossless(data), TBitsLossless2(data): if(curIndex<data.cid) curIndex = data.cid;
				case TBitsJPEG2(id,_), TBitsJPEG3(id,_,_): if(curIndex<id) curIndex = id;
				case TSound(data): if(curIndex<data.sid) curIndex = data.sid;
				case TBinaryData(id,_): if(curIndex<id) curIndex = id;
				case TSymbolClass(symbols):
					for(sym in symbols)
					{
						if(curIndex<sym.cid) curIndex = sym.cid;
					}
				default:
			}
		}
		
		curIndex++;
		
		//s.tags.pop();
		
		var i = File.read(swfPath, true);

		var s2:SWF = new Reader(i).read();
		
		s.tags.push(TBinaryData(curIndex, i.readAll())); // add binary tag
		
		symbols = [{cid:curIndex, className:className}];
		
		s.tags.push(TSymbolClass(symbols)); // make symbol class
		
		context = new Context();
		var cl = context.beginClass(className, true);
		cl.superclass = context.type("flash.utils.ByteArray");
		context.endClass(true);
		
		var abcO = new BytesOutput();
		context.finalize();
		format.abc.Writer.write(abcO, context.getData());
		s.tags.push(TActionScript3(abcO.getBytes())); // make stub class
		
		s.tags.push(TShowFrame); // show frame

		s.header.width = s2.header.width;
		s.header.height = s2.header.height;
		s.header.fps = s2.header.fps;
		s.header.nframes = s.header.nframes+1;
		
		var o = File.write(outputPath,true);
		(new format.swf.Writer(o)).write(s);
		o.flush();
		o.close();

		print("");
		print("version : "+s.header.version);
		print("compressed : "+s.header.compressed);
		print("width : "+s.header.width);
		print("height : "+s.header.height);
		print("fps : "+s.header.fps);
		print("nframes : "+s.header.nframes);
		print("tags : ");
		for(n in s.tags)
		{
			print(Tools.dumpTag(n,0));
		}
	}

	static function print(s:String)
	{
		neko.Lib.print(s+"\n");
	}
}
