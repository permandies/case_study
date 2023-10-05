import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class UserServices {
  Future<Response> getUsers(int page) async {
    Uri registerUrl = Uri.parse("https://reqres.in/api/users?page=$page");
    return await http.get(registerUrl);
  }
}
