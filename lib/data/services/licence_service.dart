import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../utils/constants/api_constants.dart';
import '../repositories/api_response.dart';
import '../repositories/licence_model.dart';


Future<ApiResponse> getAllLicences() async {

//funional
  ApiResponse apiResponse = ApiResponse();
  var data;
  List<LicenceModel> licenceList =[];


  try{
    
    
    final response = await http.get(
      Uri.parse(APIConstants.licenceURL),
      headers: {'Accept':'application/json',
     }
    );

    var values = jsonDecode(response.body)['licences'];


   
     
    


    if(values.length>0){
        for(int i=0;i<values.length;i++){
          if(values[i]!=null){
            Map<String,dynamic> map=values[i];
            licenceList.add(LicenceModel.fromJson(map));
          }}
    }
    

       
 
     

    switch (response.statusCode) {
      case 200:
      // apiResponse.data = Category.fromJson(jsonDecode(response.body));
        // apiResponse.data = jsonDecode(response.body)['categories'].map((p) => Category.fromJson(p)).toList();
        // we get list of posts, so we need to map each item to post model
        apiResponse.data = licenceList;
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


Future<ApiResponse> getLicence(id) async {

//funional
  ApiResponse apiResponse = ApiResponse();
  var data;
  List<LicenceModel> licenceList =[];



  try{
    
    
  
    final response = await http.get(
      Uri.parse('${APIConstants.licenceURL}/$id'),
      headers: {'Accept':'application/json',
     }
    );

    var values = jsonDecode(response.body)['licence'];


     
    
  print(values);

    if(values.length>0){
      
        for(int i=0;i<values.length;i++){
          
          if(values[i]!=null){
           
            Map<String,dynamic> map=values[i];
            
            licenceList.add(LicenceModel.fromJson(map));
          }}
    }
    

       
 
     

    switch (response.statusCode) {
      case 200:
      // apiResponse.data = Category.fromJson(jsonDecode(response.body));
        // apiResponse.data = jsonDecode(response.body)['categories'].map((p) => Category.fromJson(p)).toList();
        // we get list of posts, so we need to map each item to post model
        apiResponse.data = licenceList;
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



