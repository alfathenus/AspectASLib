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
	
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	import org.as3commons.bytecode.interception.IInterceptor;
	import org.as3commons.bytecode.interception.IMethodInvocation;
	import org.as3commons.bytecode.interception.impl.InvocationKind;
	
	/**
	 * Interceptor for all calls.
	 * TODO: Do documentation
	 */
	public class AOPInterceptor implements IInterceptor
	{
		//-------------------------------
		// Variables
		//-------------------------------
		/**
		 * TODO: Think how I can doing this better
		 */
		public var data:Dictionary;
		//-------------------------------
		// Constructor
		//-------------------------------
		/**
		 * Constructor
		 */
		public function AOPInterceptor()
		{
		}
		
		//-------------------------------
		// Public methods
		//-------------------------------
		/**
		 * @inheritDoc
		 */
		public function intercept(invocation:IMethodInvocation):void
		{
			var context:IInterceptContext;
			invocation.proceed = false;
			switch(invocation.kind){
				case InvocationKind.CONSTRUCTOR:
					break;
				case InvocationKind.METHOD:
					//this.work(invocation);
					context = this.work(invocation, "methods");
					//invocation.returnValue = (context != null ) ? context.lastResult;
					break;
				case InvocationKind.GETTER:
					context = this.work(invocation, "gets");
					break;
				case InvocationKind.SETTER:
					context = this.work(invocation, "sets");
					break;
			}
			if ( context != null ) 
			{
				invocation.returnValue = context.lastResult;
			}
			else if ( invocation.targetMethod != null && invocation.targetInstance != null )
			{
				invocation.returnValue = invocation.targetMethod.apply(invocation.targetInstance, invocation.arguments);
			}
		}
		
		//-------------------------------
		// Protected methods
		//-------------------------------
		protected function work(invocation:IMethodInvocation, kind:String):IInterceptContext
		{
			//Get the name class of the object intercepted
			var s:String = getQualifiedClassName(invocation.targetInstance);
			if ( s != "" )
			{
				var index:int = s.indexOf(":");
				s = s.substring(0,index) + "." + s.substring(index+2);
			}
			var context:IInterceptContext = null
			//If exist in the aspect weaver
			if ( data.hasOwnProperty(s) )
			{
				var obj:Object = data[s];
				if ( obj != null && obj.hasOwnProperty(kind) && obj[kind] != null )
				{
					var dic:Dictionary = obj[kind];
					if ( dic.hasOwnProperty(invocation.targetMember.localName) && dic[invocation.targetMember.localName] != null)
					{
						obj = dic[invocation.targetMember.localName];
						context = new InterceptContext(
							invocation.arguments,
							invocation.returnValue,
							invocation.targetInstance,
							invocation.kind.name,
							invocation.targetMethod,
							invocation.targetMember.localName
						);
						var i:int;
						var vec:Array;
						if ( obj.hasOwnProperty("before") && obj["before"] != null ) 
						{
							vec = obj["before"];
							for ( i = 0; i < vec.length; i++ )
							{
								context.lastResult = vec[i](context);
								if ( context.procced == false ) break;
							}
						}
						if ( context.procced )
						{
							if ( !context.functionExecuted )
								context.lastResult = invocation.targetMethod.apply(invocation.targetInstance, invocation.arguments);
							if ( obj.hasOwnProperty("after") && obj["after"] != null )
							{
								vec = obj["after"];
								for ( i = 0; i < vec.length; i++ )
								{
									context.lastResult = vec[i](context);
									if ( context.procced == false ) break;
								}
							}
							if ( context.procced )
							{
								if ( obj.hasOwnProperty("around") && obj["around"] != null )
								{
									vec = obj["around"];
									for ( i = 0; i < vec.length; i++ )
									{
										context.lastResult = vec[i](context);
										if ( context.procced == false ) break;
									}
								}
							}
						}
					}
				}
			}
			
			return context;
		}
	}
}