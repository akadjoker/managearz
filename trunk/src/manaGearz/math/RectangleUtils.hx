//
//  RectangleUtils.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 1/13/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package manaGearz.math;
using manaGearz.math.RectangleUtils;

class RectangleUtils 
{
	public static inline function create(x:Float, y:Float, width:Float, height:Float) : Rectangle
	{
		return { x:x, y:y, width:width, height:height };
	}
	
	public static inline function clone(r0:Rectangle) : Rectangle
	{
		return { x:r0.x, y:r0.y, width:r0.width, height:r0.height };
	}
	
	public static inline function area(r0:Rectangle) : Float
	{
		return r0.width*r0.height;
	}
	
	public static inline function size(r0:Rectangle) : Point
	{
		return { x:r0.width, y:r0.height };
	}
	
	public static inline function left(r0:Rectangle) : Float
	{
		return r0.x;
	}
	
	public static inline function right(r0:Rectangle) : Float
	{
		return r0.x+r0.width;
	}
	
	public static inline function top(r0:Rectangle) : Float
	{
		return r0.y;
	}
	
	public static inline function bottom(r0:Rectangle) : Float
	{
		return r0.y+r0.height;
	}
	
	public static inline function setLeft(r0:Rectangle, l:Float) : Float
	{
		r0.width += r0.x - l;
		r0.x = l;
		return l;
	}
	
	public static inline function setRight(r0:Rectangle, r:Float) : Float
	{
		r0.width = r - r0.x;
		return r;
	}
	
	public static inline function setTop(r0:Rectangle, t:Float) : Float
	{
		r0.height += r0.y - t;
		r0.y = t;
		return t;
	}
	
	public static inline function setBottom(r0:Rectangle, b:Float) : Float
	{
		r0.height = b - r0.y;
		return b;
	}
	
	public static inline function isEmpty(r0:Rectangle) : Bool
	{
		return (r0.width == 0) || (r0.height == 0);
	}
	
	public static inline function containsPoint(r0:Rectangle, p0:Point) : Bool
	{
		return (p0.x >= r0.left()) && (p0.x <= r0.right()) && (p0.y >= r0.top()) && (p0.y <= r0.bottom());
	}
	
	public static inline function containsRect(r0:Rectangle, r1:Rectangle) : Bool
	{
		return (r1.left() >= r0.left()) && (r1.right() <= r0.right()) && (r1.top() >= r0.top()) && (r1.bottom() <= r0.bottom());
	}
	
	public static inline function equals(r0:Rectangle, r1:Rectangle) : Bool
	{
		return (r1.left() == r0.left()) && (r1.right() == r0.right()) && (r1.top() == r0.top()) && (r1.bottom() == r0.bottom());
	}
	
	public static inline function nearEquals(r0:Rectangle, r1:Rectangle, ?t:Float = 0.0) : Bool
	{
		return (MathEx.abs(r1.left()-r0.left()) <= t) && (MathEx.abs(r1.right()-r0.right()) <= t) && (MathEx.abs(r1.top()-r0.top()) <= t) && (MathEx.abs(r1.bottom()-r0.bottom()) <= t);
	}
	
	public static inline function intersects(r0:Rectangle, r1:Rectangle) : Bool
	{
		return (r1.right() > r0.left()) && (r1.left() < r0.right()) && (r1.bottom() > r0.top()) && (r1.top() < r0.bottom());
	}
	
	public static inline function fromPoint(p0:Point, p1:Point) : Rectangle
	{
		return { x:MathEx.min(p0.x, p1.x), y:MathEx.min(p0.y, p1.y), width:MathEx.abs(p1.x-p0.x), height:MathEx.abs(p1.y-p0.y) };
	}
	
	public static inline function inflate(r0:Rectangle, p0:Point) : Rectangle
	{
		return { x:r0.x-p0.x, y:r0.y-p0.y, width:r0.width+2*p0.x, height:r0.height+2*p0.y };
	}
	
	public static inline function offset(r0:Rectangle, p0:Point) : Rectangle
	{
		return { x:r0.x+p0.x, y:r0.y+p0.y, width:r0.width, height:r0.height };
	}
		
	public static inline function intersection(r0:Rectangle, r1:Rectangle) : Rectangle
	{
		var x = MathEx.max(r0.left(), r1.left());
		var y = MathEx.max(r0.top(), r1.top());
		return { x:x, y:y, width:MathEx.min(r0.right(), r1.right())-x, height:MathEx.min(r0.bottom(), r1.bottom())-y };
	}
	
	public static inline function union(r0:Rectangle, r1:Rectangle) : Rectangle
	{
		var x = MathEx.min(r0.left(), r1.left());
		var y = MathEx.min(r0.top(), r1.top());
		return { x:x, y:y, width:MathEx.max(r0.right(), r1.right())-x, height:MathEx.max(r0.bottom(), r1.bottom())-y };
	}
	
	#if flash
	public static inline function toFlash(r0:Rectangle) : flash.geom.Rectangle
	{
		return new flash.geom.Rectangle(r0.x, r0.y, r0.width, r0.height);
	}
	
	public static inline function fromFlash(r0:flash.geom.Rectangle) : Rectangle
	{
		return { x:r0.x, y:r0.y, width:r0.width, height:r0.height };
	}
	#end
}