/**
 * ...
 * @author alijaya
 */

package manaGearz.manager;
import manaGearz.fsm.FSM;
import manaGearz.fsm.State;
import manaGearz.fsm.Transition;
import manaGearz.utils.DynamicUtils;

import flash.display.Sprite;
import flash.Lib;

class GameStateManager 
{

	private static var _instance : GameStateManager;
	public static var instance(get_instance, null) : GameStateManager;
	public static function get_instance() : GameStateManager
	{
		if (_instance == null) _instance = new GameStateManager();
		return _instance;
	}
	
	public var fsm(default, null):FSM;
	
	public var root(default, null):Sprite;
	
	public var states(default, null):Hash<State>;
	
	public var transitions(default, null):Hash<Transition>;
	
	public var curState(default, null):State;
	public var curStateName(default, null):String;
	
	private function new() 
	{
		fsm = new FSM();
		root = new Sprite();
		flash.Lib.current.addChild(root);
		var d = DataManager.instance;
		states = cast d.getDir(["manaGearz","state"]);
		transitions = cast d.getDir(["manaGearz","transition"]);
	}
	
	public function getStageWidth() : Int
	{
		return root.stage.stageWidth;
	}
	
	public function getStageHeight() : Int
	{
		return root.stage.stageHeight;
	}
	
	public function step()
	{
		fsm.execute();
	}
	
	public function addState(name:String, gameState:Class<State>)
	{
		states.set(name, Type.createInstance(gameState, [fsm]));
	}
	
	public function addTransition(name:String, transition:Class<Transition>)
	{
		transitions.set(name, Type.createInstance(transition, [fsm]));
	}
	
	public function setState(gameState:String, transition:String, ?data:Dynamic)
	{
		curStateName = gameState;
		curState = states.get(gameState);
		var t = transitions.get(transition);
		var d = {first:fsm.curState,second:curState};
		if(data!=null) DynamicUtils.concat(d, data);
		t.init(d);
		fsm.changeState(t);
	}
	
}