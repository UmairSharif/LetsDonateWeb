import 'package:lets_donate_web/models/user.dart';
import 'package:lets_donate_web/services/firestore_service.dart';

class UserService extends DatabaseService<UserModel> {
  UserService()
      : super(
            collection: FirestoreCollection.users.name,
            fromDS: (id, data) => UserModel.fromFirestore(id, data),
            toMap: (user) => user.toMap());
}
