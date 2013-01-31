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
package com.aspectas.core.preload
{
	import com.aspectas.core.AppDomainContext;
	import com.aspectas.core.AspectASBuilder;
	import com.aspectas.core.events.AOPEventComplete;
	
	import flash.events.Event;
	import flash.events.ProgressEvent;
	
	import mx.core.FlexGlobals;
	import mx.events.RSLEvent;
	import mx.preloaders.SparkDownloadProgressBar;
	
	import org.as3commons.bytecode.reflect.ByteCodeType;
	
	/**
	 * Custom preload for AspectAS.
	 * It controls de AOP instantiation and IOC configuration.
	 */
	public class AspectASPreload extends SparkDownloadProgressBar
	{
		//-------------------------------
		// Variables
		//-------------------------------
		private var _aspectASBuilder:AspectASBuilder;
		
		//-------------------------------
		// Constructor
		//-------------------------------
		/**
		 * Constructor
		 */
		public function AspectASPreload()
		{
			super();
			this._aspectASBuilder = new AspectASBuilder();
			this._aspectASBuilder.onCompleteCallback = onAOPComplete;
		}
		
		//-------------------------------
		// Public methods
		//-------------------------------
		/**
		 * @inheritDoc
		 */
		override public function initialize():void 
		{
			super.initialize();
		}
		
		/**
		 * @private
		 */    
		override public function get backgroundSize():String{
			return "100%";
		}
		
		//------------------------
		// protected methods
		//------------------------
		/**
		 * @private
		 */      
		override protected function showDisplayForInit(elapsedTime:int, count:int):Boolean {
			return true;
		}
		
		/**
		 * @private
		 */     
		override protected function showDisplayForDownloading(elapsedTime:int, event:ProgressEvent):Boolean {
			return true;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function rslCompleteHandler(event:RSLEvent):void 
		{
			super.rslCompleteHandler(event);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function rslErrorHandler(event:RSLEvent):void 
		{
			super.rslErrorHandler(event);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function completeHandler(event:Event):void 
		{
			super.completeHandler(event);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function initCompleteHandler(event:Event):void
		{
			
			super.initCompleteHandler(event);
			
			this._aspectASBuilder.build(
										new AppDomainContext(
											"appComplete",
											FlexGlobals.topLevelApplication.loaderInfo, 
											FlexGlobals.topLevelApplication.loaderInfo.applicationDomain
											)
										);
		}
		
		/**
		 * Handler for AOP complete event
		 */
		protected function onAOPComplete():void {
			
			this._aspectASBuilder.onCompleteCallback =  null;
			
			FlexGlobals.topLevelApplication.dispatchEvent(AOPEventComplete.createEvent());
		}
	}
}