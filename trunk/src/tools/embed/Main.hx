//
//  Main.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 1/29/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package ;
import neko.Sys;
import neko.FileSystem;
import neko.io.File;
import neko.io.Path;

import haxe.io.Bytes;
import haxe.io.BytesInput;
import haxe.io.BytesOutput;

import format.abc.Context;
import format.swf.Data;
import format.mp3.Data;
import format.png.Data;

class Main 
{
	static var context:Context;
	static var tags:Array<SWFTag>;
	static var symbols:Array<{ cid : Int, className : String }>;
	static var id:Int;
	static var basePath:String;
	
	static function main()
	{
		var a = Sys.args();
		basePath = a[0];
		context = new Context();
		tags = [TSandBox(8)];
		symbols = [];
		id = 1;
		var swf:SWF = {
			header:{
				version:9,
				compressed:false,
				width:100,
				height:100,
				fps:30,
				nframes:1,
			},
			tags:tags,
		}
		var root = basePath.substr(basePath.lastIndexOf("/"));
		basePath = basePath.substr(0, basePath.lastIndexOf("/"));
		readDir(root);
		tags.push(TSymbolClass(symbols));
		var abcO = new BytesOutput();
		context.finalize();
		format.abc.Writer.write(abcO, context.getData());
		tags.push(TActionScript3(abcO.getBytes()));
		tags.push(TShowFrame);
		for(n in tags)
		{
			trace(format.swf.Tools.dumpTag(n));
		}
		var o = File.write(Path.withExtension(basePath+root,"swf"),true);
		(new format.swf.Writer(o)).write(swf);
		o.flush();
		o.close();
	}
	
	static function writeClass(c:String, sc:String)
	{
		var cl = context.beginClass(c, true);
		cl.superclass = context.type(sc);
		context.endClass(true);
	}
	
	static function readDir(p:String)
	{
		for(n in FileSystem.readDirectory(basePath+p))
		{
			var p2 = p+"/"+n;
			if(FileSystem.isDirectory(basePath+p2))
			{
				readDir(p2);
			}else
			{
				if(n==".DS_Store")continue;
				readFile(p+"/"+n);
			}
		}
	}
	
	static function readFile(p:String)
	{
		var f = File.read(basePath+p, true).readAll();
		var cn = p.substr(1, p.lastIndexOf(".")-1).split("/").join(".");
		var ext = p.substr(p.lastIndexOf(".")+1);
		ext = ext.toLowerCase();
		switch(ext)
		{
			case "jpg", "jpeg": loadJPEG(cn, f);
			case "png": loadPNG(cn, f);
			case "mp3": loadSound(cn, f);
			case "txt": loadText(cn, f);
			case "json": loadJSON(cn, f);
			default: loadBinary(cn, f);
		}
	}
	
	static function loadJPEG(cn:String, f:Bytes)
	{
		tags.push(TBitsJPEG2(id, f));
		symbols.push({cid:id, className:cn});
		writeClass(cn, "flash.display.Bitmap");
		id++;
	}
	
	static function loadPNG(cn:String, f:Bytes)
	{
		var png:Data = new format.png.Reader(new BytesInput(f)).read();
		var h = format.png.Tools.getHeader(png);
		var alpha;
		switch(h.color)
		{
			case ColTrue(a):
				alpha = a;
			default: throw "error";
		}
		
		if(alpha)
		{
			tags.push(TBitsLossless2({
				cid:id,
				color:CM32Bits,
				width:h.width,
				height:h.height,
				data:format.tools.Deflate.run(format.png.Tools.extract32(png)),
			}));
		}else
		{
			tags.push(TBitsLossless({
				cid:id,
				color:CM24Bits,
				width:h.width,
				height:h.height,
				data:format.tools.Deflate.run(format.png.Tools.extract32(png)),
			}));
		}
		symbols.push({cid:id, className:cn});
		writeClass(cn, "flash.display.Bitmap");
		id++;
	}
	
	static function loadSound(cn:String, f:Bytes)
	{
		var mp3 = new format.mp3.Reader(new haxe.io.BytesInput(f)).read();
		var fr0 = mp3.frames[0];
		var hdr0 = fr0.header;
		var flashRate = switch (hdr0.samplingRate) {
			case SR_11025: SR11k;
			case SR_22050: SR22k;
			case SR_44100: SR44k;
			default: throw "error";
		}
		var isStereo = switch (hdr0.channelMode) {
			case Stereo, JointStereo, DualChannel: true;
			case Mono: false;
		};
		tags.push(TSound({
			sid:id,
			format:SFMP3,
			rate:flashRate,
			is16bit:true,
			isStereo:isStereo,
			samples:haxe.Int32.ofInt(mp3.sampleCount),
			data:SDMp3(0, f),
		}));
		symbols.push({cid:id, className:cn});
		writeClass(cn, "flash.media.Sound");
		id++;
	}
	
	static function loadText(cn:String, f:Bytes)
	{
		tags.push(TBinaryData(id, f));
		symbols.push({cid:id, className:cn});
		writeClass(cn, "flash.utils.ByteArray");
		id++;
	}
	
	static function loadJSON(cn:String, f:Bytes)
	{
		tags.push(TBinaryData(id, f));
		symbols.push({cid:id, className:cn});
		writeClass(cn, "flash.utils.ByteArray");
		id++;
	}
	
	static function loadBinary(cn:String, f:Bytes)
	{
		tags.push(TBinaryData(id, f));
		symbols.push({cid:id, className:cn});
		writeClass(cn, "flash.utils.ByteArray");
		id++;
	}
}