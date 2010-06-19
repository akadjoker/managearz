//
//  BDAnimation.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 2/19/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package manaGearz.animation;
import flash.display.Sprite;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.geom.Rectangle;
import flash.geom.Point;

class BDAnimation extends Animation<Int>
{
	
	public var sprite(default, null):Sprite;
	public var bitmapData(default, null):BitmapData;
	private var bdDisplay:BitmapData;
	
	public var width(default, null):Int;
	public var height(default, null):Int;
	public var xCount(default, null):Int;
	public var yCount(default, null):Int;
	
	public function new(bitmapData:BitmapData, xCount:Int, yCount:Int, animation:Hash<Array<Int>>)
	{
		sprite = new Sprite();
		
		this.bitmapData = bitmapData;
		this.xCount = xCount;
		this.yCount = yCount;
		width = Std.int(bitmapData.width/xCount);
		height = Std.int(bitmapData.height/yCount);
		
		bdDisplay = new BitmapData(width, height, true, 0);
		sprite.addChild(new Bitmap(bdDisplay));
		super(animation);
	}
	
	public override function executeFrame()
	{
		var y = Std.int(curFrame/xCount);
		var x = curFrame - y*xCount;
		bdDisplay.copyPixels(bitmapData, new Rectangle(x*width,y*height,width,height), new Point(0,0));
	}
}