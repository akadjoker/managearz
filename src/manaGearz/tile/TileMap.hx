//
//  TileMap.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 5/16/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package manaGearz.tile;

class TileMap<T> 
{
	var map:Array<T>;
	public var width(default, null):Int;
	public var height(default, null):Int;
	public var area(default, null):Int;
	
	public function new(width:Int, height:Int, ?initTile:Void->T=null)
	{
		this.width = width;
		this.height = height;
		this.area = width*height;
		map = [];
		if(initTile != null)
		{
			for(n in 0...area)
			{
				map[n] = (initTile());
			}
		}
	}
	
	public function setMap(map:Array<T>) : Array<T>
	{
		if(map.length != area) throw "The map length is "+map.length+", expected length is "+area;
		this.map = map.copy();
		return map;
	}
	
	public function getMap() : Array<T>
	{
		return this.map.copy();
	}
	
	public function getXY(x:Int, y:Int) : T
	{
		//if(!checkXY(x,y)) throw "Position ( "+x+", "+y+" ) is not in the map";
		if(!checkXY(x,y)) return null;
		return map[y*width+x];
	}
	
	public function setXY(x:Int, y:Int, tile:T) : T
	{
		//if(!checkXY(x,y)) throw "Position ( "+x+", "+y+" ) is not in the map";
		if(tile==null) return tile;
		if(!checkXY(x,y)) return tile;
		map[y*width+x] = tile;
		return tile;
	}
	
	public function getReg(x:Int, y:Int, width:Int, height:Int) : Array<T>
	{
		//if(!checkXY(x,y)||!checkXY(x+width,y+height)) throw "Region ( "+x+", "+y+", "+(x+width)+", "+(y+height)+" is not in the map";
		
		var c = clampReg(x,x+width,y,y+width);
		var dx = c.x-x;
		var dy = c.y-y;
		
		var reg : Array<T> = [];
		
		for(j in 0...c.height)
		{
			for(i in 0...c.width)
			{
				reg[(j+dy)*width+(i+dx)] = map[(j+c.y)*this.width+(i+c.x)];
			}
		}
		
		return reg;
	}
	
	public function setReg(x:Int, y:Int, width:Int, height:Int, reg:Array<T>) : Array<T>
	{
		if(reg.length != width*height) throw "The region length is "+reg.length+", expected length is "+(width*height);
		//if(!checkXY(x,y)||!checkXY(x+width,y+height)) throw "Region ( "+x+", "+y+", "+(x+width)+", "+(y+height)+" is not in the map";
		
		var c = clampReg(x,x+width,y,y+width);
		var dx = c.x-x;
		var dy = c.y-y;
		
		for(j in 0...c.height)
		{
			for(i in 0...c.width)
			{
				var t = reg[(j+dy)*c.width+(i+dx)];
				if(t==null) continue;
				map[(j+c.y)*this.width+(i+c.x)] = t;
			}
		}
		
		return reg;
	}
	
	public function checkXY(x:Int, y:Int) : Bool
	{
		return (x>=0&&x<width&&y>=0&&y<height);
	}
	
	public function clampReg(l:Int, r:Int, t:Int, b:Int) : {x:Int, y:Int, width:Int, height:Int}
	{
		l = (l>0)?l:0;
		r = (r<width)?r:width;
		t = (t>0)?t:0;
		b = (b<height)?b:height;
		return {x:l, y:t, width:r-l, height:b-t};
	}
	
	// override this
	public function updateXY(x:Int, y:Int)
	{
		
	}
	
	public function updateReg(x:Int, y:Int, width:Int, height:Int)
	{
		//if(!checkXY(x,y)||!checkXY(x+width,y+height)) throw "Region ( "+x+", "+y+", "+(x+width)+", "+(y+height)+" is not in the map";
		
		var c = clampReg(x,x+width,y,y+width);
		
		for(j in 0...c.height)
		{
			for(i in 0...c.width)
			{
				updateXY(c.x+i, c.y+j);
			}
		}
	}
	
	public function updateMap()
	{
		for(j in 0...this.height)
		{
			for(i in 0...this.width)
			{
				updateXY(i, j);
			}
		}
	}
}