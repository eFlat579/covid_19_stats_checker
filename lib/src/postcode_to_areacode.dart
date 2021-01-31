import 'dart:convert';
import 'package:http/http.dart' as http;

/*
  A class which handles the Postcode to Areacode conversion.
  Looks up the areacode using an api.
*/
class PostcodeToAreacode {
  Future<String> fetchAreacode(String postcode) async {
    var url = 'https://api.postcodes.io/postcodes/$postcode';

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);

    // If there is a good response...
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      Map<String, dynamic> results = json['result'];
      Map<String, dynamic> codes = results['codes'];

      return codes['admin_district'];
    } else {
      // Returning null triggers the invalid message animation.
      return null;
    }
  }
}
