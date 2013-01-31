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
	import com.aspectas.core.events.AOPEventComplete;
	import com.aspectas.core.interceptors.AOPInterceptor;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.utils.Dictionary;
	
	import org.as3commons.bytecode.interception.impl.BasicMethodInvocationInterceptor;
	import org.as3commons.bytecode.proxy.IClassProxyInfo;
	import org.as3commons.bytecode.proxy.event.ProxyFactoryBuildEvent;
	import org.as3commons.bytecode.proxy.event.ProxyFactoryEvent;
	import org.as3commons.bytecode.proxy.impl.ProxyFactory;
	import org.as3commons.bytecode.proxy.impl.ProxyInfo;

	/**
	 * The weaver of AOP framework
	 */
	public class AOPWeaver extends EventDispatcher
	{
		//-------------------------------
		// Variables
		//-------------------------------
		private var _proxyFactory:ProxyFactory;
		private var _weaverLogicalRep:Dictionary;
		
		//-------------------------------
		// Constructor
		//-------------------------------
		/**
		 * Constructor
		 */
		public function AOPWeaver()
		{
			
		}
		
		//-------------------------------
		// Getters and Setters
		//-------------------------------
		public function get proxyFactory():ProxyFactory
		{
			return this._proxyFactory;
		}
		
		//-------------------------------
		// Public methods
		//-------------------------------
		/**
		 * TODO: Do documentation
		 */
		public function build(context:AppDomainContext, weaverLogicalRep:Dictionary):void
		{
			this._weaverLogicalRep = weaverLogicalRep;
			this._proxyFactory = new ProxyFactory();
			this._proxyFactory.addEventListener(ProxyFactoryBuildEvent.BEFORE_METHOD_BODY_BUILD, beforeMethodBuildHandler);
			this._proxyFactory.addEventListener(ProxyFactoryBuildEvent.AFTER_PROXY_BUILD, afterProxyBuilderHandler);
			this._proxyFactory.addEventListener(ProxyFactoryEvent.GET_METHOD_INVOCATION_INTERCEPTOR, getMethodInterceptor);
			this._proxyFactory.addEventListener(Event.COMPLETE, handleLoaded);
			this._proxyFactory.addEventListener(IOErrorEvent.VERIFY_ERROR, handleVerifyError);
			
			var className:String;
			var clazz:Class;
			var classProxyInfo:IClassProxyInfo;
			var dic:Dictionary = weaverLogicalRep;
			var item:Object;
			var elemsGet:Dictionary;
			var elemSet:Dictionary;
			var elemMethod:Dictionary;
			var elem:String;
			for ( className in dic ) 
			{
				item = dic[className];
				if ( item != null ) 
				{
					clazz = context.appDomain.getDefinition(className) as Class;
					if ( clazz != null ) {
						classProxyInfo= this._proxyFactory.defineProxy(clazz, null, context.appDomain);
					}
					elemsGet = item["gets"];
					for ( elem in elemsGet ) 
					{
						classProxyInfo.proxyAccessor(elem);
					}
					elemSet = item["sets"];
					for ( elem in elemSet ) 
					{
						if ( !elemsGet.hasOwnProperty(elem) ) 
						{
							classProxyInfo.proxyAccessor(elem);
						}
					}
					elemMethod = item["methods"];
					for ( elem in elemMethod ) 
					{
						classProxyInfo.proxyMethod(elem);
					}
				}
			}
			
			this._proxyFactory.generateProxyClasses();
			this._proxyFactory.loadProxyClasses();
			dic = weaverLogicalRep;
			var dicAux:Dictionary = new Dictionary();
			var proxyInfo:ProxyInfo;
			for ( className in dic ) 
			{
				proxyInfo = this._proxyFactory.getProxyInfoForClass(dic[className].classRef);
				if ( proxyInfo != null ) 
				{
					dicAux[proxyInfo.proxyClassName] = dic[className];
				}
			}
			for ( className in dicAux )
			{
				dic[className] = dicAux[className];
			}
			dicAux = null;
		}
		
		//-------------------------------
		// Private Methods
		//-------------------------------
		private function handleLoaded(event:Event):void {
			event.stopImmediatePropagation();
			
			this.dispatchEvent(AOPEventComplete.createEvent());
		}
		
		private function handleVerifyError(event:IOErrorEvent):void {
			event.stopImmediatePropagation();
		}
		
		private function beforeMethodBuildHandler(event:ProxyFactoryBuildEvent):void {
			event.stopImmediatePropagation();
			/* Do something ? */
		}
		
		private function afterProxyBuilderHandler(event:ProxyFactoryBuildEvent):void {
			event.stopImmediatePropagation();
			/* Do something ? */
		}
		
		private function getMethodInterceptor(event:ProxyFactoryEvent):void {
			event.stopPropagation();
			var interceptor:BasicMethodInvocationInterceptor = new event.methodInvocationInterceptorClass() as BasicMethodInvocationInterceptor;
			var interceptorObj:AOPInterceptor = new AOPInterceptor();
			interceptorObj.data = this._weaverLogicalRep;
			interceptor.interceptors[interceptor.interceptors.length] = interceptorObj;
			event.methodInvocationInterceptor = interceptor;
		}
	}
}