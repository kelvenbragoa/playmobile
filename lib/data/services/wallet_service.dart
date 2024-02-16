import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:padelmobile/data/services/user_services.dart';
import '../../utils/constants/api_constants.dart';
import '../repositories/api_response.dart';
import '../repositories/transactionModel.dart';
import '../repositories/walletModel.dart';

Future<ApiResponse> getWalletInfo() async {
  ApiResponse apiResponse = ApiResponse(); 
  WalletModel walletModel ;

  try{
  final response = await http.get(
        Uri.parse('${APIConstants.walletURL}/${UserService.userProfile.id}'),
        headers: {'Accept':'application/json',
      }
      );

      var values = jsonDecode(response.body)['wallet'];

      Map<String,dynamic> map=values;
      walletModel = WalletModel.fromJson(map);

      

      switch (response.statusCode) {
      case 200:
      // apiResponse.data = Category.fromJson(jsonDecode(response.body));
        // apiResponse.data = jsonDecode(response.body)['categories'].map((p) => Category.fromJson(p)).toList();
        // we get list of posts, so we need to map each item to post model
        apiResponse.data = walletModel;
        // apiResponse.data as List<dynamic>;
        
       

        //funcional
         //data = jsonDecode(response.body)['categories'];
         //funcional

      
        
       
        break;
      
      case 401:
       
       apiResponse.error = APIConstants.serverError;
       break;


      default:
      apiResponse.error = APIConstants.serverError;
    }


  }catch(e){
    apiResponse.error = APIConstants.serverError;
  }
  return apiResponse;
}

  Future<ApiResponse> topUpMpesa(
      String mobile,
      String amount,
      ) async {


    ApiResponse apiResponse = ApiResponse();
    TransactionModel transactionModel ;

    try {
      final response =
          await http.post(Uri.parse(APIConstants.mpesaURL), headers: {
        'Accept': 'application/json'
      }, body: {
        'mobile': '$mobile',
        'amount': '$amount',
        'user_id': '${UserService.userProfile.id}',
      });

      
      

      switch (response.statusCode) {
        case 200:
          var values = jsonDecode(response.body)['transaction'];
          Map<String,dynamic> map=values;
          transactionModel = TransactionModel.fromJson(map);
          apiResponse.data = transactionModel;
          apiResponse.message = jsonDecode(response.body)['message'];


          break;

        case 422:
          final errors = jsonDecode(response.body)['errors'];

          apiResponse.error = errors.toString();

          break;

        case 403:
          apiResponse.error = jsonDecode(response.body)['message'];

          break;

        case 401:
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


Future<ApiResponse> topUpEmola() async {
  ApiResponse apiResponse = ApiResponse(); 
  WalletModel walletModel ;

  try{
  final response = await http.get(
        Uri.parse('${APIConstants.walletURL}/${UserService.userProfile.id}'),
        headers: {'Accept':'application/json',
      }
      );

      var values = jsonDecode(response.body)['wallet'];

      Map<String,dynamic> map=values;
      walletModel = WalletModel.fromJson(map);

      

      switch (response.statusCode) {
      case 200:
      // apiResponse.data = Category.fromJson(jsonDecode(response.body));
        // apiResponse.data = jsonDecode(response.body)['categories'].map((p) => Category.fromJson(p)).toList();
        // we get list of posts, so we need to map each item to post model
        apiResponse.data = walletModel;
        // apiResponse.data as List<dynamic>;
        
       

        //funcional
         //data = jsonDecode(response.body)['categories'];
         //funcional

      
        
       
        break;
      
      case 401:
       
       apiResponse.error = APIConstants.serverError;
       break;


      default:
      apiResponse.error = APIConstants.serverError;
    }


  }catch(e){
    apiResponse.error = APIConstants.serverError;
  }
  return apiResponse;
}

Future<ApiResponse> topUpVisa() async {
  ApiResponse apiResponse = ApiResponse(); 
  WalletModel walletModel ;

  try{
  final response = await http.get(
        Uri.parse('${APIConstants.walletURL}/${UserService.userProfile.id}'),
        headers: {'Accept':'application/json',
      }
      );

      var values = jsonDecode(response.body)['wallet'];

      Map<String,dynamic> map=values;
      walletModel = WalletModel.fromJson(map);

      

      switch (response.statusCode) {
      case 200:
      // apiResponse.data = Category.fromJson(jsonDecode(response.body));
        // apiResponse.data = jsonDecode(response.body)['categories'].map((p) => Category.fromJson(p)).toList();
        // we get list of posts, so we need to map each item to post model
        apiResponse.data = walletModel;
        // apiResponse.data as List<dynamic>;
        
       

        //funcional
         //data = jsonDecode(response.body)['categories'];
         //funcional

      
        
       
        break;
      
      case 401:
       
       apiResponse.error = APIConstants.serverError;
       break;


      default:
      apiResponse.error = APIConstants.serverError;
    }


  }catch(e){
    apiResponse.error = APIConstants.serverError;
  }
  return apiResponse;
}

Future<ApiResponse> getAllTransactions() async {

//funional
  ApiResponse apiResponse = ApiResponse();
  var data;
  List<TransactionModel> transactionList =[];


  try{
    

    final response = await http.get(
      Uri.parse('${APIConstants.transactionURL}/${UserService.userProfile.id}'),
      headers: {'Accept':'application/json',
     }
    );

    var values = jsonDecode(response.body)['transactions'];

   

    

 
     
    


    if(values.length>0){
     
        for(int i=0;i<values.length;i++){
           
          if(values[i]!=null){
       
            Map<String,dynamic> map=values[i];
            transactionList.add(TransactionModel.fromJson(map));
          }}
    }
    

       
 
     

    switch (response.statusCode) {
      case 200:
      // apiResponse.data = Category.fromJson(jsonDecode(response.body));
        // apiResponse.data = jsonDecode(response.body)['categories'].map((p) => Category.fromJson(p)).toList();
        // we get list of posts, so we need to map each item to post model
       
        apiResponse.data = transactionList;
       
        apiResponse.data as List<dynamic>;
       
        
       

        //funcional
         //data = jsonDecode(response.body)['categories'];
         //funcional

      
        
       
        break;
      
      case 401:
       
       apiResponse.error = APIConstants.serverError;
       break;


      default:
      apiResponse.error = APIConstants.serverError;
    }
  }catch (e){
    

    apiResponse.error = APIConstants.serverError;
  }
//funcional
  //return data;\

  return apiResponse;
}