# Dart Frog Course 🐸

- That is The Summary of Full Course .
- You Can see **The Course [Here](https://youtu.be/bN5XsAPr-oc)**



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

## Status Code

```dart
   Future<Response> onRequest(RequestContext context) async {
      final request = context.request;

      //returning all data from body
      final body = await request.body();

      //Status Code 
      const statusCode = HttpStatus.notFound | 404;

      return Response(body: body, statusCode: statusCode);
   }

```

## Headers

```dart
   Future<Response> onRequest(RequestContext context) async {
      final request = context.request;

      //returning all data from body
      final body = await request.body();

      //Headrs 
      const haeders ={
         'Content-Type':'application/json utf-8'
      };

      return Response(body: body,headers: haeders);
   }

```


## Form Data

### Simple Text
```dart
   Future<Response> onRequest(RequestContext context) async {
      final request = context.request;

      // get all field form
       final formData = await request.formData();


         return Response.json(body: formData.fields );
   }

```

### Simple Text
```dart
   Future<Response> onRequest(RequestContext context) async {
      final request = context.request;
      //retrive img
      final img = formData.files['img'];

      if (img == null) {
         return Response(statusCode: HttpStatus.badRequest);
      }

      return Response.json(body: formData);
   }

```


## Work With Models

1. Create Model in dirctory ``lib/models/user.dart``
2. in user Create Class **``User``** 

### In User Model

```dart
   // ignore_for_file: public_member_api_docs

   import 'package:json_annotation/json_annotation.dart';

   part 'user.g.dart';

   @JsonSerializable()
   class User {
   User({
      required this.id,
      required this.username,
      required this.password,
   });

   final int id;
   final String username;
   final int password;

   Map<String, dynamic> toJson() => _$UserToJson(this);
   }

```

4. dont forget to use ``build_runner`` & ``json_serializable`` in dev dependencies
5. Now generate user model ``dart pub run build_runner``
6. so we get new generated file user.g.dart

### In Router

```dart

   import 'package:dart_frog/dart_frog.dart';
   import 'package:dart_frog_course/models/user.dart';

   // Route @GET "/"
   Future<Response> onRequest(RequestContext context) async {
      final users = <User>[
         User(id: 12, username: 'samir', password: 2156416),
         User(id: 120, username: 'sami', password: 9898416),
      ];
      return Response.json(body: users);
   }

```
## Middleware

### in middelware
1. create new middleware ``dart_frog new middleware "/"``
2. you can handel before & after request 

```dart
import 'package:dart_frog/dart_frog.dart';

Handler middleware(Handler handler) {
  return (context) async {
    print("before request");
    final response = await handler(context);
    Future.delayed(const Duration(seconds: 10),()=>print("after request"));
    
    return response;
  };
}

```


## Middleware (Depndency Injection) 

```dart
import 'package:dart_frog/dart_frog.dart';

Handler middleware(Handler handler) {
  return (context) async {
    print("before request");
    final response = await handler(context);
    Future.delayed(const Duration(seconds: 10),()=>print("after request"));
    
    return response;
  };
}

```

```dart
Future<Response> onRequest(RequestContext context) async {
  // call the provider from middleware
  final users = context.read<List<User>>();
  return Response.json(body: users);
}


```

### Extract Provider 

1. create folder providers
2. create file users_provider.dart 
3. in this provider file we well 

```dart
import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_course/models/user.dart';

Middleware usersProvider(Handler handler) {
  return provider<List<User>>((handler) {
    return <User>[
      User(id: 12, username: 'samir', password: 2156416),
      User(id: 120, username: 'sami', password: 9898416),
    ];
  });
}


```
4. in middleware file 

```dart
import 'package:dart_frog/dart_frog.dart';
import '../providers/users_provider.dart';

Handler middleware(Handler handler) {
  return handler.use(
   usersProvider(handler),
  );
}



```

## Serving Static Files

1. create public folder in root dirctory
2. put assets in this folder 
3. in the final we can get path ``"/<file>"`` 


