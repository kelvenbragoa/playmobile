import 'package:flutter/material.dart';

import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class WelcomeHeader extends StatelessWidget {
  const WelcomeHeader({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          height: 150,
          image: AssetImage(dark ? TImages.lightAppLogo : TImages.darkAppLogo)
          ),
          Text(TText.loginTitle, style: Theme.of(context).textTheme.headlineMedium,),
          const SizedBox(height: TSizes.sm,),
          Text(TText.loginSubTitle, style: Theme.of(context).textTheme.bodyMedium,),
          const SizedBox(height: TSizes.sm,),
          Text(TText.loginSubTitle1, style: Theme.of(context).textTheme.bodyMedium,),
      ],
    );
  }
}
