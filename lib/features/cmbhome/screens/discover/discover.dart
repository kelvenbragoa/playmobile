import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../data/repositories/api_response.dart';
import '../../../../data/repositories/club_model.dart';
import '../../../../data/services/club_service.dart';
import '../../../../utils/constants/api_constants.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper.dart';
import '../home/club_detail.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
    List<dynamic> _clubList = [];
  List<dynamic> _clubListSearch = [];
  TextEditingController controller = TextEditingController(text: '');
  String dropdownvalue = 'Tudo'; 
 var items = [    
  "Tudo", 
    "Beira",
    "Maputo",
    "Tete",
    "Nampula",
    "Zambézia",
    "Xai-Xai",
  ]; 
  bool _loading = true;
 
  Future<void> retrieveAllClubs()async{
    
    ApiResponse response = await getAllClub();
      setState(() {
        _clubList = response.data as List<dynamic>;
        _clubListSearch= response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
      });
     
    if(response.error == null){
      setState(() {
        _clubList = response.data as List<dynamic>;
        _clubListSearch= response.data as List<dynamic>;
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
      results = _clubListSearch;
    } else {
      

     
      results = _clubListSearch
          .where((product){
            
            return product.name.toLowerCase().contains(enteredKeyword.toLowerCase()) || product.amount.toString().contains(enteredKeyword);
            // return ticket.id.toString().contains(enteredKeyword);
           
          })
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    setState(() {
      _clubList = results;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retrieveAllClubs();
  }

  @override
  Widget build(BuildContext context){
  
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Discover',style: Theme.of(context).textTheme.bodyLarge),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.message),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Iconsax.notification),
            onPressed: () {},
          ),
        ],
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
                      
        ) : 
                Column(
                  children: [
                    Container(
                          margin: const EdgeInsets.all(4),
                          // child: TextField(
                          //   controller: controller,
                          //   decoration: InputDecoration(
                          //     prefixIcon: const Icon(Iconsax.search_normal),
                          //     hintText: 'My Schedules',
                          //     border: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(5),
                          //       borderSide: const BorderSide(color: Color.fromARGB(255, 76, 175, 163))
                          //     )
                          //   ),
                          //   onChanged: _runFilter,
                          // ),
                          child: DropdownButtonFormField( 
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Iconsax.search_favorite),
                              hintText: 'Discover',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Color.fromARGB(255, 76, 175, 163))
                              )
                            ),
                          isExpanded: true,
                          // Initial Value 
                          value: dropdownvalue, 
                          
                          // Down Arrow Icon 
                          icon: const Icon(Icons.keyboard_arrow_down),     
                            
                          // Array list of items 
                          items: items.map((String items) { 
                            return DropdownMenuItem( 
                              value: items, 
                              child: Text(items,style: Theme.of(context).textTheme.bodyMedium,), 
                            ); 
                          }).toList(), 
                          // After selecting the desired option,it will 
                          // change button value to selected value 
                          onChanged: (String? newValue) {  
                            setState(() { 
                              dropdownvalue = newValue!; 
                            }); 
                          
                          }, 
                        ), 
                        ),
                        Row(
                          children: [
                            Container(
                              
                              margin: const EdgeInsets.all(12),
                              padding: const EdgeInsets.all(8),
                              
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 0, 23, 62),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color:  dark ? Color.fromARGB(255, 162, 189, 236) : Color.fromARGB(255, 0, 23, 62))
                              ),
                              child: Text('Padel',style: TextStyle(color:!dark ? Color.fromARGB(255, 255, 255, 255) : Color.fromARGB(255, 0, 23, 62) ),)
                            ),
                            Container(
                              
                              margin: const EdgeInsets.all(12),
                              padding: const EdgeInsets.all(8),
                              
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 0, 23, 62),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color:  dark ? const Color.fromARGB(255, 162, 189, 236) : Color.fromARGB(255, 0, 23, 62))
                              ),
                              child: Text('${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',style: TextStyle(color:!dark ? Color.fromARGB(255, 255, 255, 255) : Color.fromARGB(255, 0, 23, 62) ),)
                            ),
                          ],
                        ),  

                        Expanded(
                          child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: _clubList.length,
                                itemBuilder: (BuildContext context, int index){
                                  ClubModel club = _clubList[index];
                                  return InkWell(
                                    onTap: (){
                                      Get.to(ClubDetails(id: club.id, name: club.name,address:club.address, province:club.province, description:club.description, minPrice: club.minPrice,));
                                    },
                                    child: SizedBox(
                                      height: 200,
                                      width: MediaQuery.of(context).size.width,
                                      child: Card(
                                          child: ClipRRect(
                                           borderRadius: BorderRadius.circular(TSizes.fontSizeMd),
                                            child: Container(
                                             decoration: const BoxDecoration(
                                               image: DecorationImage(image: AssetImage(TImages.padel ), fit: BoxFit.fitWidth,)
                                             ),
                                             child: Padding(
                                               padding: EdgeInsets.all(8.0),
                                               child: Column(
                                                // crossAxisAlignment: CrossAxisAlignment,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                               
                                               const Row(
                                                children: [
                                                  Icon(Iconsax.heart,size: TSizes.iconMd*1.5,color: TColors.white,)
                                                ],
                                               ),
                                               Row(
                                                children: [
                                                  Flexible(child: Text('${club.name}, ${club.address},${club.province} ${club.province} ${club.province}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: TColors.white),maxLines: 1,overflow: TextOverflow.ellipsis,))
                                                ],
                                               )

                                               ],),
                                             ),
                                            )
                                          ),
                                        ),
                                    ),
                                  );
                                }
                              ),
                        )
                  
                ]));
         
            
  
          
        
      
    
  }
}




