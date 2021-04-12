/// 单例
class UserManager {
  static UserManager _instance;

  String token; // 登录token

  UserManager._() {}

  static UserManager getInstanse() {
    if (null == _instance) {
      _instance = UserManager._();
    }

    return _instance;
  }

  bool isSignin() {
    if (null != token && token.isNotEmpty) {
      return true;
    }

    return false;
  }
}
