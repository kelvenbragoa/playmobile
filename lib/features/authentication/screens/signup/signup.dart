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
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper.dart';
import '../../../cmbhome/screens/home/home2.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool loading = false;

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final TextEditingController _firstNameController =
      TextEditingController(text: '');

  final TextEditingController _lastNameController =
      TextEditingController(text: '');

  final TextEditingController _emailController =
      TextEditingController(text: '');

  final TextEditingController _mobileController =
      TextEditingController(text: '');

  final TextEditingController _passwordController =
      TextEditingController(text: '');

  final TextEditingController _genderController =
      TextEditingController(text: '');
  final TextEditingController _dateController =
      TextEditingController(text: '');

  final Uri toLaunchURL =
      Uri(scheme: 'http', host: 'inovatis.co.mz', path: 'privacy.php');
  var items = ['Male', 'Female'];

  Future<void> _launchInWebView(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.platformDefault)) {
      throw Exception('Could not launch $url');
    }
  }
  

  Future<void> _login() async {
    ApiResponse response = await UserService().registerUser(
        _firstNameController.text,
        _lastNameController.text,
        _emailController.text,
        _mobileController.text,
        _passwordController.text,
        _genderController.text,
        _dateController.text);

    if (response.error == null) {
      _saveAndRedirectToHome(response.data as UserData);
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  void _saveAndRedirectToHome(UserData user) async {
    setState(() {
      UserService.userProfile = user;
    });


    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setInt('id', user.id);
    await pref.setString('firstName', user.firstName);
    await pref.setString('lastName', user.lastName);
    await pref.setString('email', user.email);
    await pref.setString('mobile', user.mobile);
    // await pref.setInt('start_app_lp', int.parse(user.lpStartTimeStamp.toString()));
    // await pref.setInt('end_app_lp', int.parse(user.lpEndTimeStamp.toString()));
    // await pref.setInt('start_app_pro', int.parse(user.proStartTimeStamp.toString()));
    // await pref.setInt('end_app_pro', int.parse(user.proEndTimeStamp.toString()));
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomePage()));

    Get.offAll(const HomeScreen());
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
                  TText.signUpTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: TSizes.spaceBetwSections,
                ),
                Form(
                    key: _key,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                controller: _firstNameController,
                                expands: false,
                                decoration: const InputDecoration(
                                    labelText: TText.firstName,
                                    prefixIcon: Icon(Iconsax.user)),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return TText.requiredField;
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              width: TSizes.spaceBetwInputFields,
                            ),
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                controller: _lastNameController,
                                expands: false,
                                decoration: const InputDecoration(
                                    labelText: TText.lastName,
                                    prefixIcon: Icon(Iconsax.user)),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return TText.requiredField;
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: TSizes.spaceBetwInputFields,
                        ),

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

                        //birth date
                        TextFormField(
                          keyboardType: TextInputType.datetime,
                          controller: _dateController,
                          decoration: const InputDecoration(
                              labelText: TText.birthDate,
                              prefixIcon: Icon(Iconsax.calendar)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return TText.requiredField;
                            }
                            return null;
                          },
                          onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context, initialDate: DateTime.now(),
                                  firstDate: DateTime(1930), //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2101)
                              );
                              
                              if(pickedDate != null ){
                                  // print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); 
                                  // print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                    //you can implement different kind of Date Format here according to your requirement

                                  setState(() {
                                    _dateController.text = formattedDate; //set output date to TextField value. 
                                  });
                              }else{
                                  // print("Date is not selected");
                              }
                            },
                        ),

                        const SizedBox(
                          height: TSizes.spaceBetwInputFields,
                        ),

                        //gender
                        Row(
                        children: <Widget>[
                           Expanded(
                            child:  TextFormField(
                              controller: _genderController,
                              readOnly: true,
                              validator: (value) {
                              if (value == null || value.isEmpty) {
                                return TText.requiredField;
                              }
                              return null;
                            },
                              )
                          ),
                        PopupMenuButton<String>(
                        icon: const Icon(Icons.arrow_drop_down),
                        onSelected: (String value) {
                          _genderController.text = value;
                        },
                        itemBuilder: (BuildContext context) {
                          return items.map<PopupMenuItem<String>>((String value) {
                            return  PopupMenuItem(child: new Text(value), value: value);
                          }).toList();},
                      )]),
                        const SizedBox(
                          height: TSizes.spaceBetwInputFields,
                        ),
                        //phone number
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          controller: _mobileController,
                          decoration: const InputDecoration(
                              labelText: TText.phoneNumber,
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

                        //termos e condicoes

                        Row(
                          children: [
                            SizedBox(
                              width: 24,
                              height: 24,
                              child:
                                  Checkbox(value: true, onChanged: (value) {}),
                            ),
                            const SizedBox(
                              width: TSizes.spaceBetwItems,
                            ),
                            Flexible(
                              child: GestureDetector(
                                onTap: () {
                                  _launchInWebView(toLaunchURL);
                                },
                                child: Text.rich(TextSpan(children: [
                                  TextSpan(
                                      text: '${TText.iAgreeTo} ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                  TextSpan(
                                      text: '${TText.privacyPolicy} ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .apply(
                                            color: dark
                                                ? TColors.white
                                                : TColors.primary,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor: dark
                                                ? TColors.white
                                                : TColors.primary,
                                          )),
                                  TextSpan(
                                      text: '${TText.and} ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                  TextSpan(
                                      text: '${TText.termsOfUse} ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .apply(
                                            color: dark
                                                ? TColors.white
                                                : TColors.primary,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor: dark
                                                ? TColors.white
                                                : TColors.primary,
                                          )),
                                ])),
                              ),
                            ),
                          ],
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
                                  child: const Text(TText.createAccount),
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
