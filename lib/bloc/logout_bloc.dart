import 'package:responsi_2_mobile_h1d023094/helpers/user_info.dart';

class LogoutBloc {
  static Future logout() async {
    await UserInfo().logout();
  }
}