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
	import flash.display.LoaderInfo;
	import flash.system.ApplicationDomain;

	/**
	 * This object contain the information of loaderInfo and ApplicationDomain for a group of
	 * classes.
	 */
	public class AppDomainContext
	{
		//-------------------------------
		// Variables
		//-------------------------------
		private var _loaderInfo:LoaderInfo;
		private var _appDomain:ApplicationDomain;
		private var _name:String;
		
		//-------------------------------
		// Constructor
		//-------------------------------
		/**
		 * Constructor
		 * 
		 * @param laoderInfo	Is the LoaderInfo for the context
		 * @param appDomain		Is the ApplicationDomain where all the class in this context exist
		 */
		public function AppDomainContext(name:String, loaderInfo:LoaderInfo = null, appDomain:ApplicationDomain = null)
		{
			this.name = name;
			if ( loaderInfo != null ) 
			{
				this.loaderInfo = loaderInfo;
			}
			if ( appDomain != null ) 
			{
				this.appDomain = appDomain;
			}
		}
		
		//-------------------------------
		// Getters and Setters
		//-------------------------------
		/**
		 * TODO: Do documentation
		 */
		public function get name():String
		{
			return this._name;
		}
		public function set name(value:String):void
		{
			this._name = value;
		}
		
		/**
		 * TODO: Do documentation
		 */
		public function get loaderInfo():LoaderInfo
		{
			return this._loaderInfo;
		}
		public function set loaderInfo(value:LoaderInfo):void
		{
			this._loaderInfo = value;
		}
		
		/**
		 * TODO: Do documentation
		 */
		public function get appDomain():ApplicationDomain
		{
			return this._appDomain;
		}
		public function set appDomain(value:ApplicationDomain):void
		{
			this._appDomain = value;
		}
	}
}