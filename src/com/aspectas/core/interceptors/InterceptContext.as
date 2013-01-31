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
package com.aspectas.core.interceptors
{
	import com.aspectas.core.interfaces.IInterceptContext;

	public class InterceptContext implements IInterceptContext
	{
		
		//-------------------------------
		// Variables
		//-------------------------------
		private var _arguments:*;
		private var _returnValue:*;
		private var _targetInstance:*;
		private var _kind:String;
		private var _targetMethod:Function;
		private var _targetMember:String;
		private var _lastResult:* = null;
		private var _procced:Boolean = true;;
		private var _functionExecuted:Boolean = false;
		
		//-------------------------------
		// Constructor
		//-------------------------------
		/**
		 * Constructor
		 */		
		public function InterceptContext(
										arguments:*,
										returnValue:*,
										targetInstance:*,
										kind:String,
										targetMethod:Function,
										targetMember:String
										)
		{
			
			this._arguments = arguments;
			this._returnValue = returnValue;
			this._targetInstance = targetInstance;
			this._kind = kind;
			this._targetMethod = targetMethod;
			this._targetMember = targetMember;
		}
		
		//-------------------------------
		// Getters and Setters
		//-------------------------------
		public function get arguments():*
		{
			return this._arguments;
		}
		
		public function get returnValue():*
		{
			return this._returnValue;	
		}
		
		public function get targetInstance():*
		{
			return this._targetInstance;
		}
		
		public function get kind():String
		{
			return this._kind;
		}
		
		public function get targetMethod():Function
		{
			return this._targetMethod;
		}
		
		public function get targetMember():String
		{
			return this._targetMember;
		}
		
		public function get lastResult():*
		{
			return this._lastResult;
		}
		public function set lastResult(value:*):void
		{
			this._lastResult = value;
		}
		
		public function get procced():Boolean 
		{
			return this._procced;
		}
		public function set procced(value:Boolean):void
		{
			this._procced = value;
		}
		
		public function get functionExecuted():Boolean 
		{
			return this._functionExecuted;
		}
		
		//-------------------------------
		// Public methods
		//-------------------------------
		/**
		 * @inheritDoc
		 */
		public function getFunctionValue():*
		{
			if ( this.targetMethod != null && targetInstance != null ) 
			{
				this._functionExecuted = true;
				return this.targetMethod.apply(this.targetInstance, this.arguments);
			}
			return null;
		}
	}
}