
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
