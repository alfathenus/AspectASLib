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
	import org.as3commons.bytecode.proxy.impl.ProxyFactory;
	import org.as3commons.bytecode.proxy.impl.ProxyInfo;

	public class AOPFactory
	{
		public var proxyFactory:ProxyFactory;
		private static var _instance:AOPFactory;
		
		public function AOPFactory()
		{
		}
		
		public function create(clazz:Class):* 
		{
			if ( clazz != null && this.proxyFactory != null ) 
			{
				var info:ProxyInfo = this.proxyFactory.getProxyInfoForClass(clazz);
				if ( info != null ) {
					return new info.proxyClass ();
				}
			}
			
			return null;
		}
		
		public static function getInstance():AOPFactory 
		{
			if ( _instance == null )
			{
				_instance = new AOPFactory();
			}
			return _instance;
		}
	}
}