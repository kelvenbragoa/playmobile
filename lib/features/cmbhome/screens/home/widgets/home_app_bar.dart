import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../../../../../common/widgets/appbar.dart';
import '../../../../../data/services/user_services.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/helpers/helper.dart';

class THomeAppBar extends StatelessWidget {
   const THomeAppBar({
    super.key,
  });
  

  @override
  Widget build(BuildContext context) {
    bool dark = THelperFunctions.isDarkMode(context);
    DateTime date = DateTime.now();

    return TAppBar(
      title: Column(
        children: [
          Text(TText.homeAppBarTitle, style: Theme.of(context).textTheme.labelMedium!.apply(color: TColors.grey),),
          // Text(DateFormat('EEEE').format(date), style: Theme.of(context).textTheme.labelMedium!.apply(color: TColors.grey),),
          Text('${UserService.userProfile.firstName} ${UserService.userProfile.lastName}', style: Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.white),)
        ],
      ),
      // actions: [
      //   Image(image: AssetImage(dark ? TImages.lightAppLogo : TImages.darkAppLogo))
      //   // IconButton(
      //   //     onPressed: (){}, 
      //   //     icon: const Icon(Iconsax.shopping_bag,color: TColors.white,))
      // ],
    );
  }
}
