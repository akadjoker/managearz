//
//  BitmapUtils.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 1/20/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package manaGearz.utils;
import flash.display.Bitmap;
import flash.display.BitmapData;

class BitmapUtils 
{
	public static inline function interpolateBD(source:BitmapData, dest:BitmapData, mask:BitmapData, t:Float)
	{
		var ws = mask.width/source.width;
		var hs = mask.height/source.height;
		
		source.lock();
		for(j in 0...source.height)
		{
			for(i in 0...source.width)
			{
				if((mask.getPixel(Std.int(i*ws),Std.int(j*hs))>>16)/255 <= t)
				{
					source.setPixel32(i, j, dest.getPixel32(i, j));
				}
			}
		}
		source.unlock();
	}
	
	public static inline function copyBitmap(bitmap:Bitmap) : Bitmap
	{
		return new Bitmap(bitmap.bitmapData, bitmap.pixelSnapping, bitmap.smoothing);
	}
	
	public static inline function chopBD(bd:BitmapData, width:Int, height:Int, ?unused:Int=0, ?spacing:Int=0, ?mLeft:Int=0, ?mRight:Int=0, ?mTop:Int=0, ?mBottom:Int=0) : Array<BitmapData>
	{
		var bds:Array<BitmapData> = [];
		
		var xC:Int = Std.int((bd.width-mLeft-mRight+spacing)/(width+spacing));
		var yC:Int = Std.int((bd.height-mTop-mBottom+spacing)/(height+spacing));
		
		var l:Int = xC*yC-unused;
		
		var dr = new flash.geom.Rectangle();
		var dp = new flash.geom.Point();
		dr.width = width;
		dr.height = height;
		
		for(j in 0...yC)
		{
			var b = false;
			for(i in 0...xC)
			{
				var nbd:BitmapData = new BitmapData(width, height, true, 0);
				dr.x = mLeft+(width+spacing)*i;
				dr.y = mTop+(height+spacing)*j;
				nbd.copyPixels(bd, dr, dp);
				bds.push(nbd);
				if(bds.length==l)
				{
					b = true;
					break;
				}
			}
			if(b) break;
		}
		
		return bds;
	}
}