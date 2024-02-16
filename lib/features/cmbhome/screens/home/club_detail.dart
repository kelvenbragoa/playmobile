import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:padelmobile/utils/constants/colors.dart';
import 'package:padelmobile/utils/constants/sizes.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/api_response.dart';
import '../../../../data/repositories/club_model.dart';
import '../../../../data/repositories/court_model.dart';
import '../../../../data/services/club_service.dart';
import '../../../../data/services/court_service.dart';
import '../../../../utils/constants/api_constants.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/text_strings.dart';
import 'court_detail.dart';

class ClubDetails extends StatefulWidget {
  int id;
  String name, description, province,address ;
  var minPrice;
  ClubDetails({super.key, required this.id,required this.name,required this.description,required this.province,required this.address, required this.minPrice});

  @override
  State<ClubDetails> createState() => _ClubDetailsState();

}


class _ClubDetailsState extends State<ClubDetails> {

  List<dynamic> _courtList = [];
  List<dynamic> _courtListSearch = [];
  TextEditingController controller = TextEditingController(text: '');
  bool _loading = true;
    Future<void> retrieveCourtsFromClub()async{
      
    ApiResponse response = await getClub(widget.id);
 
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

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retrieveCourtsFromClub();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name,style: Theme.of(context).textTheme.bodyLarge),
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
                      
        ): SingleChildScrollView(
                      child: Column(
                              children: [
                                Divider(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text('${widget.province}, ${widget.address}',style: Theme.of(context).textTheme.bodyLarge,)
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Flexible(
                      child: Text('Preço a partir de ${widget.minPrice} MT por reserva',style: Theme.of(context).textTheme.labelMedium,)
                      ),
                      // const Icon(Icons.arrow_forward_ios,size: TSizes.fontSizeMd,)
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Flexible(
                      child: Text(widget.description,style: Theme.of(context).textTheme.labelMedium,)
                      ),
                      // const Icon(Icons.arrow_forward_ios,size: TSizes.fontSizeMd,)
                                    ],
                                  ),
                                ),
                                Divider(),
                                const SizedBox(height: TSizes.spaceBetwSections,),
                                
                               
                                 Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text('Quadras',style: Theme.of(context).textTheme.bodyLarge,)
                                    ],
                                  ),
                                ),
                    
                                SizedBox(
                            height: 220,
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
                                    // color: Color.fromARGB(255, 249, 249, 249),
                                      // margin: const EdgeInsets.all(20),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(TSizes.fontSizeMd),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                             ClipRRect(
                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(TSizes.fontSizeMd), topRight: Radius.circular(TSizes.fontSizeMd)),
                                                 child: Image(
                                                  image: AssetImage(TImages.letsPlay ),width: 250, height: 150, fit: BoxFit.fill,),
                                               ),
                                               Padding(
                                                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                 child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                  court.name,
                                                  style: Theme.of(context).textTheme.bodyMedium,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                                                             ),
                                                                                             Text(
                                                  'Limite: ${court.limit}',
                                                  style: Theme.of(context).textTheme.bodyMedium,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                                                             ),
                                                                                             Text(
                                                  court.description,
                                                  style: Theme.of(context).textTheme.bodyMedium,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                                                             ),
                                                  ],
                                                 ),
                                               )
                                              
                                             
                                            ],
                                          ),
                                                                                
                                        ],
                                      ),
                                    ),
                                );
                              }
                            )),
                            const SizedBox(height: TSizes.spaceBetwSections,),
                            Divider(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                  children: [
                                    // Text('REGRAS PARA CANCELAMENTO',style: Theme.of(context).textTheme.bodySmall,),
                                    Text('RULES FOR CANCELLATION',style: Theme.of(context).textTheme.bodyLarge,),
                                    // Text(
                                    //   'Você pode cancelar GRATUITAMENTE até 1 dia(s) antes do horário. Se você cancelar após o horário limite, será cobrada uma taxa de 50% do valor total do agendamento. Se o pagamento for um sinal, ele será a multa.',style: Theme.of(context).textTheme.bodySmall,textAlign: TextAlign.center,),
                            Text(
                                      'You can cancel for FREE up to 1 day(s) before the scheduled time. If you cancel after the cut-off time, you will be charged a fee of 50% of the total booking fee. If the payment is a down payment, it will be the fine.',style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center,),
                            
                                  ],
                                ),
                            ),
                            Divider(),
                               
                    
                                
                              ],
                            ),
                    ),
      
    );
  }
}