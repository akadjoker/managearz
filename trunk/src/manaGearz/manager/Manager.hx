//
//  Manager.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 2/25/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package manaGearz.manager;

class Manager 
{
	public static inline var cursor:CursorManager = CursorManager.instance;
	public static inline var data:DataManager = DataManager.instance;
	public static inline var gameState:GameStateManager = GameStateManager.instance;
	public static inline var input:InputManager = InputManager.instance;
	public static inline var loader:LoaderManager = LoaderManager.instance;
	public static inline var embed:EmbedManager = EmbedManager.instance;
	public static inline var sound:SoundManager = SoundManager.instance;
	public static inline var timer:TimerManager = TimerManager.instance;
}