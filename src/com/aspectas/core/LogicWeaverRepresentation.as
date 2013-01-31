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
	import com.aspectas.core.elements.Aspect;
	import com.aspectas.core.interfaces.IAdvice;
	import com.aspectas.core.interfaces.IAspect;
	import com.aspectas.core.utils.PointcutTypes;
	
	import flash.display.LoaderInfo;
	import flash.system.ApplicationDomain;
	import flash.utils.Dictionary;

	/**
	 * It is the logic weaver reperesenation.
	 * Once you have a common Aspect specification from all the sources, this class generate
	 * a weaver configuration for AOP core. In other words, this class joins Aspect/Advice with the 
	 * objet/class/method that advices.
	 * 
	 * It has a dictionary with:
	 * #DicOf[
	 * 	"className":#DicOf [
	 * 		"classRef":#Class,
	 * 		"methods"#dicOf[
	 * 			"methodName":#Object{
	 * 				"after":[adviceFuntion]
	 * 				"before":[adviceFuntion]
	 * 				"around":[adviceFuntion]
	 * 				}
	 * 			]
	 * 		"gets":#DicOf[
	 * 			"getName":#Object{
	 * 				"after":[adviceFuntion]
	 * 				"before":[adviceFuntion]
	 * 				"around":[adviceFuntion]
	 * 				}
	 * 			]
	 * 		"sets":#DicOf[
	 * 			"setName":#Object{
	 * 				"after":[adviceFuntion]
	 * 				"before":[adviceFuntion]
	 * 				"around":[adviceFuntion]
	 * 				}
	 * 			]
	 * 		]
	 * ]
	 * 
	 * This specification tells you that de class "className" need to run advices in the methods, gets and sets
	 */
	public class LogicWeaverRepresentation
	{
		//-------------------------------
		// Variables
		//-------------------------------
		private var _weaverLogicRepDic:Dictionary;
		
		//-------------------------------
		// Constructor
		//-------------------------------
		/**
		 * Constructor
		 */
		public function LogicWeaverRepresentation()
		{
			this._weaverLogicRepDic = new Dictionary();
		}
		
		//-------------------------------
		// Getters and Setters
		//-------------------------------
		/**
		 * TODO: Do documentation
		 */
		public function get weaverLogicRepDic():Dictionary
		{
			return _weaverLogicRepDic;
		}
		
		//-------------------------------
		// Public methods
		//-------------------------------
		/**
			 * TODO: Do documentation
			 */
		public function build(context:AppDomainContext, _aspectsLogicRepDic:Dictionary):void//loaderInfo:LoaderInfo, appDomain:ApplicationDomain, _aspectsLogicRepDic:Dictionary):void
		{
			if( context == null )
			{
				return;
			}
			var loaderInfo:LoaderInfo = context.loaderInfo;
			var appDomain:ApplicationDomain = context.appDomain;
			
			if ( loaderInfo == null || appDomain == null )
			{
				return;
			}
			
			var aspect:IAspect;
			var vector:Vector.<IAdvice>;
			var i:int;
			
			//This for makes the logical weaver
			for each ( aspect in _aspectsLogicRepDic )
			{
				if ( aspect != null )
				{
					vector = aspect.advices;
					if ( vector != null && vector.length > 0 )
					{
						for ( i = 0; i < vector.length; i++ ) 
						{
							this.addAdvice(vector[i], context);
						}
					}
				}
			}
		}
		
		//-------------------------------
		// Private Methods
		//-------------------------------
		private function addAdvice(advice:IAdvice, context:AppDomainContext):void
		{
			if ( advice != null && advice.added == false ) {
				advice.added = true;
				var wildcard:String = advice.pointcut.getWildCard();
				var clazz:String = advice.pointcut.getClass();
				var element:String = advice.pointcut.getElement();
				
				
				
				if ( !this._weaverLogicRepDic.hasOwnProperty(clazz) ) 
				{
					this._weaverLogicRepDic[clazz] = {
						classRef: context.appDomain.getDefinition(clazz) as Class,
						methods: new Dictionary(),
						sets: new Dictionary(),
						gets: new Dictionary()
					}
				}
				
				switch ( wildcard ) 
				{
					case PointcutTypes.EXECUTION:
						this.addItem(this._weaverLogicRepDic[clazz]["methods"], element, advice);
						break;
					case PointcutTypes.GET:
						this.addItem(this._weaverLogicRepDic[clazz]["gets"], element, advice);
						break;
					case PointcutTypes.SET:
						this.addItem(this._weaverLogicRepDic[clazz]["sets"], element, advice);
						break;
				}
			}
		}
		
		private function addItem(dic:Dictionary, element:String, advice:IAdvice):void {
			if ( !dic.hasOwnProperty(element) ) 
			{
				dic[element] = {};
			}
			if ( !dic[element].hasOwnProperty(advice.type) ) 
			{
				dic[element][advice.type] = [];
			}
			dic[element][advice.type].push(advice.foo);
		}
	}
}