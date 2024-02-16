// register
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../utils/constants/api_constants.dart';
import '../repositories/api_response.dart';
import '../repositories/user.dart';

class UserService {
  static UserData userProfile = UserData(
      id: 0, firstName: '', lastName: '', mobile: '', email: '', birthDate: '',balance:'');

  Future<ApiResponse> loginUser(String email, String password) async {
  

    ApiResponse apiResponse = ApiResponse();
    try {
      final response = await http.post(Uri.parse(APIConstants.loginURL),
          headers: {'Accept': 'application/json'},
          body: {'email': email, 'password': password});

  
      switch (response.statusCode) {
        case 200:
          apiResponse.data = UserData.fromJson(jsonDecode(response.body));
          break;

        case 422:
          final errors = jsonDecode(response.body)['errors'];
          //  apiResponse.error = errors[errors.keys.elementAt(0)[0]];
          apiResponse.error = errors.toString();
          break;

        case 403:
          apiResponse.error = jsonDecode(response.body)['message'];
          break;

        default:
          apiResponse.error = APIConstants.serverError;
      }
    } catch (e) {
      apiResponse.error = APIConstants.serverError;

    }

    return apiResponse;
  }

  Future<ApiResponse> registerUser(
      String firstName,
      String lastName,
      String email,
      String mobile,
      String password,
      String gender,
      String date) async {
    ApiResponse apiResponse = ApiResponse();

    try {
      final response =
          await http.post(Uri.parse(APIConstants.registerURL), headers: {
        'Accept': 'application/json'
      }, body: {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'mobile': mobile,
        'password': password,
        'password_confirmation': password,
        'gender': gender,
        'birth_date': date,
      });

    

      switch (response.statusCode) {
        case 200:
          apiResponse.data = UserData.fromJson(jsonDecode(response.body));

          break;

        case 422:
          final errors = jsonDecode(response.body)['errors'];

          apiResponse.error = errors.toString();

          break;

        case 403:
          apiResponse.error = jsonDecode(response.body)['message'];

          break;

        default:
          apiResponse.error = APIConstants.serverError;
      }
    } catch (e) {

      apiResponse.error = APIConstants.serverError;
    }

    return apiResponse;
  }
}
