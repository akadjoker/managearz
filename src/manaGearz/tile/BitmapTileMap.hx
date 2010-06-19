//
//  BitmapTileMap.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 5/16/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package manaGearz.tile;
import flash.display.Bitmap;
import flash.display.BitmapData;

class BitmapTileMap extends TileMap<Int>
{
	public var bitmap(default, null):Bitmap;
	var bitmapData:BitmapData;
	var rect:flash.geom.Rectangle; // for fillRect and copyChannel
	var point:flash.geom.Point; // for copyChannel
	
	public var tileW(default, null):Int;
	public var tileH(default, null):Int;
	
	var tileSet:Array<BitmapData>;
	
	public function new(tileW:Int, tileH:Int, width:Int, height:Int, ?initTile:Void->Int=null)
	{
		super(width, height, initTile);
		
		this.tileW = tileW;
		this.tileH = tileH;
		
		rect = new flash.geom.Rectangle(0, 0, tileW, tileH);
		point = new flash.geom.Point(0, 0);
		
		tileSet = [];
		
		bitmapData = new BitmapData(tileW*width, tileH*height, true, 0);
		bitmap = new Bitmap(bitmapData);
	}
	
	public function setTileSet(tileSet:Array<BitmapData>) : Array<BitmapData>
	{
		this.tileSet = tileSet.copy();
		return tileSet;
	}
	
	public override function updateXY(x:Int, y:Int)
	{
		var index:Int = map[y*width+x];
		if(index==0)
		{
			rect.x = x*tileW;
			rect.y = y*tileH;
			bitmapData.fillRect(rect, 0);
		} else
		{
			rect.x = 0;
			rect.y = 0;
			point.x = x*tileW;
			point.y = y*tileH;
			bitmapData.copyPixels(tileSet[index-1], rect, point);
		}
	}
}