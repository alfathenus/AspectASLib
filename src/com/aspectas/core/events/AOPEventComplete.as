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
	
	import mx.rpc.events.ResultEvent;
	
	/**
	 * Event for Completetion of AOP initializacion
	 */
	public class AOPEventComplete extends Event
	{
		//-------------------------------
		// Constants
		//-------------------------------
		public static const COMPLETE:String = "aopcomplete";
		
		//-------------------------------
		// Constructor
		//-------------------------------
		/**
		 * Constructor
		 */
		public function AOPEventComplete(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		
		//-------------------------------
		// Public methods
		//-------------------------------
		/**
		 * Static method for quickly event creation
		 */
		public static function createEvent(bubbles:Boolean = false, cancelable:Boolean = false):AOPEventComplete
		{
			return new AOPEventComplete(COMPLETE, bubbles, cancelable);
		}
	}
}