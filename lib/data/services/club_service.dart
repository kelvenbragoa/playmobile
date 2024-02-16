import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:padelmobile/data/repositories/court_model.dart';

import '../../utils/constants/api_constants.dart';
import '../repositories/api_response.dart';
import '../repositories/club_model.dart';
import '../repositories/licence_model.dart';


Future<ApiResponse> getAllClub() async {

//funional
  ApiResponse apiResponse = ApiResponse();
  var data;
  List<ClubModel> clubList =[];


  try{
    
    
    final response = await http.get(
      Uri.parse(APIConstants.clubURL),
      headers: {'Accept':'application/json',
     }
    );



    var values = jsonDecode(response.body)['clubs'];

   

   
   


    if(values.length>0){
        for(int i=0;i<values.length;i++){
          if(values[i]!=null){
            Map<String,dynamic> map=values[i];
            clubList.add(ClubModel.fromJson(map));
         
          }}
    }
    

       
 
     

    switch (response.statusCode) {
      case 200:
      // apiResponse.data = Category.fromJson(jsonDecode(response.body));
        // apiResponse.data = jsonDecode(response.body)['categories'].map((p) => Category.fromJson(p)).toList();
        // we get list of posts, so we need to map each item to post model
        apiResponse.data = clubList;
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


Future<ApiResponse> getClub(id) async {

//funional
  ApiResponse apiResponse = ApiResponse();
  var data;
  List<CourtModel> courtList =[];



  try{
    
    
  
    final response = await http.get(
      Uri.parse('${APIConstants.clubURL}/$id'),
      headers: {'Accept':'application/json',
     }
    );

    var values = jsonDecode(response.body)['courts'];








    if(values.length>0){
 
      
        for(int i=0;i<values.length;i++){
      
          if(values[i]!=null){
           
            Map<String,dynamic> map=values[i];
            
            courtList.add(CourtModel.fromJson(map));
          }}
    }
    

       
 
     

    switch (response.statusCode) {
      case 200:
      // apiResponse.data = Category.fromJson(jsonDecode(response.body));
        // apiResponse.data = jsonDecode(response.body)['categories'].map((p) => Category.fromJson(p)).toList();
        // we get list of posts, so we need to map each item to post model
        apiResponse.data = courtList;
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



