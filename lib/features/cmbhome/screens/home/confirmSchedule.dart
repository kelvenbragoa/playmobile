import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:padelmobile/data/repositories/confirmationSchedule.dart';
import 'package:padelmobile/navigation_menu.dart';
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
import 'club_detail.dart';
import 'court_detail.dart';

class ConfirmScheduleScreen extends StatefulWidget {

  ConfirmationSchedule confirmationSchedule2;
  ConfirmScheduleScreen({super.key, required this.confirmationSchedule2});

  @override
  State<ConfirmScheduleScreen> createState() => _ConfirmScheduleScreenState();
}

class _ConfirmScheduleScreenState extends State<ConfirmScheduleScreen> {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lets Play Padel',style: Theme.of(context).textTheme.bodyLarge),
        
      ),
      body: SingleChildScrollView(
        child:Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Iconsax.wallet,size: TSizes.fontSizeLg*3,color: Colors.green,),
              const SizedBox(
                        height: TSizes.spaceBetwSections,
                      ),
              Text(
                "Thank You!",style: Theme.of(context).textTheme.headlineLarge,
              ),
              
              const SizedBox(
                        height: TSizes.spaceBetwSections,
                      ),
              Text(
                "Payment done Successfully",style: Theme.of(context).textTheme.bodyLarge
              ),
              const SizedBox(
                        height: TSizes.spaceBetwSections,
                      ),
              Text(
                "Here is the detail about your appointment:",style: Theme.of(context).textTheme.bodyMedium,textAlign: TextAlign.center,
              ),
              Divider(),
              Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'ID:',
                            style: Theme.of(context).textTheme.bodyLarge,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '#${widget.confirmationSchedule2.id}',
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
                            'Club:',
                            style: Theme.of(context).textTheme.bodyLarge,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '${widget.confirmationSchedule2.clubName}',
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
                            'Nome:',
                            style: Theme.of(context).textTheme.bodyLarge,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '${widget.confirmationSchedule2.firstName} ${widget.confirmationSchedule2.lastName}',
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
                            '${widget.confirmationSchedule2.email}',
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
                            'Quadra:',
                            style: Theme.of(context).textTheme.bodyLarge,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '${widget.confirmationSchedule2.courtName}',
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
                            'Data:',
                            style: Theme.of(context).textTheme.bodyLarge,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '${widget.confirmationSchedule2.date}',
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
                            'Horario:',
                            style: Theme.of(context).textTheme.bodyLarge,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '${widget.confirmationSchedule2.startTime} - ${widget.confirmationSchedule2.endTime}',
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
                            'Preço:',
                            style: Theme.of(context).textTheme.bodyLarge,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '${widget.confirmationSchedule2.price}MT',
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
              Text(
                "You will be redirected to the home page shortly\nor click here to return to home page",style: Theme.of(context).textTheme.bodyMedium,textAlign: TextAlign.center,
              ),
              ElevatedButton(
                                  onPressed: () {
                                   Get.offAll(NavigationMenu());
                                  },
                                  child: const Text('Voltar'),
                                ),
            ],
          ),
        ),
                          ),
                         
           

            
          
        
      
    );
  }
}