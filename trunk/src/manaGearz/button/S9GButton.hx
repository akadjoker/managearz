//
//  S9GButton.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 1/10/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package manaGearz.button;
import manaGearz.graphic.S9G;

class S9GButton extends SpriteButton
{
	private var s9gUp:S9G;
	private var s9gOver:S9G;
	private var s9gDown:S9G;
	private var s9gDisabled:S9G;
	private var s9gUpT:S9G;
	private var s9gOverT:S9G;
	private var s9gDownT:S9G;
	private var s9gDisabledT:S9G;
	private var curS9G:S9G;
	
	public function new(style:Dynamic)
	{
		if(style.up!=null) s9gUp = new S9G(style.up, style.rect);
		if(style.over!=null) s9gOver = new S9G(style.over, style.rect);
		if(style.down!=null) s9gDown = new S9G(style.down, style.rect);
		if(style.disabled!=null) s9gDisabled = new S9G(style.disabled, style.rect);
		
		if(style.upT!=null) s9gUpT = new S9G(style.upT, style.rect);
		if(style.overT!=null) s9gOverT = new S9G(style.overT, style.rect);
		if(style.downT!=null) s9gDownT = new S9G(style.downT, style.rect);
		if(style.disabledT!=null) s9gDisabledT = new S9G(style.disabledT, style.rect);
		
		super(style);
	}
	
	public override function setWidth(width:Float)
	{
		curS9G.setWidth(width);
		this.width = curS9G.width;
	}
	
	public override function setHeight(height:Float)
	{
		curS9G.setHeight(height);
		this.height = curS9G.height;
	}
	
	public override function setWH(width:Float, height:Float)
	{
		curS9G.setWH(width, height);
		this.width = curS9G.width;
		this.height = curS9G.height;
	}
	
	private function changeS9G(nextS9G:S9G)
	{
		if(curS9G==nextS9G) return;
		if(curS9G != null) sprite.removeChild(curS9G.sprite);
		curS9G = nextS9G;
		sprite.addChild(curS9G.sprite);
		setWH(width, height);
	}
	
	private override function changeUp()
	{
		super.changeUp();
		if(toggled) changeS9G(s9gUpT) else changeS9G(s9gUp);
	}
	
	private override function changeOver()
	{
		super.changeOver();
		if(toggled) changeS9G(s9gOverT) else changeS9G(s9gOver);
	}
	
	private override function changeDown()
	{
		super.changeDown();
		if(toggled) changeS9G(s9gDownT) else changeS9G(s9gDown);
	}
	
	private override function changeDisabled()
	{
		super.changeDisabled();
		if(toggled) changeS9G(s9gDisabledT) else changeS9G(s9gDisabled);
	}
}