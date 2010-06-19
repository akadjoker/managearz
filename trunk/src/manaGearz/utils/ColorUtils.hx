//
//  ColorUtils.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 1/20/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package manaGearz.utils;
import flash.geom.ColorTransform;

import manaGearz.math.MathEx;

class ColorUtils 
{
	public static inline function interpolateCT(first:ColorTransform, second:ColorTransform, t:Float) : ColorTransform
	{
		var ct = new ColorTransform();
		
		ct.alphaMultiplier = MathEx.interpolate(first.alphaMultiplier, second.alphaMultiplier, t);
		ct.redMultiplier = MathEx.interpolate(first.redMultiplier, second.redMultiplier, t);
		ct.greenMultiplier = MathEx.interpolate(first.greenMultiplier, second.greenMultiplier, t);
		ct.blueMultiplier = MathEx.interpolate(first.blueMultiplier, second.blueMultiplier, t);
		
		ct.alphaOffset = MathEx.interpolate(first.alphaOffset, second.alphaOffset, t);
		ct.redOffset = MathEx.interpolate(first.redOffset, second.redOffset, t);
		ct.greenOffset = MathEx.interpolate(first.greenOffset, second.greenOffset, t);
		ct.blueOffset = MathEx.interpolate(first.blueOffset, second.blueOffset, t);
		
		return ct;
	}
	
	public static inline function tintCT(color:Int, value:Float) : ColorTransform
	{
		var ct = new ColorTransform();
		var m = 1-value;
		ct.color = color;
		
		ct.redMultiplier = m;
		ct.greenMultiplier = m;
		ct.blueMultiplier = m;
		
		ct.redOffset *= value;
		ct.greenOffset *= value;
		ct.blueOffset *= value;
		
		return ct;
	}
}