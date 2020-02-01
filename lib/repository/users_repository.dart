import 'package:evalio_app/dao/user-dao.dart';
import 'package:evalio_app/models/user_model.dart';

class UserRepository {
  final _userDao = UserDao();

  // ユーザープロフィール
  updateUser(String userId, String introducation, String interest) {
    Map<String, String> profile = {
      UserModelField.selfIntroducation: introducation,
      UserModelField.interest: interest
    };
    _userDao.updateProfile(userId, profile);
  }
}