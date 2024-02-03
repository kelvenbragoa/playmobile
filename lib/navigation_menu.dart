import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'features/cmbhome/screens/fees/fees.dart';
import 'features/cmbhome/screens/home/home.dart';
import 'features/cmbhome/screens/payments/payments.dart';
import 'features/cmbhome/screens/profile/profile.dart';
import 'utils/constants/colors.dart';
import 'utils/helpers/helper.dart';

class NavigationMenu extends StatefulWidget {

   const NavigationMenu({super.key,});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: Obx(
        ()=> NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          backgroundColor: darkMode ? TColors.black : TColors.white,
          indicatorColor: darkMode ? TColors.white.withOpacity(0.1):TColors.black.withOpacity(0.1),
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(icon: Icon(Iconsax.message), label: 'Community'),
            NavigationDestination(icon: Icon(Iconsax.calendar), label: 'MySchedules'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ]),
      ),
        body: Obx(()=>controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController{
  final Rx<int> selectedIndex = 0.obs;
  final screens = [
                    const HomeScreen(),
                    const FeesScreen(),
                    const PaymentsScreen(),
                    const ProfileScreen()];
}