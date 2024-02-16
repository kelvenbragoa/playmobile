import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
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
import '../../../../utils/helpers/helper.dart';
import '../../../authentication/screens/onboarding/onboarding.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
  
}


class _TransactionScreenState extends State<TransactionScreen> {
  late WalletModel walletModel ;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool _loading = true;
  bool _loadingbutton = false;
  late TransactionModel transaction;
   List<dynamic> _transactionsList = [];
  List<dynamic> _transactionsListSearch = [];

    Future<void> retrieveAllTransactions()async{

 

    
    ApiResponse response = await getAllTransactions();
  
      setState(() {
        
        _transactionsList = response.data as List<dynamic>;
        _transactionsListSearch= response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
      });
     
     
   
    if(response.error == null){
      setState(() {
        _transactionsList = response.data as List<dynamic>;
        _transactionsListSearch= response.data as List<dynamic>;
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
      results = _transactionsListSearch;
    } else {
      

     
      results = _transactionsListSearch
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
      _transactionsList = results;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retrieveAllTransactions();
  }
  @override
  Widget build(BuildContext context){
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
       appBar: AppBar(
        leading:IconButton(
          icon: const Icon(Icons.close),
            onPressed: () {
              Get.back();
            },
        ),
        title: Text('Transactions',style: Theme.of(context).textTheme.bodyLarge),
        
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
                      
        ) : Column(
          children: [
           
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text('Your Transactions',style: Theme.of(context).textTheme.bodyLarge,)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Flexible(
                      child: Text('All your transactions made on Lets play padel',style: Theme.of(context).textTheme.labelMedium,)
                      ),
                      // const Icon(Icons.arrow_forward_ios,size: TSizes.fontSizeMd,)
                  ],
                ),
              ),
              Divider(),

              Expanded(
                child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                // physics: const NeverScrollableScrollPhysics(),
                                itemCount: _transactionsList.length,
                                itemBuilder: (BuildContext context, int index){
                                  TransactionModel transaction = _transactionsList[index];
                                  String formattedDate = DateFormat('MMM d hh:mm').format(DateTime.parse(transaction.createdAt));
                                  return 
                                    ListTile(
                                      // onTap: (){
                                      //   Get.to(MytransactionDetailsScreen(id: transaction.id));
                                      // },
                                      leading: CircleAvatar(
                                        backgroundColor: dark ? TColors.ligth : TColors.dark,
                                        child: Text('${index+1}',style: TextStyle(color: !dark ? TColors.ligth : TColors.dark)),
                                      ),
                                      title: Text('${formattedDate}, ${transaction.transaction},  ${transaction.method}'),
                                      subtitle: Text('Amount: ${transaction.amount} MT / Balance:${transaction.balance}'),
                                      // trailing: const Icon(Icons.arrow_forward_ios),
                                    );
                                }
                                ),
              ),

           
                  
                  
              
                            
                          ],
                        ),
                     


            
            

   
         
            
  
          
        );
      
    
  }
}




