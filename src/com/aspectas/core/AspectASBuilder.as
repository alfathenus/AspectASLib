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
package com.aspectas.core
{
	import com.aspectas.core.elements.Advice;
	import com.aspectas.core.elements.Aspect;
	import com.aspectas.core.elements.PointCut;
	import com.aspectas.core.errors.AOPErrorsContants;
	import com.aspectas.core.events.AOPEventComplete;
	import com.aspectas.core.events.AOPEventError;
	import com.aspectas.core.utils.AdviceTypes;
	import com.aspectas.core.utils.PointcutTypes;
	
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.system.ApplicationDomain;
	import flash.utils.Dictionary;
	
	import mx.utils.StringUtil;
	
	import org.as3commons.bytecode.proxy.IClassProxyInfo;
	import org.as3commons.bytecode.proxy.impl.ProxyFactory;
	import org.as3commons.bytecode.reflect.ByteCodeType;
	import org.as3commons.reflect.Method;
	import org.as3commons.reflect.Type;

	/**
	 * Builder for de weaver
	 */
	public class AspectASBuilder extends EventDispatcher
	{
		//-------------------------------
		// Variables
		//-------------------------------
		public var onCompleteCallback:Function;
		private var _aspectsLogicRep:LogicAspectRepresentation;
		private var _weaverLogicRep:LogicWeaverRepresentation;
		private var _aopWeaver:AOPWeaver;
		private var _contexts:Dictionary;
		
		//-------------------------------
		// Constructor
		//-------------------------------
		/**
		 * Constructor
		 */
		public function AspectASBuilder()
		{
			this.initObject();
		}
		
		//-------------------------------
		// Public methods
		//-------------------------------
		/**
		 * Create all aspect concerns
		 * Template Method pattern
		 */
		public function build(context:AppDomainContext):void//loaderInfo:LoaderInfo, appDomain:ApplicationDomain):void
		{
			if ( !validateContext(context) ) 
			{
				this.dispatchEvent(AOPEventError.createEvent(
															AOPErrorsContants.ERROR_CONTEXT_MSG,
															AOPErrorsContants.ERROR_CONTEXT_CODE
															)
									);
				return;
			}
			
			this.setContext(context);
			
			//firt layer of abstraction
			this.createLogicRepresentation(context);
			
			//second layer of abstraction
			this.createWeaverRepresentation(context);
			
			//AOP weaver
			this.buildWeaver(context, this._weaverLogicRep.weaverLogicRepDic);
			
			//AOP factory
			//this.buildAOPFactory();
		}
		
		//-------------------------------
		// Protected methods
		//-------------------------------
		/**
		 * TODO: Do documentation
		 */
		protected function createLogicRepresentation(context:AppDomainContext):void 
		{
			this._aspectsLogicRep = new LogicAspectRepresentation();
			this._aspectsLogicRep.build(context);
		}
		
		/**
		 * TODO: Do documentation
		 */
		protected function createWeaverRepresentation(context:AppDomainContext):void
		{
			this._weaverLogicRep = new LogicWeaverRepresentation();
			this._weaverLogicRep.build(context, this._aspectsLogicRep.aspectsLogicRepDic);
		}
		
		/**
		 * Create a proxies objects for classes to has advices
		 */
		protected function buildWeaver(context:AppDomainContext, weaverLogicalRep:Dictionary):void 
		{
			this._aopWeaver = new AOPWeaver();
			this._aopWeaver.addEventListener(AOPEventComplete.COMPLETE, handleLoaded);
			this._aopWeaver.build(context, weaverLogicalRep);
		}
		
		/**
		 * Validate if the context it was setted correctly.
		 * 
		 * @param context			The context to validate
		 */
		protected function validateContext(context:AppDomainContext):Boolean
		{
			return context != null && StringUtil.trim(context.name) != "" && context.appDomain != null && context.loaderInfo != null; 
		}
		
		/**
		 * TODO: Do documentation
		 */
		protected function setContext(context:AppDomainContext):void
		{
			if ( context != null ) 
			{
				this._contexts[context.name] = context;
			}
		}
		
		/**
		 * TODO: Do documentation
		 */
		protected function getContext(contextName:String):AppDomainContext
		{
			if ( this._contexts.hasOwnProperty(contextName) )
			{
				return this._contexts[contextName];
			}
			
			return null;
		}
		
		/**
		 * TODO: Do documentation
		 */
		protected function buildAOPFactory():void 
		{
			var aopFactory:AOPFactory = AOPFactory.getInstance();
			aopFactory.proxyFactory = this._aopWeaver.proxyFactory;	
		}
		
		//-------------------------------
		// Private Methods
		//-------------------------------
		private function handleLoaded(event:Event):void {
			event.stopImmediatePropagation();
			
			this._aopWeaver.removeEventListener(AOPEventComplete.COMPLETE, handleLoaded);
			
			this.buildAOPFactory();
			
			if ( this.onCompleteCallback != null ) {
				this.onCompleteCallback.apply();
			}
		}
		
		private function initObject():void {
			this._contexts = new Dictionary();
		}
	}
}