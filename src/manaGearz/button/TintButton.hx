//
//  TintButton.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 1/10/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package manaGearz.button;
import flash.geom.ColorTransform;

import manaGearz.graphic.S9G;
import manaGearz.utils.ColorUtils;

class TintButton extends SpriteButton
{
	private var s9g:S9G;
	private var s9gT:S9G;
	private var curS9G:S9G;
	
	private var blankCT:ColorTransform;
	
	private var ctUp:ColorTransform;
	private var ctOver:ColorTransform;
	private var ctDown:ColorTransform;
	private var ctDisabled:ColorTransform;
	
	private var ctUpT:ColorTransform;
	private var ctOverT:ColorTransform;
	private var ctDownT:ColorTransform;
	private var ctDisabledT:ColorTransform;
	
	public function new(style:Dynamic)
	{
		if(style.bd!=null) s9g = new S9G(style.bd, style.rect);
		
		if(style.bdT!=null) s9gT = new S9G(style.bdT, style.rect);
		
		if(style.up!=null) ctUp = ColorUtils.tintCT(style.up.color, style.up.value);
		if(style.over!=null) ctOver = ColorUtils.tintCT(style.over.color, style.over.value);
		if(style.down!=null) ctDown = ColorUtils.tintCT(style.down.color, style.down.value);
		if(style.disabled!=null) ctDisabled = ColorUtils.tintCT(style.disabled.color, style.disabled.value);
		
		if(style.upT!=null) ctUpT = ColorUtils.tintCT(style.upT.color, style.upT.value);
		if(style.overT!=null) ctOverT = ColorUtils.tintCT(style.overT.color, style.overT.value);
		if(style.downT!=null) ctDownT = ColorUtils.tintCT(style.downT.color, style.downT.value);
		if(style.disabledT!=null) ctDisabledT = ColorUtils.tintCT(style.disabledT.color, style.disabledT.value);
		
		blankCT = new ColorTransform();
		
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
		sprite.addChildAt(curS9G.sprite,0);
		setWH(width, height);
	}
	
	private function changeCT(ct:ColorTransform)
	{
		if(curS9G==null) return;
		if(ct==null) ct = blankCT;
		sprite.transform.colorTransform = ct;
	}
	
	private override function changeUp()
	{
		super.changeUp();
		if(toggled)
		{
			changeS9G(s9gT);
			changeCT(ctUpT);
		}else
		{
			changeS9G(s9g);
			changeCT(ctUp);
		}
	}
	
	private override function changeOver()
	{
		super.changeOver();
		if(toggled)
		{
			changeS9G(s9gT);
			changeCT(ctOverT);
		}else
		{
			changeS9G(s9g);
			changeCT(ctOver);
		}
	}
	
	private override function changeDown()
	{
		super.changeDown();
		if(toggled)
		{
			changeS9G(s9gT);
			changeCT(ctDownT);
		}else
		{
			changeS9G(s9g);
			changeCT(ctDown);
		}
	}
	
	private override function changeDisabled()
	{
		super.changeDisabled();
		if(toggled)
		{
			changeS9G(s9gT);
			changeCT(ctDisabledT);
		}else
		{
			changeS9G(s9g);
			changeCT(ctDisabled);
		}
	}
}