//
//  DirectTransition.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 1/17/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package manaGearz.transition;
import manaGearz.manager.GameStateManager;
import manaGearz.fsm.FSM;
import manaGearz.state.SpriteState;

class DirectTransition extends SpriteTransition
{
	public function new(fsm:FSM, ?first:SpriteState, ?second:SpriteState)
	{
		super(fsm, first, second);
		defaultTime = 1;
		time = defaultTime;
	}
	
	private override function trans()
	{
		if(interval>=1)
		{
			var gsm = GameStateManager.instance;
			if(firstSprite!=null) gsm.root.removeChild(firstSprite);
			if(secondSprite!=null) gsm.root.addChild(secondSprite);
		}
	}
}