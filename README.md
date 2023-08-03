# Dart Frog Course 🐸

- That is The Summary of Full Course .
- You Can see **The Course [Here]()**



## Installation

```bash
   dart pub global activate dart_frog_cli
   dart_frog create my_project
```
    
## Run Server 

```bash
   dart_frog dev
```

## Create Routes 


### Absolute Path
- path like "/" or "/hello" or "/hello/world"
- path /hello/world  will craete folder named ``hello`` and file named ``word.dart``

```bash
   dart_frog new route <path>
```

### Dynamic Route
- dynamicPath like "posts/1" , "id/105" , "/api/blogs/ahmed/posts/30"
- dynamic path most be in "[dp]" and will create file ``[dp].dart``
 

```bash
   dart_frog new route <dynamicPath>
```


###### Example of Dynamic Path 

```bash
   dart_frog new route "/posts/[pages]" 
```

in **``[pages].dart``**

```dart

   Response onRequest(RequestContext context,String pages) {
      return Response(body: 'post number $pages');
   }
```


- and Folder Path most be  Folder: **``/posts/[pages]/user``**


- File **``[id].dart``**



```bash
   dart_frog new route "/posts/[pages]/user/[id]" 
```

- in **``[id].dart``** we can handel *pages* and *id*


```dart
   Response onRequest(RequestContext context, String pages, String id) {
      return Response(body: 'Pages : $pages id : $id');
   }
```

### Quiry Paramaters 

```dart
   // Route @GET "/"
   Response onRequest(RequestContext context) {
      final request = context.request;
      final params  = request.uri.queryParameters; 

      return Response(body: '${params["name"]} ');
   }
```


## Http Methods

### Detecting HTTP REQUSET 

```dart
   Response onRequest(RequestContext context) {
      final request = context.request;

      final method = request.method.value;

      switch (method) {
         case 'GET':
            print('GET');
            break;
         case 'POST':
            print('POST');
            break;
         case 'PUT':
            print('PUT');
            break;
         default:
         print('ANOTHER HTTP REQUEST');
      }  

   return Response(body: '$method ');
}
```

## Body


### Plain Text

```dart
   Future<Response> onRequest(RequestContext context)async {
      final request = context.request;

      //returning all data from body
      final body = await request.body();


      return Response(body: body);
}

```
### Parsed to json
```dart
   Future<Response> onRequest(RequestContext context)async {
      final request = context.request;

      final body = await request.json();


      return Response.json(body: body);
}

```