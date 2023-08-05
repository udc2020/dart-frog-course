
import 'package:dart_frog/dart_frog.dart';
import '../providers/users_provider.dart';

Handler middleware(Handler handler) {
 
  return handler.use(
    usersProvider(handler),
  );
}
