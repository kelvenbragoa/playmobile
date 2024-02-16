import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:padelmobile/data/repositories/confirmationSchedule.dart';
import 'package:padelmobile/data/repositories/court_model.dart';
import 'package:padelmobile/data/services/court_service.dart';
import 'package:padelmobile/features/cmbhome/screens/home/confirmSchedule.dart';
import 'package:padelmobile/utils/constants/text_strings.dart';
import '../../../../data/repositories/api_response.dart';
import '../../../../data/repositories/schedule.dart';
import '../../../../data/services/payment_service.dart';
import '../../../../data/services/schedule_service.dart';
import '../../../../data/services/user_services.dart';
import '../../../../utils/constants/api_constants.dart';
import '../../../../utils/constants/colors.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../utils/constants/sizes.dart';

class ScheduleScreen extends StatefulWidget {
  int id;
  ScheduleScreen({super.key, required this.id});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  List<dynamic> _scheduleList = [];
  List<dynamic> _confirmationScheduleList = [];
  final TextEditingController _titleController =
      TextEditingController(text: '');
  final TextEditingController _obsController = TextEditingController(text: '');
  late int licenceid;
  bool _loading = true;
  bool _loadingbutton = false;
  late ScheduleModel schedule;
  late ConfirmationSchedule confirmationSchedule;

  Future<void> createNewPayment() async {
    setState(() {
      _loadingbutton = true;
    });

    var res = await createPayment(UserService.userProfile.id, widget.id,
        _titleController.text, _obsController.text);

    setState(() {
        _confirmationScheduleList = res.data as List<dynamic>;
      });

      confirmationSchedule = _confirmationScheduleList[0];

     

 
      

    if (res.error == null) {
      // Get.back();
      confirmationSchedule = _confirmationScheduleList[0];
      setState(() {
        _confirmationScheduleList = res.data as List<dynamic>;
      });
      Get.offAll(
        ConfirmScheduleScreen(confirmationSchedule2: confirmationSchedule,)
        );
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${res.message}')));
    } else {
      Get.back();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${res.error}')));
    }
  }

  Future<void> retrieveSchedule() async {
    // Future<Position> position = HelperMethods.checkLocation();

    ApiResponse response = await getScheduleHour(widget.id);

    setState(() {
      licenceid = widget.id;
    });

   
    setState(() {
      _scheduleList = response.data as List<dynamic>;
      _loading = _loading ? !_loading : _loading;
    });
    schedule = _scheduleList[0];

    if (response.error == null) {
      setState(() {
        _scheduleList = response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
      });
      schedule = _scheduleList[0];
    } else if (response.error == APIConstants.serverError) {
      // logout().then((value)  {
      //   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>LoginPage()), (route) => false);
      // });
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    retrieveSchedule();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Schedule Court',
          style: Theme.of(context).textTheme.headlineSmall,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: _loading ? const Center(
          child: Padding(
              
              padding: EdgeInsets.all(8),
            
                        child: Center(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CupertinoActivityIndicator(
                              // backgroundColor: TColors.primary,
                              color: TColors.primary,
        
                            ),
                            Text(TText.pleaseWait)
                            
                          ],
                        )))
                      
        )
                : SingleChildScrollView(
                  child: Column(children: [
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Appointment Form',
                            style: Theme.of(context).textTheme.headlineMedium,
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Time:',
                              style: Theme.of(context).textTheme.bodyLarge,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '${schedule.startTime} ás ${schedule.endTime}',
                              style: Theme.of(context).textTheme.bodyMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Date:',
                              style: Theme.of(context).textTheme.bodyLarge,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              schedule.date,
                              style: Theme.of(context).textTheme.bodyMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Location:',
                              style: Theme.of(context).textTheme.bodyLarge,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  schedule.court,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                ),
                                Text(
                                  'Padel Arena',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                Text(
                                  'Beira, Bairro do Estoril',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Players:',
                              style: Theme.of(context).textTheme.bodyLarge,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '${schedule.players}',
                              style: Theme.of(context).textTheme.bodyMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: TSizes.spaceBetwSections,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: _obsController,
                          decoration: const InputDecoration(
                              labelText: TText.addInfo,
                              prefixIcon: Icon(Iconsax.info_circle)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return TText.requiredField;
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Payment',
                            style: Theme.of(context).textTheme.headlineMedium,
                          )),
                        Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Name:',
                              style: Theme.of(context).textTheme.bodyLarge,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '${UserService.userProfile.firstName} ${UserService.userProfile.lastName}',
                              style: Theme.of(context).textTheme.bodyMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                       Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Email:',
                              style: Theme.of(context).textTheme.bodyLarge,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '${UserService.userProfile.email}',
                              style: Theme.of(context).textTheme.bodyMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Balance:',
                              style: Theme.of(context).textTheme.bodyLarge,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '${schedule.balance} MZN',
                              style: Theme.of(context).textTheme.bodyMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Category:',
                              style: Theme.of(context).textTheme.bodyLarge,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '${schedule.price}',
                              style: Theme.of(context).textTheme.bodyMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'SubTotal:',
                              style: Theme.of(context).textTheme.bodyLarge,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '${schedule.priceValue} MZN',
                              style: Theme.of(context).textTheme.bodyMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total:',
                              style: Theme.of(context).textTheme.bodyLarge,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '${schedule.priceValue} MZN',
                              style: Theme.of(context).textTheme.bodyMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(
                          children: [
                            Text(
                              'By confirming, you agree to our payment and cancellation policies',
                              style: Theme.of(context).textTheme.bodySmall,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      
                
                      _loadingbutton ? const Padding(
                      padding: EdgeInsets.all(8),
                      child: Center(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                         CupertinoActivityIndicator(
                              // backgroundColor: TColors.primary,
                              color: TColors.primary,
        
                            ),
                            Text(TText.pleaseWait)
                        ],
                      )),
                    ) :Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: (){
                            if(schedule.balance >= schedule.priceValue){
                              createNewPayment();
                            }else{
                              showDialog(context: context , builder: (BuildContext context)=>AlertDialog(
                            title: const Text(TText.outOfBalance),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                              Icon(Iconsax.close_circle,size: TSizes.xl*2,color: TColors.error,),
                              Text(TText.topUpAccount)
                            ],),
                            actions: [
                              

                              TextButton(onPressed: (){Navigator.pop(context);}, child: const Text('OK'))
                            ],
                          ));
                            }
                            // 
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal:8.0),
                            child: Text('Payment'),
                          ),
                        )
                      ),
                      const SizedBox(
                        height: TSizes.spaceBetwSections,
                      ),
                    ]),
                )
        
        );
      
    
  }
}
