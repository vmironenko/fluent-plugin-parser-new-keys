<h2>Configuration
</h2>
<pre>
<code>
&lt;match test.*&gt;
  type  parser_new_keys
  parse_field message
  prefix_new_key new_key
  number_of_keys 3
  pattern '\n(?:Caused by: )*([a-zA-Z_.]+Exception): '
  tag test.filtered
&lt;/match &gt;
</code>
</pre>
If following record is passed:
<pre>
<code>

{"message": "2015-09-30 19:10:01,126 [I/O dispatcher 6] ERROR c.p.d.c.CachingDao - bla-bla
java.util.concurrent.CompletionException:  code: 401
        at java.util.concurrent.CompletableFuture.encodeThrowable(CompletableFuture.java:292) [na:1.8.0_40]
        at java.util.concurrent.CompletableFuture.completeThrowable(CompletableFuture.java:308) [na:1.8.0_40]
Caused by: com.domain.commons.exception.ServiceException: com.domain.app.api.client.exceptions.AppApiClientException: Unexpected status code: 401
        ... 18 common frames omitted
Caused by: com.domain.app.api.client.exceptions.AppApiClientException: Unexpected status code: 401
        at com.domain.app.api.client.impl.AppApiClientImpl$14.completed(ApptApiClientImpl.java:235) [test.jar:na]
        ... 16 common frames omitted
" }
</code>
</pre>
then you got new record like below:
<pre>
<code>

{"message": "2015-09-30 19:10:01,126 [I/O dispatcher 6] ERROR c.p.d.c.CachingDao - bla-bla
java.util.concurrent.CompletionException:  code: 401
        at java.util.concurrent.CompletableFuture.encodeThrowable(CompletableFuture.java:292) [na:1.8.0_40]
        at java.util.concurrent.CompletableFuture.completeThrowable(CompletableFuture.java:308) [na:1.8.0_40]
Caused by: com.domain.commons.exception.ServiceException: com.domain.app.api.client.exceptions.AppApiClientException: Unexpected status code: 401
        ... 18 common frames omitted
Caused by: com.domain.app.api.client.exceptions.AppApiClientException: Unexpected status code: 401
        at com.domain.app.api.client.impl.AppApiClientImpl$14.completed(ApptApiClientImpl.java:235) [test.jar:na]
        ... 16 common frames omitted
" ,
"new_key_1": "java.util.concurrent.CompletionException",
"new_key_2": "com.domain.commons.exception.ServiceException",
"new_key_3": "com.domain.app.api.client.exceptions.AppApiClientException"
}
</code>
</pre>
<h2>Copyright</h2>

Author	Valery Mironenko 
