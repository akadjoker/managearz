//
//  S9G.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 1/11/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package manaGearz.graphic;
import flash.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;
import manaGearz.math.Rectangle;
import manaGearz.math.MathEx;

using manaGearz.math.RectangleUtils;

class S9G 
{
	public var sprite(default, null):Sprite;
	
	public var x(default, null):Float;
	public var y(default, null):Float;
	public var width(default, null):Float;
	public var height(default, null):Float;
	
	public var minWidth(default, null):Float;
	public var minHeight(default, null):Float;
	
	var left:Float;
	var right:Float;
	var top:Float;
	var bottom:Float;
	
	private var skin:BitmapData;
	private var rect:Rectangle;
	
	public function new(skin:BitmapData, rect:Rectangle)
	{
		sprite = new Sprite();
		
		this.skin = skin;
		this.rect = rect;
		
		rect = rect.intersection(skin.rect.fromFlash());
		
		left = rect.left();
		right = skin.width - rect.right();
		top = rect.top();
		bottom = skin.height - rect.bottom();
		
		minWidth = left+right;
		minHeight = top+bottom;
		
		x = 0;
		y = 0;
		width = minWidth;
		height = minHeight;
		
		update();
	}
	
	private function update()
	{
		var m = new flash.geom.Matrix();
		var p = new flash.geom.Point();
		
		var dy:Float = 0;
		var oy:Float = 0;
		
		for(j in 0...3)
		{
			var hei:Float = switch(j)
			{
				case 0: top;
				case 1: rect.height;
				case 2: bottom;
			}
			var dhei:Float = (j==1)?height-minHeight:hei;
			
			var dx:Float = 0;
			var ox:Float = 0;
			
			for(i in 0...3)
			{
				var wid:Float = switch(i)
				{
					case 0: left;
					case 1: rect.width;
					case 2: right;
				}
				var dwid:Float = (i==1)?width-minWidth:wid;
				
				if(dwid>0 && dhei>0)
				{
					m.a = dwid/wid;
					m.d = dhei/hei;
					m.tx = -ox*m.a+dx;
					m.ty = -oy*m.d+dy;
					
					sprite.graphics.beginBitmapFill(skin,m,false,true);
					sprite.graphics.drawRect(dx,dy,dwid,dhei);
					sprite.graphics.endFill();
				}
				
				ox += wid;
				dx += dwid;
			}
			
			oy += hei;
			dy += dhei;
		}
	}
	
	public function setX(x:Float)
	{
		this.x = x;
		sprite.x = x;
	}
	
	public function setY(y:Float)
	{
		this.y = y;
		sprite.y = y;
	}
	
	public function setWidth(width:Float)
	{
		this.width = MathEx.max(width, minWidth);
		update();
	}
	
	public function setHeight(height:Float)
	{
		this.height = MathEx.max(height, minHeight);
		update();
	}
	
	public function setXY(x:Float, y:Float)
	{
		this.x = x;
		this.y = y;
		sprite.x = x;
		sprite.y = y;
	}
	
	public function setWH(width:Float, height:Float)
	{
		this.width = MathEx.max(width, minWidth);
		this.height = MathEx.max(height, minHeight);
		update();
	}
	
	public function setXYWH(x:Float, y:Float, width:Float, height:Float)
	{
		setXY(x, y);
		setWH(width, height);
	}
}