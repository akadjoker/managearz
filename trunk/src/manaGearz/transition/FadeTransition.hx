//
//  FadeTransition.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 1/17/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package manaGearz.transition;
import flash.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;

import manaGearz.manager.GameStateManager;
import manaGearz.fsm.FSM;
import manaGearz.state.SpriteState;

class FadeTransition extends SpriteTransition
{
	public var color(default, null):Int;
	public var defaultColor(default, null):Int;
	
	private var mask:Bitmap;
	
	private var out:Bool;
	
	public function new(fsm:FSM, ?first:SpriteState, ?second:SpriteState)
	{
		super(fsm, first, second);
		mask = new Bitmap(new BitmapData(1,1));
		defaultTime = 100;
		defaultColor = 0x000000;
		color = defaultColor;
		out = true;
	}
	
	public override function init(d:Dynamic)
	{
		super.init(d);
		color = (d.color!=null)? d.color : defaultColor;
		mask.bitmapData.setPixel(0,0,color);
		out = true;
	}
	
	public override function enter()
	{
		var gsm = GameStateManager.instance;
		if(secondSprite!=null)
		{
			gsm.root.addChild(secondSprite);
			secondSprite.visible = false;
		}
		gsm.root.addChild(mask);
		mask.alpha = 0;
		mask.width = gsm.getStageWidth();
		mask.height = gsm.getStageHeight();
	}
	
	private override function trans()
	{
		if(interval >= 0.5 && out)
		{
			out = false;
			if(secondSprite!=null) secondSprite.visible = true;
			if(firstSprite!=null) GameStateManager.instance.root.removeChild(firstSprite);
		}
		if(out)
		{
			mask.alpha = interval*2;
		} else
		{
			mask.alpha = (1-interval)*2;
		}
	}
	
	public override function exit()
	{
		GameStateManager.instance.root.removeChild(mask);
	}
}