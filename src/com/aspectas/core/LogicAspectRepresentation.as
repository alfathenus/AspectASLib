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
	import com.aspectas.core.utils.AdviceTypes;
	import com.aspectas.core.utils.PointcutTypes;
	
	import flash.display.LoaderInfo;
	import flash.system.ApplicationDomain;
	import flash.utils.Dictionary;
	
	import org.as3commons.bytecode.reflect.ByteCodeType;
	import org.as3commons.reflect.Method;
	import org.as3commons.reflect.Type;
	
	/**
	 * This layer has the responsability to crate a common representation from
	 * any AOP configuration imput (like, ByteArray, XML, etc).
	 * The final representation is this:
	 * <pre>
	 * #Dictionary [
	 * 	"aspectName":#Aspect {
	 * 		_pointCuts:Dictionary(#String) of Pointcuts strings
	 * 		_advices: list (#Advice) of advices with its pointcut
	 * 	}
	 * ]
	 * </pre>
	 * 
	 */
	public class LogicAspectRepresentation
	{
		//-------------------------------
		// Variables
		//-------------------------------
		private var _aspectsLogicRepDic:Dictionary;
		
		//-------------------------------
		// Constructor
		//-------------------------------
		/**
		 * Constructor
		 */
		public function LogicAspectRepresentation()
		{
			this._aspectsLogicRepDic = new Dictionary();
		}
		
		//-------------------------------
		// Getters and Setters
		//-------------------------------
		/**
		 * TODO: Do documentation
		 */
		public function get aspectsLogicRepDic():Dictionary
		{
			return _aspectsLogicRepDic;
		}
		
		//-------------------------------
		// Public methods
		//-------------------------------
		/**
		 * TODO: Do documentation
		 */
		public function build(context:AppDomainContext):void//loaderInfo:LoaderInfo, appDomain:ApplicationDomain):void 
		{
			if ( context == null ) 
			{
				return;
			}
			var loaderInfo:LoaderInfo = context.loaderInfo;
			var appDomain:ApplicationDomain = context.appDomain;
			
			if ( loaderInfo == null || appDomain == null )
			{
				return;
			}
			
			//get all information about LoaderInfo
			ByteCodeType.fromLoader(loaderInfo);
			
			//get all classes with "aspect" metadata
			var arr:Array = ByteCodeType.getClassesWithMetadata("aspect");
			
			if ( arr != null && arr.length > 0 ) 
			{
				var type:Type;
				var arr2:Array;
				var aspect:Aspect;
				var adviceNameList:Vector.<String> = AdviceTypes.ADVICE_TYPES_LIST;
				var clazz:Class;
				var j:int;
				var k:int;
				
				//for each class get all methods with any type of advice metadata 
				//save a logical repesentation of Aspect with its advices
				for ( var i:int = 0; i < arr.length; i++ ) {
					//create a logical aspect
					aspect = new Aspect();
					this._aspectsLogicRepDic[arr[i]] = aspect;
					
					type = Type.forName(arr[i]);
					aspect.className = arr[i];
					aspect.name = type.fullName;
					clazz = type.clazz as Class;
					aspect.object = new clazz(); //the implementation of aspect (user class)
					
					//save all pointcuts functions
					arr2 = type.getMetadataContainers(PointcutTypes.POINTCUT_NAME);
					if ( arr2 != null ) 
					{
						for ( j = 0; j < arr2.length; j++ ) 
						{
							aspect.addPointCut(
								arr2[j].metadata[0].arguments[0].value, 
								aspect.object[arr2[j].name]() as String
							);
						}
					}
					
					//for each type of advice, I save the advice function with its pointcut in the aspect
					for ( j = 0; j < adviceNameList.length; j++ ) 
					{
						arr2 = type.getMetadataContainers(adviceNameList[j]);
						if ( arr2 != null ) {
							for ( k = 0; k < arr2.length; k++ ) 
							{
								if ( arr2[k] != null && arr2[k] is Method ) 
								{
									aspect.addAdvice(Advice.createFromReflectMethod(arr2[k], aspect));
								}
							}
						}
					}
				}
			}
		}
	}
}