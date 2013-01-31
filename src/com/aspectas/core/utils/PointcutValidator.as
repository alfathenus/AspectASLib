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
package com.aspectas.core.utils
{
	/**
	 * Validator of pointcuts
	 */
	public class PointcutValidator
	{
		//-------------------------------
		// Constants
		//-------------------------------
		private static const TOKEN_TYPES:String = "(" +
														PointcutTypes.CALL + "|" +
														PointcutTypes.EXECUTION + "|" + 
														PointcutTypes.INITIALIZATION + "|" + 
														PointcutTypes.GET + "|" + 
														PointcutTypes.SET + 
													")";
		private static const TOKEN_MULTI_WHITE_SPACE:String = " *";
		private static const TOKEN_IDENTIFICATOR:String = "[a-zA-Z]([a-zA-Z]|[0-9])*";
		private static const TOKEN_PACKAGE_NAME:String = TOKEN_IDENTIFICATOR
		private static const TOKEN_PACKAGE_PATH:String = "("+TOKEN_PACKAGE_NAME+"\\.)*";
		private static const TOKEN_CLASS_NAME:String = TOKEN_IDENTIFICATOR;
		private static const TOKEN_METHOD_NAME:String = TOKEN_IDENTIFICATOR+"\\(\\)";
		private static const TOKEN_POINTCUT_RELATION:String = TOKEN_IDENTIFICATOR;
		
		private static const GRAMMAR_POINTCUT_EXPRESSION:String = "^"+
																	TOKEN_TYPES +
																	TOKEN_MULTI_WHITE_SPACE +
																	"\\(" +
																		TOKEN_MULTI_WHITE_SPACE +
																		TOKEN_PACKAGE_PATH +
																		TOKEN_CLASS_NAME +
																		"\\." + 
																		TOKEN_METHOD_NAME +
																		TOKEN_MULTI_WHITE_SPACE +
																	"\\)";
		private static const GRAMMAR_POINTCUT_RELATION:String = TOKEN_POINTCUT_RELATION;
		private static const GRAMMAR_FULL_CLASS_NAME:String = TOKEN_PACKAGE_PATH + TOKEN_CLASS_NAME;
		private static const GRAMMAR_FULL_METHOD_NAME:String = TOKEN_METHOD_NAME;
		
		
		private static const RegExpExpressionValidator:RegExp = new RegExp(GRAMMAR_POINTCUT_EXPRESSION, "g");
		private static const RegExpRelationValidator:RegExp = new RegExp(GRAMMAR_POINTCUT_RELATION, "g");
		public static const RegExpFullClassName:RegExp = new RegExp(GRAMMAR_FULL_CLASS_NAME, "g");
		public static const RegExpFullMethodName:RegExp = new RegExp(GRAMMAR_FULL_METHOD_NAME, "g");
		
		//-------------------------------
		// Constructor
		//-------------------------------
		/**
		 * Constructor
		 */
		public function PointcutValidator()
		{
		}
		
		//-------------------------------
		// Public methods
		//-------------------------------
		/**
		 * TODO: Do documentation
		 */
		public static function isPointcutName(value:String):Boolean
		{
			if ( value != "" && value.search(RegExpRelationValidator) == 0 ) {
				return true;
			}
			
			return false;
		}
		
		/**
		 * TODO: Do documentation
		 */
		public static function isPointcutExpression(value:String):Boolean 
		{
			if ( value != "" && value.search(RegExpExpressionValidator) == 0 ) {
				return true;
			}
			
			return false;
		}
	}
}