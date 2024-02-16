import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:padelmobile/data/repositories/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../data/repositories/api_response.dart';
import '../../../../data/services/user_services.dart';
import '../../../../navigation_menu.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper.dart';
import '../../../cmbhome/screens/home/home2.dart';
import '../forgetpassword/forget.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;

  final GlobalKey<FormState> _key = GlobalKey<FormState>();





  final TextEditingController _emailController =
      TextEditingController(text: '');

 

  final TextEditingController _passwordController =
      TextEditingController(text: '');



   Future<void> _login() async {
  
    ApiResponse response = await UserService().loginUser(
      _emailController.text,
      _passwordController.text); 

    

        
    if(response.error == null){
      _saveAndRedirectToHome(response.data as UserData);
    }else{
       setState(() {
              loading = false;
            });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}')
        ));
    }
  }
  
    void _saveAndRedirectToHome(UserData user) async{
  
    setState(() {
      UserService.userProfile = user;
    });

    
    
    SharedPreferences pref = await SharedPreferences.getInstance();
        await pref.setInt('id', user.id);
        await pref.setString('firstName', user.firstName);
        await pref.setString('lastName', user.lastName);
        await pref.setString('email', user.email);
        await pref.setString('mobile', user.mobile);
        // await pref.setString('code', user.code);

        // await pref.setString('today', user.today.toString());
        // await pref.setString('yesterday', user.yesterday.toString());
        // await pref.setString('month', user.month.toString());
        // await pref.setString('year', user.year.toString());
       
    
    // await pref.setInt('start_app_lp', int.parse(user.lpStartTimeStamp));
    // await pref.setInt('end_app_lp', int.parse(user.lpEndTimeStamp));
    // await pref.setInt('start_app_pro', int.parse(user.proStartTimeStamp));
    // await pref.setInt('end_app_pro', int.parse(user.proEndTimeStamp));
    

    

    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomePage()));
    Get.offAll(const NavigationMenu());
  }

  





  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: dark ? Colors.white : Colors.black, //change your color here
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  TText.signInTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: TSizes.spaceBetwSections,
                ),
                Form(
                    key: _key,
                    child: Column(
                      children: [
                        //email
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          decoration: const InputDecoration(
                              labelText: TText.email,
                              prefixIcon: Icon(Iconsax.direct)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return TText.requiredField;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: TSizes.spaceBetwInputFields,
                        ),

                        //password
                        const SizedBox(
                          height: TSizes.spaceBetwInputFields,
                        ),

                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                              labelText: TText.password,
                              prefixIcon: Icon(Iconsax.password_check),
                              suffixIcon: Icon(Iconsax.eye_slash)),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 6) {
                              return TText.requiredField +
                                  TText.passwordCharacter;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: TSizes.spaceBetwSections,
                        ),
                        TextButton(
                                      onPressed: (){
                                        Get.to(const ForgetScreen());
                                      },
                                      child: const Text(TText.forgetPassword),
                                    ),
                   
                        const SizedBox(
                          height: TSizes.spaceBetwSections,
                        ),
                        loading
                            ? const SizedBox(
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    CupertinoActivityIndicator(
                                    color: TColors.primary,
                                    ),
                                    Text(TText.pleaseWait)
                                    
                                  ],
                                ))
                            : SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_key.currentState!.validate()) {
                                      _key.currentState!.save();
                                      setState(() {
                                        loading = true;
                                      });
                                      _login();
                                    }
                                  },
                                  child: const Text(TText.signIn),
                                ),
                              )

                        //
                      ],
                    ))
              ],
            )),
      ),
    );
  }
}
