import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:padelmobile/features/cmbhome/screens/profile/widgets/form_menu.dart';
import 'package:padelmobile/features/cmbhome/screens/wallet/wallet.dart';
import 'package:padelmobile/utils/constants/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../common/custom_shapes/containers/primary_head_container.dart';
import '../../../../data/services/user_services.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../authentication/screens/onboarding/onboarding.dart';
import '../wallet/transactions.dart';
import 'widgets/profile_app_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  
    final Uri toLaunchURL =
      Uri(scheme: 'http', host: 'inovatis.co.mz', path: 'privacy.php');
  var items = ['Male', 'Female'];

  Future<void> _launchInWebView(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.platformDefault)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
       appBar: AppBar(
        title: Text('Perfil',style: Theme.of(context).textTheme.bodyLarge),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      minRadius: 30,
                      maxRadius: 45,
                      backgroundColor: TColors.black,
                      child: Text('${UserService.userProfile.firstName[0].capitalize} ${UserService.userProfile.lastName[0].capitalize}',style: TextStyle(color: TColors.white,fontSize: 24),),
                    ),
                    SizedBox(width: TSizes.defaultSpace,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children: [
                        Text(
                      '${UserService.userProfile.firstName} ${UserService.userProfile.lastName}',
                      style: Theme.of(context).textTheme.headlineSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(UserService.userProfile.email, style: Theme.of(context).textTheme.labelSmall)
                      ],
                    )
                  ],
            
                ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Iconsax.user),
                    Text(
                      'Informação Perfil',
                      style: Theme.of(context).textTheme.headlineSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
            
                ),
            ),
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
                            UserService.userProfile.email,
                            style: Theme.of(context).textTheme.bodyMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Mobile:',
                            style: Theme.of(context).textTheme.bodyLarge,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            UserService.userProfile.mobile,
                            style: Theme.of(context).textTheme.bodyMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Birth Date:',
                            style: Theme.of(context).textTheme.bodyLarge,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            UserService.userProfile.birthDate,
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
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Iconsax.wallet),
                    Text(
                      'Wallet',
                      style: Theme.of(context).textTheme.headlineSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
            
                ),
            ),
            Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: (){
                          Get.to(WalletScreen(),transition: Transition.downToUp);
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                                color: TColors.softGrey,
                                borderRadius: BorderRadius.circular(12)
                              ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Balance:',
                                style: Theme.of(context).textTheme.bodyLarge,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Icon(Icons.arrow_forward_ios,size: TSizes.fontSizeMd,)
                            ],
                          ),
                        ),
                      ),
                    ),
                Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: (){
                          Get.to(TransactionScreen(),transition: Transition.downToUp);
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                                color: TColors.softGrey,
                                borderRadius: BorderRadius.circular(12)
                              ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Transactions',
                                style: Theme.of(context).textTheme.bodyLarge,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Icon(Icons.arrow_forward_ios,size: TSizes.fontSizeMd,)
                            ],
                          ),
                        ),
                      ),
                    ),
                    Divider(),
                     Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Iconsax.document),
                    Text(
                      'Legal Information',
                      style: Theme.of(context).textTheme.headlineSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
            
                ),
            ),
             Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: (){
                          _launchInWebView(toLaunchURL);
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                                color: TColors.softGrey,
                                borderRadius: BorderRadius.circular(12)
                              ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Privacy Policy',
                                style: Theme.of(context).textTheme.bodyLarge,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Icon(Icons.arrow_forward_ios,size: TSizes.fontSizeMd,)
                            ],
                          ),
                        ),
                      ),
                    ),

              Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: (){
                          _launchInWebView(toLaunchURL);
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                                color: TColors.softGrey,
                                borderRadius: BorderRadius.circular(12)
                              ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Terms of Use',
                                style: Theme.of(context).textTheme.bodyLarge,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Icon(Icons.arrow_forward_ios,size: TSizes.fontSizeMd,)
                            ],
                          ),
                        ),
                      ),
                    ),


              SizedBox(
                height: TSizes.spaceBetwItems,
              ),

              InkWell(
                onTap: (){
                   showDialog(context: context , builder: (BuildContext context)=>AlertDialog(
                            title: const Text(TText.logOutButton),
                            content: Text(TText.logOutInfo),
                            actions: [
                              TextButton(
                                onPressed: ()async{
                                  SharedPreferences pref = await SharedPreferences.getInstance();
                                  pref.remove('id');
                                  pref.remove('email');
                                  pref.remove('firstName');
                                  pref.remove('lastName');
                                  pref.remove('mobile');
                                  pref.remove('birthDate');
                                  
                                  Get.offAll(const OnBoardingScreen());
                            
                              }, 
                              child: const Text(TText.yes)),

                              TextButton(onPressed: (){Navigator.pop(context);}, child: const Text(TText.no))
                            ],
                          ));
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(TText.logOutButton),
                    Icon(Iconsax.logout)
                  ],
              
                ),
              ),
         
            
  
          ],
        ),
      ),
    );
  }
}




