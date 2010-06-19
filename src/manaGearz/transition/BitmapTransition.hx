//
//  BitmapTransition.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 1/17/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package manaGearz.transition;
import flash.display.Sprite;
import flash.display.BitmapData;

import manaGearz.manager.GameStateManager;
import manaGearz.fsm.FSM;
import manaGearz.state.SpriteState;

class BitmapTransition extends SpriteTransition
{
	private var firstBD:BitmapData;
	private var secondBD:BitmapData;
	
	private function new(fsm:FSM, ?first:SpriteState, ?second:SpriteState)
	{
		super(fsm, first, second);
	}
	
	public override function init(d:Dynamic)
	{
		super.init(d);
	}
	
	public override function enter()
	{
		if(firstSprite!=null)
		{
			firstBD = new BitmapData(Std.int(firstSprite.width), Std.int(firstSprite.height),true,0);
			firstBD.draw(firstSprite);
		} else
		{
			firstBD = new BitmapData(1,1,true,0);
		}
		
		if(secondSprite!=null)
		{
			secondBD = new BitmapData(Std.int(secondSprite.width), Std.int(secondSprite.height),true,0);
			secondBD.draw(secondSprite);
		} else
		{
			secondBD = new BitmapData(1,1,true,0);
		}
	}
}