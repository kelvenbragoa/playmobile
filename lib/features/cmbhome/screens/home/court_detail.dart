import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:padelmobile/data/repositories/court_model.dart';
import 'package:padelmobile/data/services/court_service.dart';
import 'package:padelmobile/features/cmbhome/screens/home/schedule.dart';
import 'package:padelmobile/utils/constants/text_strings.dart';
import '../../../../common/custom_shapes/containers/primary_head_container.dart';
import '../../../../data/repositories/api_response.dart';
import '../../../../data/repositories/schedule.dart';
import '../../../../data/services/payment_service.dart';
import '../../../../data/services/schedule_service.dart';
import '../../../../data/services/user_services.dart';
import '../../../../utils/constants/api_constants.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../fees/widgets/fees_detail_app_bar.dart';
import 'package:table_calendar/table_calendar.dart';

class CourtsDetailScreen extends StatefulWidget {
  int id;
  CourtsDetailScreen({super.key,required this.id});

  @override
  State<CourtsDetailScreen> createState() => _CourtsDetailScreenState();
}

class _CourtsDetailScreenState extends State<CourtsDetailScreen> {
  List<dynamic> _courtList = [];
   List<dynamic> _scheduleList = [];
  List<dynamic> _courtListSearch = [];
  final TextEditingController _titleController = TextEditingController(text: '');
  final TextEditingController _obsController = TextEditingController(text: '');
  bool _loadingbutton = false;
  bool _loadingContainer = false;
  late int licenceid;
  bool _loading = true;
  bool _loadingDiv = true;
  late CourtModel court;
  
  
  CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  Map<DateTime, List<ScheduleModel>> _events = {};
  late final ValueNotifier<List<ScheduleModel>> _selectedEventes;
  


    Future<void> createNewPayment() async {
    
    setState(() {
      _loadingbutton = true;
    });
   
   var res = await createPayment(UserService.userProfile.id, widget.id,_titleController.text, _obsController.text);

  

              if(res.error == null){
                Get.back();
                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('${res.data}')
                  ));
                 
               }else{
                Get.back();
                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('${res.error}')
                  ));
               }


  }

  Future<void> retrieveSchedule(date)async{
    ApiResponse response = await getSchedule(widget.id,date);
    setState(() {
        _scheduleList = response.data as List<dynamic>;
        _loadingContainer = _loadingContainer ? !_loadingContainer : _loadingContainer;
      });

      if(response.error == null){
      setState(() {
        _scheduleList = response.data as List<dynamic>;
        _loadingContainer = _loadingContainer ? !_loadingContainer : _loadingContainer;
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
        content: Text('${response.error}')));
    } 

  }

  Future<void> retrieveCourt()async{

    // Future<Position> position = HelperMethods.checkLocation();

    
    

    



    ApiResponse response = await getCourt(widget.id);
  

    setState(() {
      licenceid = widget.id;
    }); 
  
      setState(() {
        _courtList = response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
      });
      court = _courtList[0];

      
     
     
   
    if(response.error == null){
      setState(() {
        _courtList = response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
        
      });
      court = _courtList[0];
    
    }
    else if(response.error == APIConstants.serverError){
      // logout().then((value)  {
      //   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>LoginPage()), (route) => false);
      // });
    }
    else{
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}')));
    } 

  }
 



void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      // _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  List<ScheduleModel> _getEventsForDay(DateTime day) {
    return _events[day] ?? []; 
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEventes = ValueNotifier(_getEventsForDay(_selectedDay!));
    retrieveCourt();
  }

  @override
  Widget build(BuildContext context){

    var number = NumberFormat.currency(name: 'MZN');

    return Scaffold(
      appBar: AppBar(
        title: Text(
                        'Schedule Court',
                        style: Theme.of(context).textTheme.headlineSmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
      ),
      body: SingleChildScrollView(
        child: Column(
            children: [
              // const TPrimaryHeaderContainer(
              //   size: 150,
              //   child: Column(
              //    children: [
              //     TFeesDetailAppBar(),
              //     SizedBox(height: TSizes.spaceBetwSections,),
      
                  
              //    ],
              //   )
              // ),
              //  Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           'Quadra',
              //           style: Theme.of(context).textTheme.headlineSmall,
              //           maxLines: 1,
              //           overflow: TextOverflow.ellipsis,
              //         )
              //       ],
              
              //     ),
              // ),
                //  const SizedBox(
                //   height: TSizes.spaceBetwItems,
                // ),
      
               _loading ? const Padding(
        
        padding: EdgeInsets.all(8),
          
                        child: Center(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              backgroundColor: TColors.primary,
                            ),
                            Text(TText.pleaseWait)
                            
                          ],
                        )),
                      ) : 
                   Column(
                    
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                court.name,
                                style: Theme.of(context).textTheme.bodyMedium,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                      
                          ),
                      ),
                      TableCalendar<ScheduleModel>(
                          firstDay: DateTime.now(),
                          lastDay: DateTime.utc(2030, 3, 14),
                          focusedDay: DateTime.now(),
                          calendarFormat: _calendarFormat,
                          onDaySelected: (selectedDay, focusedDay) {
                          if (!isSameDay(_selectedDay, selectedDay)) {
                            // Call `setState()` when updating the selected day
                            setState(() {
                              _selectedDay = selectedDay;
                              _focusedDay = focusedDay;
                            });
                          }
                          retrieveSchedule(selectedDay);
                        },
                          // eventLoader: _getEventsForDay,
                          selectedDayPredicate: (day) {
                          // Use `selectedDayPredicate` to determine which day is currently selected.
                          // If this returns true, then `day` will be marked as selected.
                          // Using `isSameDay` is recommended to disregard
                          // the time-part of compared DateTime objects.
                          return isSameDay(_selectedDay, day);
                        },
                        onFormatChanged: (format) {
                            if (_calendarFormat != format) {
                              // Call `setState()` when updating calendar format
                              setState(() {
                                _calendarFormat = format;
                              });
                            }
                          },
                          onPageChanged: (focusedDay) {
                            // No need to call `setState()` here
                            _focusedDay = focusedDay;
                          },
                        ),
                      
                       
                         _loadingContainer ? const Padding(
        
                        padding: EdgeInsets.all(8),
          
                        child: Center(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              backgroundColor: TColors.primary,
                            ),
                            Text(TText.pleaseWait)
                            
                          ],
                        )),
                      ) : ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _scheduleList.length,
                            itemBuilder: (BuildContext context, int index){
                              ScheduleModel scheduleModel = _scheduleList[index];
      
                            return ListTile(
                                    onTap: (){
                                      Get.to(ScheduleScreen(id: scheduleModel.id));
                                    },
                                    title: Text('${scheduleModel.startTime} ás ${scheduleModel.endTime}'),
                                    trailing: Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:  scheduleModel.statusId == 1 ? Colors.green : (scheduleModel.statusId == 2 ? Colors.yellow : Colors.red)
                                      ),
                                      child: Text('${scheduleModel.status}')),
                                
                                  
                              
                           
                              );
                            }),
                        
      
                        
                    ]
                  )
           
              
        
            ],
          ),
      ),
      
    );
  }
}




