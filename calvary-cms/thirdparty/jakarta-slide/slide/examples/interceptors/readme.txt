This example provides a simple implementation of the 
ContentInterceptor interface, which simply logs all calls to the 
defined hook methods.

To use this class, compile it using 
  $ ant examples
from the home directory of the Slide source distribution.

You'll then find the class in 
build/examples/org/apache/slide/examples/SimpleContentInterceptor.class

copy the entire org directory into the WEB-INF/classes path of the Slide 
web application, and edit Domain.xml to include this fragment:

  <content-interceptor 
   class="org.apache.slide.examples.SimpleContentInterceptor">
    <parameter name="exampleParamName">exampleParamValue</parameter>
  </content-interceptor>

... just before the end of the <configuration> section.

If everything goes well, log messages from the interceptor should start 
appearing in the namespace log (which defaults to system console output).

Good luck!
