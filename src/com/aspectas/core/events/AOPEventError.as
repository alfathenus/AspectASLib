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
package com.aspectas.core.events
{
	import flash.events.Event;
	
	public class AOPEventError extends Event
	{
		//-------------------------------
		// Constants
		//-------------------------------
		public static const ERROR:String = "aoperror";
		
		//-------------------------------
		// Variables
		//-------------------------------
		/**
		 * TODO: Do documentation
		 */
		public var code:String;
		/**
		 * TODO: Do documentation
		 */
		public var msg:String;
		
		//-------------------------------
		// Constructor
		//-------------------------------
		/**
		 * Constructor
		 */
		public function AOPEventError(type:String, msg:String, code:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.msg = msg;
			this.code = code;
		}
		
		//-------------------------------
		// Public methods
		//-------------------------------
		/**
		 * TODO: Do documentation
		 */
		public static function createEvent(msg:String, code:String, bubbles:Boolean = false, cancelable:Boolean = false):AOPEventError
		{
			return new AOPEventError(ERROR, msg, code, bubbles, cancelable);
		}
	}
}