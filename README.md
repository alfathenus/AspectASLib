AspectAS Library
================

Overview
--------

AspectAS is a library that implements Aspect oriented programation (AOP) [wiki](http://en.wikipedia.org/wiki/Aspect-oriented_programming) concepts over Actionscript language for Flash and Flex.


Motivations
-----------
This project was born as personal learning about AOP and [IOC] (http://en.wikipedia.org/wiki/Inversion_of_control). Its focused on how we can use and implement (coding) an AOP solution.


Library status
--------------
At this moment, the library is in Alpha release but it's totally functional for educational use only. On the next versions we'll add more features to will be more attractive for profesional projects.


Preliminary concepts
----------------------
The AOP implementation is based on [bytecode](http://www.as3commons.org/as3-commons-bytecode/index.html) library of [AS3Commons](http://www.as3commons.org/). This library use Interceptors to catch the joint poit to inject the advices. This injection occurs on ejecution/run time. Is the same methodology used for [AOP] framework in Spring.

The Aspect contruction is based on [AspectJ] (http://www.eclipse.org/aspectj/) and AS3 Metadata. This is an example:

	[Aspect]
	public class MyAspect 
	{
		[Before("execution(com.app.clazz.method())")]
		public funciton myAdvice(context:IInterceptContext):*
		{
		}
	}

Only full paths are allowed to use, the "*" and other wilclards for joinpoints are in development.


Wiki
----
The wiki has more information about the library [wiki]


TODO's
-------
* Modular applications
* RSL (modules and libs)
* Test, test, unit test, integration tests, tests and mor tests
* more jointpoint
* Constructor/exeptions/events interceptors

## License
[MIT License] (http://opensource.org/licenses/MIT)