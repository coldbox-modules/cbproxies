/**
 * My BDD Test
 */
component extends="testbox.system.BaseSpec" {

	/*********************************** LIFE CYCLE Methods ***********************************/

	/**
	 * executes before all suites+specs in the run() method
	 */
	function beforeAll(){
	}

	/**
	 * executes after all suites+specs in the run() method
	 */
	function afterAll(){
	}

	/*********************************** BDD SUITES ***********************************/

	function run( testResults, testBox ){
		// all your suites go here.
		describe( "cbproxies creation", function(){
			it( "can create a BiConsumer", function(){
				var results = false;
				var proxy   = new cbproxies.models.BiConsumer( function( a, b ){
					results = true;
				} );
				var jProxy = createDynamicProxy( proxy, [ "java.util.function.BiConsumer" ] );
				jProxy.accept( 1, 2 );
				expect( results ).toBeTrue();
			} );

			it( "can create a BiFunction", function(){
				var results = false;
				var proxy   = new cbproxies.models.BiFunction( function( a, b ){
					results = true;
				} );
				var jProxy = createDynamicProxy( proxy, [ "java.util.function.BiFunction" ] );
				jProxy.apply( 1, 2 );
				expect( results ).toBeTrue();
			} );

			it( "can create a BinaryOperator", function(){
				var results = false;
				var proxy   = new cbproxies.models.BinaryOperator( function( a, b ){
					results = true;
				} );
				var jProxy = createDynamicProxy( proxy, [ "java.util.function.BinaryOperator" ] );
				jProxy.apply( 1, 2 );
				expect( results ).toBeTrue();
			} );

			it( "can create a ToLongFunction", function(){
				var results = false;
				var proxy   = new cbproxies.models.ToLongFunction( function( a ){
					results = true;
					return a;
				} );
				var jProxy = createDynamicProxy( proxy, [ "java.util.function.ToLongFunction" ] );
				jProxy.applyAsLong( javacast( "long", 1 ) );
				expect( results ).toBeTrue();
			} );

			it( "can create a ToIntFunction", function(){
				var results = false;
				var proxy   = new cbproxies.models.ToIntFunction( function( a ){
					results = true;
					return a;
				} );
				var jProxy = createDynamicProxy( proxy, [ "java.util.function.ToIntFunction" ] );
				jProxy.applyAsInt( javacast( "int", 1 ) );
				expect( results ).toBeTrue();
			} );

			it( "can create a ToDoubleFunction", function(){
				var results = false;
				var proxy   = new cbproxies.models.ToDoubleFunction( function( a ){
					results = true;
					return a;
				} );
				var jProxy = createDynamicProxy( proxy, [ "java.util.function.ToDoubleFunction" ] );
				jProxy.applyAsDouble( javacast( "double", 1.11 ) );
				expect( results ).toBeTrue();
			} );

			it( "can create a Supplier", function(){
				var proxy = new cbproxies.models.Supplier( function(){
					return true;
				} );
				var jProxy  = createDynamicProxy( proxy, [ "java.util.function.Supplier" ] );
				var results = jProxy.get();
				expect( results ).toBeTrue();
			} );

			it( "can create a Runnable", function(){
				var results = false;
				var proxy   = new cbproxies.models.Runnable( function(){
					results = true;
				} );
				var jProxy = createDynamicProxy( proxy, [ "java.lang.Runnable" ] );
				jProxy.run();
				expect( results ).toBeTrue();
			} );

			it( "can create a Predicate", function(){
				var results = false;
				var proxy   = new cbproxies.models.Predicate( function(){
					results = true;
					return true;
				} );
				var jProxy = createDynamicProxy( proxy, [ "java.util.function.Predicate" ] );
				jProxy.test( "hello" );
				expect( results ).toBeTrue();
			} );

			it( "can create a FutureFunction", function(){
				var results = false;
				var proxy   = new cbproxies.models.FutureFunction( function(){
					return {};
				} );
				var jProxy = createDynamicProxy( proxy, [ "java.util.function.Function" ] );

				expect( function(){
					jProxy.apply( "test" );
				} ).toThrow();

				var proxy = new cbproxies.models.FutureFunction( function(){
					return {
						getNative : function(){
							return true;
						}
					};
				} );
				var jProxy = createDynamicProxy( proxy, [ "java.util.function.Function" ] );
				expect( jProxy.apply( "test" ) ).toBeTrue();
			} );

			it( "can create a Function", function(){
				var results = false;
				var proxy   = new cbproxies.models.Function( function(){
					results = true;
					return true;
				} );
				var jProxy = createDynamicProxy( proxy, [ "java.util.function.Function" ] );
				expect( jProxy.apply( "hello" ) ).toBeTrue();
			} );

			it( "can create a Consumer", function(){
				var results = false;
				var proxy   = new cbproxies.models.Consumer( function(){
					results = true;
					return true;
				} );
				var jProxy = createDynamicProxy( proxy, [ "java.util.function.Consumer" ] );
				jProxy.accept( "hello" );
				expect( results ).toBeTrue();
			} );

			it( "can create a Comparator", function(){
				var proxy = new cbproxies.models.Comparator( function( a, b ){
					return a < b ? -1 : a == b ? 0 : 1;
				} );
				var jProxy  = createDynamicProxy( proxy, [ "java.util.Comparator" ] );
				var results = jProxy.compare( 1, 2 );
				expect( results ).toBe( -1 );

				var results = jProxy.compare( 2, 2 );
				expect( results ).toBe( 0 );

				var results = jProxy.compare( 2, 1 );
				expect( results ).toBe( 1 );
			} );

			it( "can create a Callable", function(){
				var results = false;
				var proxy   = new cbproxies.models.Callable( function(){
					return true;
				} );
				var jProxy = createDynamicProxy( proxy, [ "java.util.concurrent.Callable" ] );
				expect( jProxy.call() ).toBeTrue();
			} );
		} );

		describe( "cbproxies threaded execution", function(){
			it( "can create a Runnable in another thread", function(){
				application.results = false;

				var proxy = new cbproxies.models.Runnable( function(){
					createObject( "java", "java.lang.System" ).out.println( "Runnable running from thread #createObject( "java", "java.lang.Thread" ).currentThread().getName()#" )
					application.results = true;
				} );
				var jProxy  = createDynamicProxy( proxy, [ "java.lang.Runnable" ] );
				var jThread = createObject( "java", "java.lang.Thread" ).init( jProxy );
				jthread.start();
				jThread.join();
				expect( application.results ).toBe( true );
			} );


			it( "can create a Runnable in another thread concurrently", function(){
				request.brad    = 4;
				request.count   = 0;
				variables.stuff = 0;
				// createObject( "java", "java.lang.System" ).out.println( "processed " & request.count );
				var proxy       = new cbproxies.models.Consumer( function( i ){
					// createObject( "java", "java.lang.System" ).out.println( "Consuming [#i#] running from thread #createObject( "java", "java.lang.Thread" ).currentThread().getName()#" )
					i + request.brad;
					variables.stuff += i;
					request.brad = request.brad + 1;
					var copy     = variables.stuff - 1;
					isDefined( "url.foo" )
					var test  = url.method ?: "n/a";
					url.hey   = "ho" & createUUID();
					var tests = cgi.script_name;
					request.count++;
					var jon = "clausen";
					trim( jon );
					uCase( jon );
					reverse( jon );
				} );
				var jConsumer = createDynamicProxy( proxy, [ "java.util.function.Consumer" ] );

				var arr = [];
				for ( var i = 1; i <= 10000; i++ ) {
					arrayAppend( arr, i );
				}
				arr.stream()
					.parallel()
					.forEach( jConsumer );

				// createObject( "java", "java.lang.System" ).out.println( "processed " & request.count );
			} );
		} );
	}

}
