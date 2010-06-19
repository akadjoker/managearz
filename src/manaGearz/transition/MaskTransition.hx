//
//  DissolveTransition.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 1/17/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package manaGearz.transition;
import flash.display.IBitmapDrawable;
import flash.display.Shader;
import flash.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.filters.ShaderFilter;
import flash.geom.Matrix;

import manaGearz.manager.Manager;
import manaGearz.fsm.FSM;
import manaGearz.state.SpriteState;
import manaGearz.math.MathEx;

class MaskTransition extends SpriteTransition
{
	public var mask(default, null):IBitmapDrawable;
	public var defaultMask(default, null):IBitmapDrawable;
	
	public var smooth(default, null):Float;
	public var defaultSmooth(default, null):Float;
	
	public var channel(default, null):Int;
	public var defaultChannel(default, null):Int; // 0 : red, 1 : green, 2 : blue, 3 : alpha
	
	private var curMask:BitmapData;
	
	private var shader:Shader;
	private var filter:ShaderFilter;
	
	public function new(fsm:FSM, ?first:SpriteState, ?second:SpriteState)
	{
		super(fsm, first, second);
		shader = new Shader(Manager.data.get(["manaGearz","utils","BitmapMasking"]));
		filter = new ShaderFilter(shader);
		defaultTime = 100;
		defaultMask = new BitmapData(1,1,false,0xffffff);
		defaultSmooth = 0;
		defaultChannel = 0;
		time = defaultTime;
		mask = defaultMask;
		smooth = defaultSmooth;
		channel = defaultChannel;
	}
	
	public override function init(d:Dynamic)
	{
		super.init(d);
		mask = (d.mask!=null)? d.mask : defaultMask;
		smooth = (d.smooth!=null)? d.smooth : defaultSmooth;
		channel = (d.channel!=null)? d.channel : defaultChannel;
	}
	
	public override function enter()
	{
		super.enter();
		
		if(secondSprite!=null)
		{
			var gsm = Manager.gameState;
			
			curMask = new BitmapData(MathEx.round(secondSprite.width), MathEx.round(secondSprite.height), true, 0);
			var m = new Matrix();
			m.scale(curMask.width/(cast mask).width, curMask.height/(cast mask).height);
			curMask.draw(mask, m);
			
			shader.data.mask.input = curMask;
			shader.data.smooth.value = [smooth];
			shader.data.channel.value = [channel];
			shader.data.time.value = [0.0];
			
			secondSprite.filters = [filter];
			gsm.root.addChild(secondSprite);
		}
	}
	
	private override function trans()
	{
		if(secondSprite!=null)
		{
			shader.data.time.value = [interval];
			secondSprite.filters = secondSprite.filters;
		}
	}
	
	public override function exit()
	{
		var gsm = Manager.gameState;
		if(firstSprite!=null) gsm.root.removeChild(firstSprite);
		if(secondSprite!=null) secondSprite.filters = null;
	}
}