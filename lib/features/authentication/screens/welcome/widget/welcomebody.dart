import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../data/repositories/api_response.dart';
import '../../../../../data/repositories/user.dart';
import '../../../../../data/services/user_services.dart';
import '../../../../../navigation_menu.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../forgetpassword/forget.dart';
import '../../login/login.dart';
import '../../signup/signup.dart';



class WelcomeBody extends StatefulWidget {
   const WelcomeBody({
    super.key,
  });

  @override
  State<WelcomeBody> createState() => _WelcomeBodyState();
}

class _WelcomeBodyState extends State<WelcomeBody> {
  bool loading = false;

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController(text: '');

  final TextEditingController _passwordController = TextEditingController(text: '');



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
    return Form(
      key: _key,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBetwSections),
        child: Column(
          
          children: [
            // TextFormField(
            //   keyboardType: TextInputType.emailAddress,
            //   controller: _emailController,
            //   decoration: const InputDecoration(
            //     prefixIcon: Icon(Iconsax.direct_right),
            //     labelText: TText.email
            //   ),
            //    validator: (value){
            //                   if(value == null || value.isEmpty){
            //                     return TText.requiredField;
            //                     }
            //                   return null;
            //                   },
            // ),
            // const SizedBox(height: TSizes.spaceBetwInputFields,),
            // TextFormField(
            //   keyboardType: TextInputType.text,
            //   controller: _passwordController,
            //   obscureText: true,
            //   decoration: const InputDecoration(
            //     prefixIcon: Icon(Iconsax.password_check),
            //     labelText: TText.password,
            //     suffixIcon: Icon(Iconsax.eye_slash),
            //   ),
            //    validator: (value){
            //                   if(value == null || value.isEmpty){
            //                     return TText.requiredField;
            //                     }
            //                   return null;
            //                   },
            // ),
            const SizedBox(height: TSizes.spaceBetwInputFields/2,),
      
            //REMEMBER ME AND FORGET PASSWORD
      
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     //Remember me
            //     Checkbox(value: true, onChanged: (value){
      
            //     }),
            //     const Text(TText.rememberMe)
            //   ],
            // ),
            // TextButton(
            //   onPressed: (){
            //     Get.to(const ForgetScreen());
            //   },
            //   child: const Text(TText.forgetPassword),
            // ),
      
            const SizedBox(height: TSizes.spaceBetwSections/3,),
      
            
            const SizedBox(height: TSizes.spaceBetwItems,),
             loading ? Container() :SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (){
                  Get.to( SignUpScreen());
                }, 
                child: const Text(TText.signUp)
                ),
            ),
            const SizedBox(height: TSizes.spaceBetwSections,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style:ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent
                ),
                onPressed: (){
                 Get.to(LoginScreen());
                }, 
                child: const Text(TText.signIn)
                ),
            ),
      
          ],
        ),
      ),
      );
  }
}