//
//  ATXPMap.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 5/16/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package manaGearz.tile;
import flash.display.Bitmap;
import flash.display.BitmapData;

class ATXPMap extends TileMap<Bool>
{
	public var bitmap(default, null):Bitmap;
	var bitmapData:BitmapData;
	var rect:flash.geom.Rectangle; // for fillRect and copyChannel
	var point:flash.geom.Point; // for copyChannel
	var p:Array<Bool>;
	
	var tileW:Int;
	var tileH:Int;
	
	var halfW:Int;
	var halfH:Int;
	
	var autoTile:BitmapData;
	
	public function new(tileW:Int, tileH:Int, width:Int, height:Int, ?initTile:Void->Bool=null)
	{
		if(tileW&1!=0||tileH&1!=0) throw "tileW and tileH must be even";
		
		super(width, height, initTile);
		
		this.tileW = tileW;
		this.tileH = tileH;
		
		halfW = tileW>>1;
		halfH = tileH>>1;
		
		rect = new flash.geom.Rectangle(0, 0, halfW, halfH);
		point = new flash.geom.Point(0, 0);
		p = [];
		
		bitmapData = new BitmapData(tileW*width, tileH*height, true, 0);
		bitmap = new Bitmap(bitmapData);
	}
	
	public function setAutoTile(autoTile:BitmapData) : BitmapData
	{
		this.autoTile = autoTile;
		return autoTile;
	}
	
	public override function updateXY(x:Int, y:Int)
	{
		var flag = map[y*width+x];
		if(!flag)
		{
			rect.x = x*tileW;
			rect.y = y*tileH;
			rect.width = tileW;
			rect.height = tileH;
			bitmapData.fillRect(rect, 0);
			rect.width = halfW;
			rect.height = halfH;
		} else
		{
			p[0] = (y==0)?						true:map[(y-1)*width+x];
			p[1] = (y==0||x==width-1)?			true:map[(y-1)*width+x+1];
			p[2] = (x==width-1)?				true:map[y*width+x+1];
			p[3] = (y==height-1||x==width-1)?	true:map[(y+1)*width+x+1];
			p[4] = (y==height-1)?				true:map[(y+1)*width+x];
			p[5] = (y==height-1||x==0)?			true:map[(y+1)*width+x-1];
			p[6] = (x==0)?						true:map[y*width+x-1];
			p[7] = (y==0||x==0)?				true:map[(y-1)*width+x-1];
			
			// NW
			if(p[0]&&p[6]&&!p[7]) // inner corner
			{
				rect.x = 4*halfW;
				rect.y = 0;
			} else if(!p[4]&&!p[2]&&p[0]&&p[6]) // corner4
			{
				rect.x = 4*halfW;
				rect.y = 6*halfH;
			} else if(!p[0]&&!p[2]&&p[6]) // corner2
			{
				rect.x = 4*halfW;
				rect.y = 2*halfH;
			} else if(!p[4]&&!p[6]&&p[0]) // corner3
			{
				rect.x = 0;
				rect.y = 6*halfH;
			} else if(!p[0]&&!p[6]) // corner1
			{
				rect.x = 0;
				rect.y = 2*halfH;
			} else if(!p[0]&&p[6]) // horizontal1
			{
				rect.x = 2*halfW;
				rect.y = 2*halfH;
			} else if(!p[4]&&p[6]) // horizontal2
			{
				rect.x = 2*halfW;
				rect.y = 6*halfH;
			} else if(p[0]&&!p[6]) // vertical1
			{
				rect.x = 0;
				rect.y = 4*halfH;
			} else if(p[0]&&!p[2]) // vertical2
			{
				rect.x = 4*halfW;
				rect.y = 4*halfH;
			} else // full
			{
				rect.x = 2*halfW;
				rect.y = 4*halfH;
			}
			point.x = x*tileW;
			point.y = y*tileH;
			bitmapData.copyPixels(autoTile, rect, point);
			
			// NE
			if(p[0]&&p[2]&&!p[1]) // inner corner
			{
				rect.x = 5*halfW;
				rect.y = 0;
			} else if(!p[4]&&!p[6]&&p[0]&&p[2]) // corner3
			{
				rect.x = halfW;
				rect.y = 6*halfH;
			} else if(!p[0]&&!p[6]&&p[2]) // corner1
			{
				rect.x = halfW;
				rect.y = 2*halfH;
			} else if(!p[4]&&!p[2]&&p[0]) // corner4
			{
				rect.x = 5*halfW;
				rect.y = 6*halfH;
			} else if(!p[0]&&!p[2]) // corner2
			{
				rect.x = 5*halfW;
				rect.y = 2*halfH;
			} else if(!p[0]&&p[2]) // horizontal1
			{
				rect.x = 3*halfW;
				rect.y = 2*halfH;
			} else if(!p[4]&&p[2]) // horizontal2
			{
				rect.x = 3*halfW;
				rect.y = 6*halfH;
			} else if(p[0]&&!p[2]) // vertical2
			{
				rect.x = 5*halfW;
				rect.y = 4*halfH;
			} else if(p[0]&&!p[6]) // vertical1
			{
				rect.x = halfW;
				rect.y = 4*halfH;
			} else // full
			{
				rect.x = 3*halfW;
				rect.y = 4*halfH;
			}
			point.x = x*tileW+halfW;
			point.y = y*tileH;
			bitmapData.copyPixels(autoTile, rect, point);
			
			// SW
			if(p[4]&&p[6]&&!p[5]) // inner corner
			{
				rect.x = 4*halfW;
				rect.y = halfH;
			} else if(!p[0]&&!p[2]&&p[4]&&p[6]) // corner2
			{
				rect.x = 4*halfW;
				rect.y = 3*halfH;
			} else if(!p[0]&&!p[6]&&p[4]) // corner1
			{
				rect.x = 0;
				rect.y = 3*halfH;
			} else if(!p[4]&&!p[2]&&p[6]) // corner4
			{
				rect.x = 4*halfW;
				rect.y = 7*halfH;
			} else if(!p[4]&&!p[6]) // corner3
			{
				rect.x = 0;
				rect.y = 7*halfH;
			} else if(!p[4]&&p[6]) // horizontal2
			{
				rect.x = 2*halfW;
				rect.y = 7*halfH;
			} else if(!p[0]&&p[6]) // horizontal1
			{
				rect.x = 2*halfW;
				rect.y = 3*halfH;
			} else if(p[4]&&!p[6]) // vertical1
			{
				rect.x = 0;
				rect.y = 5*halfH;
			} else if(p[4]&&!p[2]) // vertical2
			{
				rect.x = 4*halfW;
				rect.y = 5*halfH;
			} else // full
			{
				rect.x = 2*halfW;
				rect.y = 5*halfH;
			}
			point.x = x*tileW;
			point.y = y*tileH+halfH;
			bitmapData.copyPixels(autoTile, rect, point);
			
			// SE
			if(p[4]&&p[2]&&!p[3]) // inner corner
			{
				rect.x = 5*halfW;
				rect.y = halfH;
			} else if(!p[0]&&!p[6]&&p[4]&&p[2]) // corner1
			{
				rect.x = halfW;
				rect.y = 3*halfH;
			} else if(!p[0]&&!p[2]&&p[4]) // corner2
			{
				rect.x = 5*halfW;
				rect.y = 3*halfH;
			} else if(!p[4]&&!p[6]&&p[2]) // corner3
			{
				rect.x = halfW;
				rect.y = 7*halfH;
			} else if(!p[4]&&!p[2]) // corner4
			{
				rect.x = 5*halfW;
				rect.y = 7*halfH;
			} else if(!p[4]&&p[2]) // horizontal2
			{
				rect.x = 3*halfW;
				rect.y = 7*halfH;
			} else if(!p[0]&&p[2]) // horizontal1
			{
				rect.x = 3*halfW;
				rect.y = 3*halfH;
			} else if(p[4]&&!p[2]) // vertical2
			{
				rect.x = 5*halfW;
				rect.y = 5*halfH;
			} else if(p[4]&&!p[6]) // vertical1
			{
				rect.x = halfW;
				rect.y = 5*halfH;
			} else // full
			{
				rect.x = 3*halfW;
				rect.y = 5*halfH;
			}
			point.x = x*tileW+halfW;
			point.y = y*tileH+halfH;
			bitmapData.copyPixels(autoTile, rect, point);
		}
	}
	
	public static inline function int2bool(i:Array<Int>) : Array<Bool>
	{
		var b:Array<Bool> = [];
		for(n in i)
		{
			b.push(n!=0);
		}
		return b;
	}
}