import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:padelmobile/data/repositories/court_model.dart';
import 'package:padelmobile/data/services/court_service.dart';
import 'package:padelmobile/features/cmbhome/screens/home/court_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../common/custom_shapes/containers/primary_head_container.dart';
import '../../../../data/repositories/api_response.dart';
import '../../../../data/repositories/licence_model.dart';
import '../../../../data/services/licence_service.dart';
import '../../../../utils/constants/api_constants.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../fees/widgets/fees_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    List<dynamic> _courtList = [];
  List<dynamic> _courtListSearch = [];
  TextEditingController controller = TextEditingController(text: '');




  bool _loading = true;
 

  
  
  Future<void> retrieveAllProducts()async{

 

    print('object');
    ApiResponse response = await getAllCourt();

  


  
 
  
      setState(() {
        _courtList = response.data as List<dynamic>;
        _courtListSearch= response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
      });
     

     
   
    if(response.error == null){
      setState(() {
        _courtList = response.data as List<dynamic>;
        _courtListSearch= response.data as List<dynamic>;
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
      results = _courtListSearch;
    } else {
      

     
      results = _courtListSearch
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
      _courtList = results;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retrieveAllProducts();
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
                TFeesAppBar(),
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
                      'Lets Play',
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
                    
                        
                        SizedBox(
                          height: 250,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _courtList.length,
                            itemBuilder: (BuildContext context, int index){
                              CourtModel court = _courtList[index];
                              return InkWell(
                                onTap: (){
                                  Get.to(CourtsDetailScreen(id: court.id));
                                },
                                child: Card(
                                  color: Color.fromARGB(255, 249, 249, 249),
                                    margin: const EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Container(
                                          width: 250,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                // Image.asset(court.imageUrl,width: 250, height: 150,),
                                                // Image.network(court.imageUrl,width: 250, height: 150,),
                                                Image(image: AssetImage(TImages.letsPlay ),width: 250, height: 150,),
                                                Text(
                                                  court.name,
                                                  style: Theme.of(context).textTheme.bodySmall,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  court.description,
                                                  style: Theme.of(context).textTheme.bodySmall,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                               
                                              ],
                                            ),
                                          )
                                        ),
                                                                              
                                      ],
                                    ),
                                  ),
                              );
                            }
                          )),
                          Container(
                            color: Color.fromARGB(255, 249, 249, 249),
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  // Text('REGRAS PARA CANCELAMENTO',style: Theme.of(context).textTheme.bodySmall,),
                                  Text('RULES FOR CANCELLATION',style: Theme.of(context).textTheme.bodySmall,),
                                  // Text(
                                  //   'Você pode cancelar GRATUITAMENTE até 1 dia(s) antes do horário. Se você cancelar após o horário limite, será cobrada uma taxa de 50% do valor total do agendamento. Se o pagamento for um sinal, ele será a multa.',style: Theme.of(context).textTheme.bodySmall,textAlign: TextAlign.center,),
                          Text(
                                    'You can cancel for FREE up to 1 day(s) before the scheduled time. If you cancel after the cut-off time, you will be charged a fee of 50% of the total booking fee. If the payment is a down payment, it will be the fine.',style: Theme.of(context).textTheme.bodySmall,textAlign: TextAlign.center,),
                          
                                ],
                              ),
                              ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text('Informações Gerais',style: Theme.of(context).textTheme.headlineSmall,),
                                // Text('Central de Reservas (842648618)', style: Theme.of(context).textTheme.labelSmall,),
                                // Text('Campos abertos de 8:00 às 12:00 das 14:00 as 23:00 de Segunda-Feira a Sexta-Feira', style: Theme.of(context).textTheme.labelSmall,),
                                // Text('Sábado 8:00 as 22:00', style: Theme.of(context).textTheme.labelSmall,),

                                Text('General information',style: Theme.of(context).textTheme.headlineSmall,),
                                Text('Reservation Center (842648618)', style: Theme.of(context).textTheme.labelSmall,),
                                Text('Courts open from 8:00 to 12:00 from 14:00 to 23:00 from Monday to Friday', style: Theme.of(context).textTheme.labelSmall,),
                                Text('Saturday 8:00 to 22:00', style: Theme.of(context).textTheme.labelSmall,),
                              ],
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




