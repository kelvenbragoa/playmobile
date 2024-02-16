import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:padelmobile/data/repositories/transactionModel.dart';
import 'package:padelmobile/data/services/wallet_service.dart';
import 'package:padelmobile/features/cmbhome/screens/profile/widgets/form_menu.dart';
import 'package:padelmobile/features/cmbhome/screens/wallet/confirmRecharge.dart';
import 'package:padelmobile/utils/constants/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../common/custom_shapes/containers/primary_head_container.dart';
import '../../../../data/repositories/api_response.dart';
import '../../../../data/repositories/walletModel.dart';
import '../../../../data/services/user_services.dart';
import '../../../../utils/constants/api_constants.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../authentication/screens/onboarding/onboarding.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
  
}


class _WalletScreenState extends State<WalletScreen> {
  late WalletModel walletModel ;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool _loading = true;
  bool _loadingbutton = false;
  late TransactionModel transaction;
  final TextEditingController _obsController = TextEditingController(text: '');
  final TextEditingController cardNumberController = TextEditingController(text: '');
  final TextEditingController _amountController = TextEditingController();
  
  final TextEditingController _mobileEmolaController =
      TextEditingController(text: '');
  final TextEditingController _mobileMpesaController =
      TextEditingController(text: '');
  String dropdownvalue = 'Mpesa';    
  
  // List of items in our dropdown menu 
  var items = [     
    "VISA",
    "Mpesa",
    "Emola",
  ]; 
    Future<void> recharge() async {
    setState(() {
      _loadingbutton = true;
    });

    var res = await topUpMpesa(_mobileMpesaController.text,_amountController.text);

    

     

 
      

    if (res.error == null) {
      // Get.back();
      transaction = res.data as TransactionModel;
      setState(() {
        transaction = res.data as TransactionModel;
      });
      Get.offAll(
        ConfirmTransactionScreen(confirmTransaction: transaction,)
        );
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${res.message}')));
    } else {
      Get.back();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${res.error}')));
    }
  }
  Future<void>retrieveWalletDetails()async{
    ApiResponse response = await getWalletInfo();
    
    
    //  setState(() {
    //     _clubList = response.data as List<dynamic>;
    //     _clubListSearch= response.data as List<dynamic>;
    //     _loading = _loading ? !_loading : _loading;
    //   });
     
    if(response.error == null){
      setState(() {
        walletModel = response.data as WalletModel;
        _loading = _loading ? !_loading : _loading;
      });
    }
    else if(response.error == APIConstants.serverError){
      // logout().then((value)  {
      //   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>LoginPage()), (route) => false);
      // });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}'),));
        Get.back();
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
         Get.back();
    } 
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retrieveWalletDetails();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
       appBar: AppBar(
        leading:IconButton(
          icon: const Icon(Icons.close),
            onPressed: () {
              Get.back();
            },
        ),
        title: Text('Wallet',style: Theme.of(context).textTheme.bodyLarge),
        
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
                      
        ) : SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text('Current Balance',style: Theme.of(context).textTheme.bodySmall,),
                  Text.rich(
                    TextSpan(children: [
                      TextSpan(text: '${walletModel.balance}',style: Theme.of(context).textTheme.displayMedium,),
                      TextSpan(text: 'MT',style: Theme.of(context).textTheme.bodySmall,),
                    ])
                    
                  )
                  
                ],
              ),
              
            ),
            Divider(),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text('Your Padel Wallet',style: Theme.of(context).textTheme.bodyLarge,)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Flexible(
                      child: Text('With your wallet you can book any court at any time. Your recharge your wallet with many options, mobile wallet such as Mpesa, Emola and Credit card',style: Theme.of(context).textTheme.labelMedium,)
                      ),
                      // const Icon(Icons.arrow_forward_ios,size: TSizes.fontSizeMd,)
                  ],
                ),
              ),
              Divider(),

               Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text('How do you want to top up your wallet?',style: Theme.of(context).textTheme.bodyLarge,)
                  ],
                ),
                ),
                Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonFormField( 
                            
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _amountController,
                          decoration: const InputDecoration(
                              labelText: '${TText.amount} (METICAL)',
                              prefixIcon: Icon(Iconsax.dollar_circle)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return TText.requiredField;
                            }
                            return null;
                          },
                        ),
                      ),
                      if(dropdownvalue == "VISA")
                       Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(TSizes.fontSizeMd),
                              child: Image(
                                
                                image: AssetImage(TImages.visa ),
                                width: 150, height: 80, fit: BoxFit.fill,),
                            ),
                            Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: cardNumberController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(19),
                      ],
                      decoration: InputDecoration(hintText: "Card number"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: TextFormField(
                        decoration:
                            const InputDecoration(hintText: "Full name"),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              // Limit the input
                              LengthLimitingTextInputFormatter(4),
                            ],
                            decoration: const InputDecoration(hintText: "CVV"),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(5),
                            ],
                            decoration:
                                const InputDecoration(hintText: "MM/YY"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
                            
                          ],
                        ),
                        ),
                      if(dropdownvalue == "Mpesa")
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(TSizes.fontSizeMd),
                              child: Image(
                                
                                image: AssetImage(TImages.mpesa ),
                                width: 150, height: 80, fit: BoxFit.fill,),
                            ),
                            SizedBox(
                              height: TSizes.spaceBetwInputFields,
                            ),
                            Form(
                              key: _key,
                              child: Column(
                                children: [
                                  TextFormField(
                              keyboardType: TextInputType.phone,
                              controller: _mobileMpesaController,
                              decoration: const InputDecoration(
                                  labelText: '${TText.phoneNumber} (84/85)',
                                  prefixIcon: Icon(Iconsax.call)),
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.length != 9) {
                                  return TText.requiredField;
                                }
                                return null;
                              },
                            ),
                           
                                ],
                              ))
                            
                          ],
                        ),
                        ),
                      if(dropdownvalue == "Emola")
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(TSizes.fontSizeMd),
                              child: Image(
                                
                                image: AssetImage(TImages.emola ),
                                width: 150, height: 80, fit: BoxFit.fill,),
                            ),
                            SizedBox(
                              height: TSizes.spaceBetwInputFields,
                            ),
                            Form(
                              key: _key,
                              child: Column(
                                children: [
                                  TextFormField(
                              keyboardType: TextInputType.phone,
                              controller: _mobileEmolaController,
                              decoration: const InputDecoration(
                                  labelText: '${TText.phoneNumber} (86/87)',
                                  prefixIcon: Icon(Iconsax.call)),
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.length != 9) {
                                  return TText.requiredField;
                                }
                                return null;
                              },
                            ),
                                ],
                              ))
                            
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
                    ) : 
                   
                    Padding(
                          padding: const EdgeInsets.all( 16),
                        
                          child: SizedBox(
                             width: double.infinity,
                            child: ElevatedButton(
                              
                              child:  dropdownvalue == 'Mpesa' ? Text("Recharge") : Text("Indisponivel"),
                              onPressed: () {
                                dropdownvalue == 'Mpesa' ? recharge() : null;
                              },
                            ),
                          ),
                        ),
                        


            
            

   
         
            
  
          ],
        ),
      ),
    );
  }
}




