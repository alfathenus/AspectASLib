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
	import com.aspectas.core.interfaces.IAdvice;
	import com.aspectas.core.interfaces.IAspect;
	
	import flash.utils.Dictionary;
	
	/**
	 * This is a Logical representation of an Aspect.
	 * It can be created from any thing (XML, Object, etc. - at this moment only form an Class with
	 * Aspect Metadata setted)
	 */
	public class Aspect implements IAspect
	{
		//-------------------------------
		// Variables
		//-------------------------------
		private var _name:String;
		private var _className:String; 
		private var _object:*;
		private var _pointCuts:Dictionary
		private var _advices:Vector.<IAdvice>;
		
		//-------------------------------
		// Constructor
		//-------------------------------
		/**
		 * Constructor
		 */
		public function Aspect()
		{
			this._pointCuts = new Dictionary();
			this._advices = new <IAdvice>[];
		}
		
		//-------------------------------
		// Getters and Setters
		//-------------------------------
		/**
		 * @inheritDoc
		 */
		public function get advices():Vector.<IAdvice>
		{
			return this._advices;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get name():String
		{
			return this._name;
		}
		public function set name(value:String):void
		{
			this._name = value;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get className():String
		{
			return this._className;
		}
		public function set className(value:String):void
		{
			this._className = value;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get object():*
		{
			return this._object;
		}
		public function set object(value:*):void
		{
			this._object = value;
		}
		//-------------------------------
		// Public methods
		//-------------------------------
		/**
		 * @inheritDoc
		 */
		public function addPointCut(name:String, pointCut:String):void 
		{
			if ( pointCut != null ) {
				this._pointCuts[name] = pointCut;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function addAdvice(advice:IAdvice):void {
			if ( advice != null ) {
				this._advices.push(advice);
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function getPointcutByName(name:String):String
		{
			if ( this._pointCuts.hasOwnProperty(name) ) {
				return this._pointCuts[name];
			}
			
			return null;
		}
	}
}