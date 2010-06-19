//
//  SpriteCamera.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 3/2/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package manaGearz.animation;
import flash.display.Sprite;
import flash.geom.Rectangle;

using manaGearz.math.PointUtils;

class SpriteCamera extends Camera
{
	public var sprite(default, null):Sprite;
	private var rect:Rectangle;
	
	public function new(sprite:Sprite)
	{
		super();
		this.sprite = sprite;
		rect = new Rectangle();
		setBound(sprite.width, sprite.height);
	}
	
	public override function updateScreen(x:Float, y:Float)
	{
		var m = 1/zoom;
		var s = screen.mul(m);
		rect.x = -x*m;
		rect.y = -y*m;
		rect.width = s.x;
		rect.height = s.y;
		sprite.scrollRect = rect;
		sprite.scaleX = zoom;
		sprite.scaleY = zoom;
	}
}