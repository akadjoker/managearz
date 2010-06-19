//
//  Camera.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 3/2/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package manaGearz.animation;
import manaGearz.math.Point;

using manaGearz.math.PointUtils;

class Camera 
{
	public var screen(default, null):Point;
	public var bound(default, null):Point;
	public var poi(default, null):Point;
	public var position(default, null):Point;
	public var zoom(default, null):Float;
	
	public function new()
	{
		screen = {x:0.0, y:0.0};
		bound = {x:0.0, y:0.0};
		poi = {x:0.0, y:0.0};
		position = {x:0.0, y:0.0};
		zoom = 1.0;
	}
	
	public function update()
	{
		var po = position.mul(zoom);
		var bo = bound.mul(zoom);
		
		var p = poi.sub(po);
		var s = bo.add(p);
		if(p.x > 0) p.x = 0 else if(s.x < screen.x) p.x = screen.x - bo.x;
		if(p.y > 0) p.y = 0 else if(s.y < screen.y) p.y = screen.y - bo.y;
		
		updateScreen(p.x, p.y);
	}
	
	// override this
	public function updateScreen(x:Float, y:Float)
	{
	
	}
	
	public function setScreen(width:Float, height:Float)
	{
		screen.x = width;
		screen.y = height;
	}
	
	public function setBound(width:Float, height:Float)
	{
		bound.x = width;
		bound.y = height;
	}
	
	public function setPOI(x:Float, y:Float)
	{
		poi.x = x;
		poi.y = y;
	}
	
	public function setPosition(x:Float, y:Float)
	{
		position.x = x;
		position.y = y;
	}
	
	public function setZoom(zoom:Float)
	{
		this.zoom = zoom;
	}
}