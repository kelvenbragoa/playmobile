import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../utils/constants/api_constants.dart';
import '../repositories/api_response.dart';
import '../repositories/dashboard.dart';
import '../repositories/licence_model.dart';







Future<List<ApiResponse>> getHomeData (int? id) async {

//funional
  ApiResponse apiResponse = ApiResponse();
  ApiResponse apiResponse1 = ApiResponse();
  var data;





  List<DashboardData> home =[];

  List<LicenceModel> licence =[];

  try{
   
    
    final response = await http.get(
      Uri.parse('${APIConstants.dashboardURL}/$id'),

     
      headers: {'Accept':'application/json'}
    );

  
    var values1 = jsonDecode(response.body)['home'];
    var values2 = jsonDecode(response.body)['licence'];


    
  
    if(values1.length>0){
    
       for(int i=0;i<values1.length;i++){

          
           if(values1[i]!=null){
             Map<String,dynamic> map = values1[i];
          
             home.add(DashboardData.fromJson(map));
           
           }}
    }

    if(values2.length>0){
    
       for(int i=0;i<values2.length;i++){

          
           if(values2[i]!=null){
             Map<String,dynamic> map = values2[i];
          
             licence.add(LicenceModel.fromJson(map));
           
           }}
    }

  

    
    
   
   
    switch (response.statusCode) {
      case 200:
        apiResponse.data = home;
        apiResponse.data as List<dynamic>;

        apiResponse1.data = licence;
        apiResponse1.data as List<dynamic>;
  
        
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

  return [apiResponse,apiResponse1];
}