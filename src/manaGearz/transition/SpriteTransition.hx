//
//  SpriteTransition.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 1/17/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package manaGearz.transition;
import flash.display.Sprite;

import manaGearz.manager.GameStateManager;
import manaGearz.fsm.FSM;
import manaGearz.fsm.Transition;
import manaGearz.state.SpriteState;

class SpriteTransition extends TimeTransition
{
	private var firstSprite:Sprite;
	private var secondSprite:Sprite;
	
	private function new(fsm:FSM, ?first:SpriteState, ?second:SpriteState)
	{
		super(fsm, first, second);
		firstSprite = (first!=null)? (cast first).sprite : null;
		secondSprite = (second!=null)? (cast second).sprite : null;
	}
	
	public override function init(d:Dynamic)
	{
		super.init(d);
		firstSprite = (first!=null)? (cast first).sprite : null;
		secondSprite = (second!=null)? (cast second).sprite : null;
	}
}