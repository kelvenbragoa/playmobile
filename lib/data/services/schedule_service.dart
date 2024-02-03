import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:padelmobile/data/repositories/schedule.dart';

import '../../utils/constants/api_constants.dart';
import '../repositories/api_response.dart';
import '../repositories/licence_model.dart';




Future<ApiResponse> getSchedule(id,date) async {

//funional
  ApiResponse apiResponse = ApiResponse();
  var data;
  List<ScheduleModel> scheduleList =[];


  DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(date.toString());


  DateTime theDate = DateFormat("yyyy-MM-dd").parse(tempDate.toString());

  String newdate = "${theDate.year}-${theDate.month}-${theDate.day}";

 


  


  try{
    
    
    final response = await http.get(
      Uri.parse('${APIConstants.scheduleURL}?id=$id&date=$newdate'),
      headers: {'Accept':'application/json',
     }
    );



    var values = jsonDecode(response.body)['schedules'];
    


   
     
    
  

    if(values.length>0){
        for(int i=0;i<values.length;i++){
          if(values[i]!=null){
            Map<String,dynamic> map=values[i];
            scheduleList.add(ScheduleModel.fromJson(map));
          }}
    }
    

       
 
     

    switch (response.statusCode) {
      case 200:
      // apiResponse.data = Category.fromJson(jsonDecode(response.body));
        // apiResponse.data = jsonDecode(response.body)['categories'].map((p) => Category.fromJson(p)).toList();
        // we get list of posts, so we need to map each item to post model
        apiResponse.data = scheduleList;
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


Future<ApiResponse> getScheduleHour(id) async {

//funional
  ApiResponse apiResponse = ApiResponse();
  var data;
  List<ScheduleModel> scheduleList =[];



  try{
    
    
  
    final response = await http.get(
      Uri.parse('${APIConstants.scheduleURL}/$id'),
      headers: {'Accept':'application/json',
     }
    );

    var values = jsonDecode(response.body)['schedule'];

print(values);
     



    if(values.length>0){
      
        for(int i=0;i<values.length;i++){
          
          if(values[i]!=null){
           
            Map<String,dynamic> map=values[i];
            
            scheduleList.add(ScheduleModel.fromJson(map));
          }}
    }
    

       
 
     

    switch (response.statusCode) {
      case 200:
      // apiResponse.data = Category.fromJson(jsonDecode(response.body));
        // apiResponse.data = jsonDecode(response.body)['categories'].map((p) => Category.fromJson(p)).toList();
        // we get list of posts, so we need to map each item to post model
        apiResponse.data = scheduleList;
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



