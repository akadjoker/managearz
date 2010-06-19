package ;

import flash.Lib;
import flash.display.Shader;
import flash.display.ShaderJob;
import flash.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.ColorTransform;
import flash.events.MouseEvent;
import flash.utils.ByteArray;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.system.ApplicationDomain;
import flash.display.Loader;
import flash.system.LoaderContext;

import nl.demonsters.debugger.MonsterDebugger;

import manaGearz.manager.Manager;
import manaGearz.fsm.FSM;
import manaGearz.animation.BDAnimation;
import manaGearz.animation.TimerScale;
import manaGearz.animation.SpriteCamera;
import manaGearz.state.SpriteState;
import manaGearz.transition.DirectTransition;
import manaGearz.transition.OverlayTransition;
import manaGearz.transition.FadeTransition;
import manaGearz.transition.MaskTransition;
import manaGearz.button.TintButton;
import manaGearz.button.S9GButton;
import manaGearz.graphic.S9G;
import manaGearz.math.Point;
import manaGearz.math.Rectangle;
import manaGearz.math.PointUtils;
import manaGearz.math.RectangleUtils;
import manaGearz.math.MathEx;
import manaGearz.utils.JSONBinaryWriter;
import manaGearz.utils.JSONBinaryReader;
import manaGearz.tile.BitmapTileMap;
import manaGearz.tile.ATVXMap;
import manaGearz.tile.ATXPMap;

using manaGearz.math.PointUtils;
using manaGearz.math.RectangleUtils;
using manaGearz.utils.BitmapUtils;
using manaGearz.graphic.S9G;

/**
 * ...
 * @author alijaya
 */

class Main 
{
	static function main()
	{
		Lib.current.addEventListener(Event.ADDED_TO_STAGE, onAdded);
	}
	
	static function onAdded(_)
	{
		Lib.current.removeEventListener(Event.ADDED_TO_STAGE, onAdded);
		
		//new MonsterDebugger(Lib.current.root);
		//MonsterDebugger.redirectTrace();
		//Manager.loader.load("../src/assets.json", complete);
		Manager.embed.load("swf", "json", complete);
		
		Lib.current.graphics.beginFill(0xff0000);
		Lib.current.graphics.drawRect(100,100,100,100);
	}
	
	static function complete() 
	{
		//try{
		
		/*trace("1 for fill");
		trace("2 for erase");
		trace("z for forest autotile");
		trace("x for water autotile");
		trace("c for cliff autotile");*/
		
		var gsm = Manager.gameState;
		MonsterDebugger.inspect(Manager);
		//gsm.addState("first", FirstState);
		//gsm.addState("second", SecondState);
		gsm.addState("third", ThirdState);
		
		gsm.addTransition("direct", DirectTransition);
		//gsm.addTransition("overlay", OverlayTransition);
		//gsm.addTransition("fade", FadeTransition);
		//gsm.addTransition("mask", MaskTransition);
		
		gsm.setState("third", "direct");
		
		//trace("\n"+Manager.data.getTree([]));
		
		Manager.timer.addLoop(gsm.step);
		Manager.timer.addLoop(Manager.input.update);
		Manager.timer.addLoop(Manager.cursor.update);
		trace(Lib.current);
		
		//} catch(e:Dynamic) trace(e);
	}
}

/*class FirstState extends SpriteState
{
	var camera:SpriteCamera;
	
	public function new(fsm:FSM)
	{
		super(fsm);
		var dm = Manager.data;
		var b:Bitmap = dm.get(["manaGearz","utils","Pen Action 1"]);
		//b.width = 500;
		//b.height = 500;
		sprite.addChild(b);
		var but = new TintButton({bd:dm.get(["manaGearz","utils","skin"]).bitmapData, rect:RectangleUtils.fromPoint({x:16.0,y:16.0},{x:48.0,y:48.0}), over:{color:0xffffff,value:0.5}, down:{color:0x000000,value:0.5}});
		but.click = function()
		{
			Manager.sound.playSFX("flixel");
			//but.setWH(Math.random()*500, Math.random()*500);
			Manager.gameState.setState("second", "fade", {time:50, color:0xffffff});
		}
		but.setWH(100,50);
		sprite.addChild(but.sprite);
		
		camera = new SpriteCamera(sprite);
		var w = Manager.gameState.getStageWidth();
		var h = Manager.gameState.getStageHeight();
		//camera.setZoom(2);
		camera.setScreen(w, h);
		camera.setPOI(w/2, h/2);
		
		
		var dyn = {name:"Ali Jaya Meilio", age:16, sex:null, lazy:true, brave:false, favorite:["Computer", 15, null, {nista:14, nur:"bambam"}], another:{nested:{again:[null], bali:true}, someValue:14.567}};
		trace(dyn);
		var o = new haxe.io.BytesOutput();
		var w = new JSONBinaryWriter(o);
		w.write(dyn);
		var i = new haxe.io.BytesInput(o.getBytes());
		var r = new JSONBinaryReader(i);
		trace(r.read());
	}
	
	public function zoomIn()
	{
		camera.setZoom(camera.zoom+0.1);
	}
	
	public function zoomOut()
	{
		camera.setZoom(camera.zoom-0.1);
	}
	
	public override function enter()
	{
		super.enter();
		
		var kim = Manager.keyInput;
		
		kim.addInput("comma", zoomIn);
		kim.addInput("period", zoomOut);
	}
	
	public override function exit()
	{
		super.exit();
		
		Manager.keyInput.reset();
	}
	
	public override function execute()
	{
		camera.setPosition(Manager.cursor.position.x/camera.screen.x*camera.bound.x, Manager.cursor.position.y/camera.screen.y*camera.bound.y);
		camera.update();
	}
}

class SecondState extends SpriteState
{
	var anim:BDAnimation;
	var scale:TimerScale;
	
	public function new(fsm:FSM)
	{
		super(fsm);
		var dm = Manager.data;
		var b:Bitmap = dm.get(["manaGearz","utils","Pen Action 2"]);
		b.width = 500;
		b.height = 500;
		sprite.addChild(b);
		
		var h = new Hash<Array<Int>>();
		var a = new Array<Int>();
		for(n in 0...57)
		{
			a.push(n);
		}
		h.set("test", a);
		anim = new BDAnimation(dm.get(["manaGearz","utils","anim"]).bitmapData, 8, 8, h);
		//MonsterDebugger.inspect(anim);
		
		anim.setLoop(true);
		anim.setAction("test");
		//anim.play(true, true);
		sprite.addChild(anim.sprite);
		anim.sprite.scaleX = 50;
		anim.sprite.scaleY = 50;
		scale = new TimerScale(0.5, anim.step);
		
		var mask = new BitmapData(500,500,true,0);
		mask.perlinNoise(100, 80, 6, 30051994, false, true, true);
		
		sprite.addEventListener(MouseEvent.CLICK, function(_) Manager.gameState.setState("first", "mask", {time:50, mask:mask, smooth:0.3}));
	}
	
	public function pr()
	{
		if(anim.isPlaying) anim.pause() else anim.resume();
	}
	
	public function rv()
	{
		anim.setReverse(!anim.reverse);
	}
	
	public override function enter()
	{
		super.enter();
		
		var kim = Manager.keyInput;
		kim.reset();
		
		kim.addInput("comma", pr);
		kim.addInput("period", rv);
	}
	
	public override function exit()
	{
		super.exit();
	}
	
	public override function execute()
	{
		scale.step();
	}
}*/

class ThirdState extends SpriteState
{
	var state:Bool;
	var curX:Int;
	var curY:Int;
	var vx:ATXPMap;
	var empty:Array<Bool>;
	
	var grid:Sprite;
	
	public function new(fsm:FSM)
	{
		super(fsm);
		
		empty = [];
		for(n in 0...20*15)
		{
			empty.push(false);
		}
		
		curX = 0;
		curY = 0;
		
		state = true;
		
		//var m = Manager.data.getStr("manaGearz.utils.MapVX");
		//trace(m);
		var ts:BitmapData = Manager.data.getStr("manaGearz.utils.Mountain").bitmapData;
		
		vx = new ATXPMap(32, 32, 20, 15, function() return false );
		//vx.setAutoTile(ts);
		//vx.setMap(ATVXMap.int2bool(m.map));
		//vx.update();
		
		vx.setAutoTile(Manager.data.getStr("manaGearz.utils.Mountain").bitmapData);
		vx.updateMap();
		
		sprite.addChild(vx.bitmap);
		
		grid = new Sprite();
		grid.graphics.lineStyle(0, 0.3);
		for(n in 0...20)
		{
			grid.graphics.moveTo(n*32, 0);
			grid.graphics.lineTo(n*32, 480);
		}
		for(n in 0...15)
		{
			grid.graphics.moveTo(0, n*32);
			grid.graphics.lineTo(640, n*32);
		}
		grid.visible = false;
		
		sprite.addChild(grid);
	}
	
	public override function execute()
	{
		super.execute();
		var input = Manager.input;
		
		if(input.isPressed("1")) state = true;
		if(input.isPressed("2")) state = false;
		if(input.isPressed("3"))
		{
			vx.setMap(empty);
			vx.updateMap();
		}
		if(input.isPressed("z"))
		{
			vx.setAutoTile(Manager.data.getStr("manaGearz.utils.Mountain").bitmapData);
			vx.updateMap();
		}
		if(input.isPressed("x"))
		{
			vx.setAutoTile(Manager.data.getStr("manaGearz.utils.Mountain2").bitmapData);
			vx.updateMap();
		}
		if(input.isPressed("c"))
		{
			vx.setAutoTile(Manager.data.getStr("manaGearz.utils.Tree").bitmapData);
			vx.updateMap();
		}
		if(input.isPressed("v"))
		{
			vx.setAutoTile(Manager.data.getStr("manaGearz.utils.Snow").bitmapData);
			vx.updateMap();
		}
		if(input.isPressed("b"))
		{
			vx.setAutoTile(Manager.data.getStr("manaGearz.utils.Ground").bitmapData);
			vx.updateMap();
		}
		if(input.isPressed("n"))
		{
			vx.setAutoTile(Manager.data.getStr("manaGearz.utils.TreeTop").bitmapData);
			vx.updateMap();
		}
		if(input.isPressed("m"))
		{
			vx.setAutoTile(Manager.data.getStr("manaGearz.utils.Carpet").bitmapData);
			vx.updateMap();
		}
		if(input.isPressed("g"))
		{
			grid.visible = !grid.visible;
		}
		
		if(input.mouseDown)
		{
			put(input.mousePressed);
		}
	}
	
	function put(?first:Bool=false)
	{
		var x = Std.int(sprite.mouseX/32);
		var y = Std.int(sprite.mouseY/32);
		if(x>=20||y>=15) return;
		if(!first&&x==curX&&y==curY) return;
		curX = x;
		curY = y;
		vx.setReg(curX-1, curY-1, 3, 3, [null,state,null,state,state,state,null,state,null]);
		vx.updateReg(curX-2,curY-2,5,5);
	}
}