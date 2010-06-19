//
//  SpriteButton.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 1/9/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package manaGearz.button;
import flash.display.Sprite;
import flash.events.MouseEvent;

class SpriteButton extends Button
{
	public var sprite(default, null):Sprite;
	
	public var x(default, null):Float;
	public var y(default, null):Float;
	public var width(default, null):Float;
	public var height(default, null):Float;
	
	private function new(style:Dynamic)
	{
		x = 0;
		y = 0;
		width = 0;
		height = 0;
		sprite = new Sprite();
		sprite.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
		sprite.addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
		sprite.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
		super(style);
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
		this.width = width;
	}
	
	public function setHeight(height:Float)
	{
		this.height = height;
	}
	
	public function setXY(x:Float, y:Float)
	{
		setX(x);
		setY(y);
	}
	
	public function setWH(width:Float, height:Float)
	{
		setWidth(width);
		setHeight(height);
	}
	
	public function setXYWH(x:Float, y:Float, width:Float, height:Float)
	{
		setXY(x, y);
		setWH(width, height);
	}
	
	private function rollOverHandler(e:MouseEvent)
	{
		rolled = true;
		if(disabled) return;
		if(!pressed)
		{
			changeOver();
			overInternal();
		} else
		{
			changeDown();
		}
	}
	
	private function rollOutHandler(e:MouseEvent)
	{
		rolled = false;
		if(disabled) return;
		if(!pressed)
		{
			changeUp();
		} else
		{
			changeOver();
		}
	}
	
	private function mouseDownHandler(e:MouseEvent)
	{
		pressed = true;
		flash.Lib.current.stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		if(disabled) return;
		changeDown();
		downInternal();
	}
	
	private function mouseUpHandler(e:MouseEvent)
	{
		pressed = false;
		flash.Lib.current.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		if(disabled) return;
		if(rolled)
		{
			if(toggleable) setToggled(!toggled);
			changeOver();
			clickInternal();
		} else
		{
			changeUp();
		}
	}
}