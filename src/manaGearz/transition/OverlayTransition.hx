//
//  OverlayTransition.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 1/17/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package manaGearz.transition;
import flash.display.Sprite;

import manaGearz.manager.GameStateManager;
import manaGearz.fsm.FSM;
import manaGearz.state.SpriteState;

class OverlayTransition extends SpriteTransition
{
	public function new(fsm:FSM, ?first:SpriteState, ?second:SpriteState)
	{
		super(fsm, first, second);
	}
	
	public override function enter()
	{
		if(secondSprite!=null)
		{
			GameStateManager.instance.root.addChild(secondSprite);
			secondSprite.alpha = 0;
		}
	}
	
	private override function trans()
	{
		if(secondSprite!=null) secondSprite.alpha = interval;
	}
	
	public override function exit()
	{
		if(firstSprite!=null) GameStateManager.instance.root.removeChild(firstSprite);
	}
}