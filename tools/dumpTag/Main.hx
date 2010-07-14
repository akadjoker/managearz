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
	static var swfPath:String;
	
	static function main()
	{
		var a = Sys.args();
		swfPath = FileSystem.fullPath(a[0]);
		
		var i = File.read(swfPath, true);
		var s:SWF = new Reader(i).read();
		
		trace("version : "+s.header.version);
		trace("compressed : "+s.header.compressed);
		trace("width : "+s.header.width);
		trace("height : "+s.header.height);
		trace("fps : "+s.header.fps);
		trace("nframes : "+s.header.nframes);
		trace("tags : ");
		for(n in s.tags)
		{
			trace(Tools.dumpTag(n,0));
		}
	}
}