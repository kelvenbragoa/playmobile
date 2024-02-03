import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../common/custom_shapes/containers/primary_head_container.dart';
import '../../../../data/repositories/api_response.dart';
import '../../../../data/repositories/licence_model.dart';
import '../../../../data/services/helper.dart';
import '../../../../data/services/licence_service.dart';
import '../../../../data/services/payment_service.dart';
import '../../../../data/services/user_services.dart';
import '../../../../utils/constants/api_constants.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import 'widgets/fees_app_bar.dart';
import 'widgets/fees_detail_app_bar.dart';

class FeesDetailScreen extends StatefulWidget {
  int id;
  FeesDetailScreen({super.key,required this.id});

  @override
  State<FeesDetailScreen> createState() => _FeesDetailScreenState();
}

class _FeesDetailScreenState extends State<FeesDetailScreen> {
  List<dynamic> _licenceList = [];
  List<dynamic> _licenceListSearch = [];
  final TextEditingController _titleController = TextEditingController(text: '');
  final TextEditingController _obsController = TextEditingController(text: '');
  bool _loadingbutton = false;
  late int licenceid;
  bool _loading = true;
  late LicenceModel licence;
  


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

  Future<void> retrieveFee()async{

    // Future<Position> position = HelperMethods.checkLocation();

    
    

    



    ApiResponse response = await getLicence(widget.id);

    setState(() {
      licenceid = widget.id;
    }); 
  
      setState(() {
        _licenceList = response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
      });
      licence = _licenceList[0];
     
     
   
    if(response.error == null){
      setState(() {
        _licenceList = response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
        
      });
      licence = _licenceList[0];
    
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


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HelperMethods.checkLocation();
    
    retrieveFee();
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
                TFeesDetailAppBar(),
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
                      'Taxas e Licenças',
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
                    Wrap(
                     children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:TSizes.defaultSpace, vertical: TSizes.spaceBetwItems/2),
                        child: Text('ID: ${licence.id}',overflow: TextOverflow.clip,),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:TSizes.defaultSpace,vertical: TSizes.spaceBetwItems/2),
                        child: Text('Descrição: ${licence.name}',overflow: TextOverflow.clip,),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:TSizes.defaultSpace, vertical: TSizes.spaceBetwItems/2),
                        child: Text('Valor: ${number.format(double.parse(licence.amount.toString()))}',overflow: TextOverflow.clip,),
                      ),
                     ],
                    ),
                     Padding(
                        padding: const EdgeInsets.symmetric(horizontal:TSizes.defaultSpace, vertical: TSizes.spaceBetwItems/2),
                        child: TextFormField(
                              keyboardType: TextInputType.text,
                              controller: _titleController,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Iconsax.direct_right),
                                labelText: 'Título'
                              ),
                            ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:TSizes.defaultSpace, vertical: TSizes.spaceBetwItems/2),
                        child: TextFormField(
                              keyboardType: TextInputType.text,
                              controller: _obsController,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Iconsax.direct_right),
                                labelText: 'Outros Dados'
                              ),
                            ),
                      ),
                      !_loadingbutton ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal:TSizes.defaultSpace, vertical: TSizes.spaceBetwItems/2),
                        child:  ElevatedButton(
                            onPressed: (){
                              createNewPayment();
                            },
                            child: const Text('Pagar',),
                          ),
                      ) : const SizedBox(
                            width: double.infinity,
                            child: Column(
                            children: [
                              CircularProgressIndicator(
                                backgroundColor: TColors.primary,
                              ),
                              Text(TText.pleaseWait)
                            ],
                          )
                          ) 

                       
                    
                       
                  ],
                )
         
            
  
          ],
        ),
      ),
    );
  }
}




