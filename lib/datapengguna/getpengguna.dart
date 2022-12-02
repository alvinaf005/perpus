import 'dart:convert';
import 'package:http/http.dart' as http;

class GetProfile {
  final String username;

  GetProfile({required this.username});

  Future getProfile() async {
    try {
      final response = await http
          .post(Uri.parse("http://10.0.2.2/bukuperpus/getpengguna.php"), body: {
        'username': username,
      });

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        print(result);
        return result;
      } else {
        return 'Server Error';
      }
    } catch (e) {
      return 'App Error';
    }
  }
}
