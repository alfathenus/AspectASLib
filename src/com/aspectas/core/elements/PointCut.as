/*
MIT LICENCE

Copyright (c) <2012> <Andres Lozada Mosto>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software 
and associated documentation files (the "Software"), to deal in the Software without 
restriction, including without limitation the rights to use, copy, modify, merge, publish, 
distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom 
the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or 
substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR 
PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE 
FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
DEALINGS IN THE SOFTWARE.

@licence 	http://www.opensource.org/licenses/mit-license.php
@author 	Andres Lozada Mosto <andres.lozadamosto@gmail.com>
@nickname 	alfathenus <alfathenus@gmail.com>
@copyright	2012 Andrés Lozada Mosto <andres.lozadamosto@gmail.com>

*/
package com.aspectas.core.elements
{
	import com.aspectas.core.interfaces.IAspect;
	import com.aspectas.core.interfaces.IPointCut;
	import com.aspectas.core.utils.PointcutTypes;
	import com.aspectas.core.utils.PointcutValidator;

	/**
	 * Logical implementation of Pointcut
	 */
	public class PointCut implements IPointCut
	{
		//-------------------------------
		// Variables
		//-------------------------------
		private var _expresion:String;
		private var _wildcard:String = "";
		private var _jointPoint:String = "";
		private var _fullClassName:String = "";
		private var _element:String = "";
		
		//-------------------------------
		// Constructor
		//-------------------------------
		/**
		 * Constructor
		 */
		public function PointCut()
		{
		}
		
		//-------------------------------
		// Getters and Setters
		//-------------------------------
		/**
		 * @inheritDoc
		 */
		public function get expresion():String
		{
			return this._expresion;
		}
		public function set expresion(value:String):void
		{
			this._expresion = value;
		}
		//-------------------------------
		// Public methods
		//-------------------------------
		/**
		 * @inheritDoc
		 */
		public function getWildCard():String
		{
			if ( this._wildcard != "" ) 
			{
				return this._wildcard;
			}
			if ( this.expresion == "" )
			{
				return "";
			}
			
			var index:Number = this.expresion.indexOf("(");
			var index2:Number = this.expresion.indexOf(" ");
			
			if ( index2 > -1 && index2 < index ) {
				index = index2;
			}
			
			if ( index > -1 ) 
			{
				return this.expresion.substr(0, index);
			}
			
			return "";
		}
		
		/**
		 * @inheritDoc
		 */
		public function getClass():String
		{
			if ( this._fullClassName != "" )
			{
				return this._fullClassName;
			}
			/*if ( this.expresion == "" ) 
			{
				return "";
			}*/
			//var r:RegExp = PointcutValidator.RegExpFullClassName;
			//var v:Array = this.expresion.match(PointcutValidator.RegExpFullClassName);
			
			var s:String = this.getJointpoint();
			if ( s != "" )
			{
				var index:int = s.lastIndexOf(".");
				if ( index > -1 )
				{
					return s.substring(0, index);
				}
			}
			
			return s;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getElement():String
		{
			if ( this._element != "" ) 
			{
				return this._element;
			}
			/*if ( this.expresion == "" ) 
			{
				return "";
			}
			var r:RegExp = PointcutValidator.RegExpFullMethodName;
			var v:Array = this.expresion.match(PointcutValidator.RegExpFullClassName);
			
			return "";*/
			var s:String = this.getJointpoint();
			if ( s != "" )
			{
				var index:int = s.lastIndexOf(".");
				var index2:int = s.indexOf("(");
				if ( index > -1 && index2 > -1 && index2 > index ) 
				{
					return s.substring(index+1, index2);
				}
			}
			
			return s;
		}
		
		/**
		 * @inheritDoc
		 */
		public static function createFromString(value:String, aspect:IAspect):IPointCut {
			if ( value == "" )
			{
				return null;
			}
			
			var expression:String = "";
			if ( PointcutValidator.isPointcutExpression(value) ) 
			{
				expression = value;
			}
			else if ( PointcutValidator.isPointcutName(value) && aspect != null) 
			{
				expression = aspect.getPointcutByName(value);
				if ( !PointcutValidator.isPointcutExpression(expression) ) 
				{
					expression = "";
				}
			}
			
			if ( expression != "" && expression != null )
			{
				var pointcut:PointCut = new PointCut();
				pointcut.expresion = expression;
				return pointcut;
			}
			
			return null;
		}
		
		//-------------------------------
		// Protected methods
		//-------------------------------
		/**
		 * TODO: Do documentation
		 */
		protected function getJointpoint():String
		{
			if ( this._jointPoint != "" )
			{
				return this._jointPoint;
			}
			if ( this.expresion == "" )
			{
				return "";
			}
			
			var index:int = this.expresion.indexOf("(");
			var index2:int = this.expresion.lastIndexOf(")");
			
			return this.expresion.substring(index+1, index2);
		}
	}
}