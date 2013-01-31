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
	import com.aspectas.core.interfaces.IPointCut;
	
	import org.as3commons.reflect.Metadata;
	import org.as3commons.reflect.Method;
	
	/**
	 * Is a logical representation for an Advice. It is used for Aspect class.
	 * 
	 * @see com.aspectas.core.elements.Aspect
	 * 
	 * @example of a method class that we want to create the advice.
	 * <pre>
	 * [After("execution(com.app.modules.Module1.load()")]
	 * public function adviceForLog():* {}
	 * </pre>
	 */
	public class Advice implements IAdvice
	{
		//-------------------------------
		// Variables
		//-------------------------------
		private var _pointcut:IPointCut;
		private var _foo:Function;
		private var _type:String;
		private var _added:Boolean = false;
		
		//-------------------------------
		// Constructor
		//-------------------------------
		/**
		 * Constructor
		 */
		public function Advice()
		{
		}
		
		//-------------------------------
		// Getters and Setters
		//-------------------------------
		/**
		 * @inheritDoc
		 */
		public function get pointcut():IPointCut 
		{
			return this._pointcut;
		}
		public function set pointcut(value:IPointCut):void
		{
			this._pointcut = value;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get foo():Function
		{
			return this._foo;
		}
		public function set foo(value:Function):void
		{
			this._foo = value;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get type():String
		{
			return this._type
		}
		public function set type(value:String):void
		{
			this._type = value;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get added():Boolean
		{
			return this._added;
		}
		public function set added(value:Boolean):void
		{
			this._added = value;
		}
		
		//-------------------------------
		// Public methods
		//-------------------------------
		/**
		 * This method create an Advice object form a reflection method. The source for the
		 * reflection is a ByteArray from bytecode library.
		 * 
		 * @param method		ByteArray from bytecode library
		 * @param aspect		The Aspect that will be content the advice
		 */
		public static function createFromReflectMethod(method:Method, aspect:IAspect):IAdvice
		{
			if ( method == null || aspect == null || aspect.object == null ) 
			{
				return null;
			}
			if ( method.metadata.length < 1 || !(aspect.object as Object).hasOwnProperty(method.name)) {
				return null;
			}
			
			var advice:Advice = new Advice();
			advice.pointcut = PointCut.createFromString((method.metadata[0] as Metadata).arguments[0].value, aspect);
			if ( advice.pointcut == null )
			{
				return null;
			}
			advice.type = (method.metadata[0] as Metadata).name;
			advice.foo = aspect.object[method.name];
			return advice;
		}
	}
}