import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:padelmobile/utils/constants/colors.dart';
import 'package:padelmobile/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:padelmobile/utils/constants/text_strings.dart';
import '../../../../data/repositories/api_response.dart';
import '../../../../data/repositories/club_model.dart';
import '../../../../data/services/club_service.dart';
import '../../../../utils/constants/api_constants.dart';
import '../../../../utils/constants/image_strings.dart';
import 'club_detail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> _clubList = [];
  List<dynamic> _clubListSearch = [];
  TextEditingController controller = TextEditingController(text: '');
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

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retrieveAllClubs();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lets Play Padel',style: Theme.of(context).textTheme.bodyLarge),
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
                      
        ) : SingleChildScrollView(
          child: Column(
            children: [
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text('APROVEITE AO MÁXIMO',style: Theme.of(context).textTheme.bodyLarge,)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Flexible(
                      child: Text('Receba notificações de campos disponíveis, dê mais visibilidade aos seus jogos e consulte as suas métricas e desempenho',style: Theme.of(context).textTheme.labelMedium,)
                      ),
                      const Icon(Icons.arrow_forward_ios,size: TSizes.fontSizeMd,)
                  ],
                ),
              ),
              Divider(),
              const SizedBox(height: TSizes.spaceBetwSections,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text('Lembre-se...',style: Theme.of(context).textTheme.bodyLarge,)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:  Card(
                    color: TColors.ligth,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(TSizes.fontSizeMd),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Iconsax.activity),
                                    Container(width: 20),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(height: 5),
                                          const Text(
                                            "Edite as suas preferências de jogabilidade",overflow: TextOverflow.ellipsis,maxLines: 1,
                                          ),
                                          Container(height: 5),
                                          const Text(
                                            "Melhor mão, lado de campo, tipo de jogos preferido",overflow: TextOverflow.ellipsis,maxLines: 1,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Icon(Icons.arrow_forward,size: TSizes.fontSizeMd,)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
              ),
               Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text('Encontre o jogo perfeito',style: Theme.of(context).textTheme.bodyLarge,)
                  ],
                ),
              ),
        
              SizedBox(
                            height: 220,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _clubList.length,
                              itemBuilder: (BuildContext context, int index){
                                ClubModel club = _clubList[index];
                                return InkWell(
                                  onTap: (){
                                    Get.to(ClubDetails(id: club.id, name: club.name,address:club.address, province:club.province, description:club.description, minPrice: club.minPrice,));
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
                                               const ClipRRect(
                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(TSizes.fontSizeMd), topRight: Radius.circular(TSizes.fontSizeMd)),
                                                 child: Image(
                                                  image: AssetImage(TImages.padel ),width: 250, height: 150, fit: BoxFit.fill,),
                                               ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal:8.0),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                  Text(
                                                  club.name,
                                                  style: Theme.of(context).textTheme.bodyMedium,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  club.address,
                                                  style: Theme.of(context).textTheme.bodyMedium,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  club.province,
                                                  style: Theme.of(context).textTheme.bodyMedium,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                ],),
                                              )
                                             
                                            ],
                                          ),
                                                                                
                                        ],
                                      ),
                                    ),
                                );
                              }
                            )),
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
        )
      );
    
  }
}