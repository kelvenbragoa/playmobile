import 'package:flutter/material.dart';
import 'package:padelmobile/features/authentication/screens/login2/widget/loginform.dart';
import 'package:padelmobile/features/authentication/screens/login2/widget/loginheader.dart';
import 'package:padelmobile/features/authentication/screens/welcome/widget/welcomebody.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../common/styles/spacing_styles.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helpers/helper.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
   final Uri toLaunchURL =
        Uri(scheme: 'http', host: 'google.com',path: 'search');

    Future<void> _launchInWebView(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.platformDefault)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {

    final dark = THelperFunctions.isDarkMode(context);
    final now = DateTime.now();
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration:  BoxDecoration(
            image: DecorationImage(
              // colorFilter: ColorFilter.mode(Colors.black, BlendMode.lighten),
              image: AssetImage(dark ? TImages.darkWelcomeImage : TImages.lightWelcomeImage),
              fit: BoxFit.fill
              )
          ),
          child: Padding(
            padding: TSpacingStyles.paddingWithAppBarHeight,
            child: Column(
              children: [
                //LOGO TITLE AND SUBTITLE
                LoginHeader(dark: dark),
        
        
                //FORM
        
                const WelcomeBody(),
                const Spacer(),
                GestureDetector(
                  onTap: (){
                                _launchInWebView(toLaunchURL);
                              },
                  child: Wrap(
                    children: [
                       
                              Text.rich(
                               
                                TextSpan(
                                  children:[
                                    TextSpan(text: 'By registering you accept our ',style: Theme.of(context).textTheme.bodySmall),
                                
                                    TextSpan(text: 'terms and conditions',style: Theme.of(context).textTheme.bodySmall!.apply(
                                      color: dark ? TColors.white : TColors.primary,
                                      decoration: TextDecoration.underline,
                                      decorationColor: dark ? TColors.white : TColors.primary,
                                    )),
                                    TextSpan(text: ' of use of the application',style: Theme.of(context).textTheme.bodySmall),
                                    
                                  ] )),
                      // Text('By registering you accept our terms and conditions of use of the application',style: const TextStyle(fontSize: 10))
                    ],
                  ),
                ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    
                    children: [
                      Flexible(child: Divider(color: dark ? TColors.darkGrey : TColors.grey, thickness: 0.5, indent: 60, endIndent: 5,)),
                      Text('${now.year} \u00a9 LetsPlay',style: const TextStyle(fontSize: 10),),
                      Flexible(child: Divider(color: dark ? TColors.darkGrey : TColors.grey, thickness: 0.5, indent: 5, endIndent: 60,))
                    ],
                  )
              ],
            ),
        
          ),
        ),
      ),
    );
  }
}

