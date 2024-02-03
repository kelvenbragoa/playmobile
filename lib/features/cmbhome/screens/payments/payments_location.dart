
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../common/custom_shapes/containers/primary_head_container.dart';
import '../../../../data/repositories/payment_model.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper.dart';
import 'widgets/payments_detail_app_bar.dart';


class PaymentsLocationScreen extends StatefulWidget {
  double latitude;
  double longitude;
  PaymentsLocationScreen({super.key, required this.latitude, required this.longitude});

  @override
  State<PaymentsLocationScreen> createState() => _PaymentsLocationScreenState();
}

class _PaymentsLocationScreenState extends State<PaymentsLocationScreen> {
  List<dynamic> _paymentList = [];
  List<dynamic> _paymentListSearch = [];
  TextEditingController controller = TextEditingController(text: '');

  bool _loadingbutton = false;
  late int paymentid;
  bool _loading = true;
  late PaymentModel payment;
  

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-19.8366814, 34.9002648),
    zoom: 14.4746,
  );




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    final LatLng location = LatLng(widget.latitude, widget.longitude);
    var number = NumberFormat.currency(name: 'MZN');
    bool dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TPrimaryHeaderContainer(
              size: 150,
              child: Column(
               children: [
                TPaymentsDetailsAppBar(),
                SizedBox(height: TSizes.spaceBetwSections,),
               ],
              )
            ),
             Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Localização',
                      style: Theme.of(context).textTheme.headlineSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  
                  ],
                ),
            ),
               const SizedBox(
                height: TSizes.spaceBetwItems,
              ),
              Container(
              height: 600,
              
              child: GoogleMap(
                 markers: <Marker>{
                    Marker(
                      draggable: true,
                      markerId: const MarkerId("1"),
                      position: location,
                      icon: BitmapDescriptor.defaultMarker,
                    )
                  },
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
              
              ),
              
              
              // GoogleMap(
              //   mapType: MapType.hybrid,
              //   initialCameraPosition: _kGooglePlex,
              //   onMapCreated: (GoogleMapController controller) {
              //     _controller.complete(controller);
              //   },
              // ),
              

           
                 
         
            
  
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: (){

      //   },
      //   label: const Text('My Location'),
      //   icon: const Icon(Icons.directions_boat),
      // ),
    );
  }

}




