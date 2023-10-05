import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class LoginRegisterServices {
  Uri registerUrl = Uri.parse("https://reqres.in/api/register");
  Future<Response> register(String email, String password) async {
    return await http.post(registerUrl, body: {"email": email, "password": password});
  }
}
