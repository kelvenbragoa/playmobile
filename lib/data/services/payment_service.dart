import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:padelmobile/data/services/user_services.dart';

import '../../utils/constants/api_constants.dart';
import '../repositories/api_response.dart';
import '../repositories/myschedule.dart';
import '../repositories/payment_model.dart';


Future<ApiResponse> getAllPayments() async {

//funional
  ApiResponse apiResponse = ApiResponse();
  var data;
  List<MyScheduleModel> paymentList =[];


  try{
    

    final response = await http.get(
      Uri.parse('${APIConstants.mySchedulesURL}/${UserService.userProfile.id}'),
      headers: {'Accept':'application/json',
     }
    );

    var values = jsonDecode(response.body)['players'];

    

    
  print(response.body);
     
    


    if(values.length>0){
     
        for(int i=0;i<values.length;i++){
           
          if(values[i]!=null){
            print(values[i]);
            Map<String,dynamic> map=values[i];
            paymentList.add(MyScheduleModel.fromJson(map));
          }}
    }
    

       
 
     

    switch (response.statusCode) {
      case 200:
      // apiResponse.data = Category.fromJson(jsonDecode(response.body));
        // apiResponse.data = jsonDecode(response.body)['categories'].map((p) => Category.fromJson(p)).toList();
        // we get list of posts, so we need to map each item to post model
       
        apiResponse.data = paymentList;
       
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


Future<ApiResponse> getPayment(id) async {

//funional
  ApiResponse apiResponse = ApiResponse();
  var data;
  List<PaymentModel> paymentList =[];



  try{
    
    
  
    final response = await http.get(
      Uri.parse('${APIConstants.paymentURL}/$id'),
      headers: {'Accept':'application/json',
     }
    );

    var values = jsonDecode(response.body)['payment'];


     
    


    if(values.length>0){

      
        for(int i=0;i<values.length;i++){
          
          if(values[i]!=null){
           
            Map<String,dynamic> map=values[i];
            
            paymentList.add(PaymentModel.fromJson(map));

           
          }}
    }
    

       
 
     

    switch (response.statusCode) {
      case 200:
      // apiResponse.data = Category.fromJson(jsonDecode(response.body));
        // apiResponse.data = jsonDecode(response.body)['categories'].map((p) => Category.fromJson(p)).toList();
        // we get list of posts, so we need to map each item to post model
        apiResponse.data = paymentList;
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





Future<ApiResponse> createPayment(int userid, int schedule_id, String title, String obs) async {
  

  

ApiResponse apiResponse = ApiResponse();
  try {
    
    final response = await http.post(
      Uri.parse(APIConstants.playerCreateURL),
      headers: {
      'Accept': 'application/json',
      
    }, body: {
      'user_id': '$userid',
      'schedule_id': '$schedule_id',
      'obs': obs,
    } );



  print(response.body);
    

    
    

    switch(response.statusCode){
      case 200:
        apiResponse.data = jsonDecode(response.body)['message'];
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        // apiResponse.error = errors[errors.keys.elementAt(0)][0];
        apiResponse.error = errors.toString();
        break;
      case 400:
        apiResponse.data = jsonDecode(response.body)['message'];
        apiResponse.error = APIConstants.serverError;
        break;
      case 401:
        apiResponse.error = APIConstants.serverError;
        break;
      default:
        apiResponse.error = APIConstants.serverError;
        break;
    }
  }
  catch (e){
    apiResponse.error = APIConstants.serverError;
  }
  return apiResponse;
}



