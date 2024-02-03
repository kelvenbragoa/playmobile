import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:padelmobile/data/repositories/myschedule.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../common/custom_shapes/containers/primary_head_container.dart';
import '../../../../data/repositories/api_response.dart';
import '../../../../data/repositories/payment_model.dart';
import '../../../../data/services/payment_service.dart';
import '../../../../utils/constants/api_constants.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import 'payments_detail.dart';
import 'widgets/payments_app_bar.dart';

class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({super.key});

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
    List<dynamic> _scheduleList = [];
  List<dynamic> _scheduleListSearch = [];
  TextEditingController controller = TextEditingController(text: '');




  bool _loading = true;
 

  
  
  Future<void> retrieveAllPayments()async{

 

    
    ApiResponse response = await getAllPayments();
  
      setState(() {
        
        _scheduleList = response.data as List<dynamic>;
        _scheduleListSearch= response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
      });
     
     
   
    if(response.error == null){
      setState(() {
        _scheduleList = response.data as List<dynamic>;
        _scheduleListSearch= response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
      });

    }
    else if(response.error == APIConstants.serverError){
      // logout().then((value)  {
      //   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>LoginPage()), (route) => false);
      // });
    }
    else{
      
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}'),
  //       action: SnackBarAction(
  //       label: 'Undo',
  //       onPressed: () {
  //         // Some code to undo the change.
  //         ScaffoldMessenger.of(context).hideCurrentSnackBar();
  //       },
  // ),
        ));
    } 

   
   
  

    

  }

void _runFilter(String enteredKeyword) {
    List<dynamic> results = [];

    
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _scheduleListSearch;
    } else {
      

     
      results = _scheduleListSearch
          .where((product){
            
            return product.name.toLowerCase().contains(enteredKeyword.toLowerCase()) || product.amount.toString().contains(enteredKeyword);
            // return ticket.id.toString().contains(enteredKeyword);
           
          })
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // results = _allUsers
    //       .where((user) =>
    //           user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
    //       .toList();
      // we use the toLowerCase() method to make it case-insensitive

    // Refresh the UI
    setState(() {
      _scheduleList = results;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retrieveAllPayments();
  }

  @override
  Widget build(BuildContext context){
    var number = NumberFormat.currency(name: 'MZN');
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TPrimaryHeaderContainer(
              size: 150,
              child: Column(
               children: [
                TPaymentsAppBar(),
                SizedBox(height: TSizes.spaceBetwSections,),

                
               ],
              )
            ),
             Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'My Schedules',
                      style: Theme.of(context).textTheme.headlineSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
            ),
               const SizedBox(
                height: TSizes.spaceBetwItems,
              ),

             _loading ? const Padding(
      
            padding: EdgeInsets.all(8),
    
                      child: Center(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            backgroundColor: TColors.primary,
                          ),
                          Text('Carregando...')
                        ],
                      )),
                    ) : 
                Column(
                  children: [
                    Container(
                          margin: const EdgeInsets.all(4),
                          child: TextField(
                            controller: controller,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Iconsax.search_normal),
                              hintText: 'My Schedules',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Color.fromARGB(255, 76, 175, 163))
                              )
                            ),
                            onChanged: _runFilter,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(2),
                          alignment: Alignment.bottomLeft,
                          child: Text('Results: ${_scheduleList.length}')
                        ),
                        SizedBox(
                          height: 600,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _scheduleList.length,
                            itemBuilder: (BuildContext context, int index){
                              MyScheduleModel schedule = _scheduleList[index];
                              String formattedDate = DateFormat('MMM d').format(DateTime.parse(schedule.date));
                              return 
                                ListTile(
                                  onTap: (){
                                    // Get.to(PaymentsDetailsScreen(id: schedule.id));
                                  },
                                  leading: CircleAvatar(
                                    backgroundColor: TColors.primary,
                                    child: Text('${index+1}'),
                                  ),
                                  title: Text('${formattedDate} , ${schedule.court}'),
                                  subtitle: Text('${schedule.startTime} ás ${schedule.endTime}'),
                                  trailing: const Icon(Icons.more_vert),
                                );
                            }
                            ),
                        )
                        
                  ],
                )
         
            
  
          ],
        ),
      ),
    );
  }
}




