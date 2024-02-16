import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:padelmobile/data/repositories/confirmationSchedule.dart';
import 'package:padelmobile/data/repositories/myschedule.dart';
import 'package:printing/printing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../common/custom_shapes/containers/primary_head_container.dart';
import '../../../../data/repositories/api_response.dart';
import '../../../../data/repositories/payment_model.dart';
import '../../../../data/services/payment_service.dart';
import '../../../../utils/constants/api_constants.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper.dart';
import 'widgets/payments_detail_app_bar.dart';


class MyScheduleDetailsScreen extends StatefulWidget {
  int id;
  MyScheduleDetailsScreen({super.key, required this.id});

  @override
  State<MyScheduleDetailsScreen> createState() => _MyScheduleDetailsScreenState();
}

class _MyScheduleDetailsScreenState extends State<MyScheduleDetailsScreen> {
    List<dynamic> _myScheduleList = [];
  List<dynamic> _myScheduleListSearch = [];
  TextEditingController controller = TextEditingController(text: '');




  bool _loadingbutton = false;
  late int paymentid;
  bool _loading = true;
  late ConfirmationSchedule confirmationSchedule2;
 

  
 Future<void> retrieveSchedule()async{

    ApiResponse response = await getMySchedule(widget.id);

    setState(() {
      paymentid = widget.id;
    }); 

 
  
      setState(() {
        _myScheduleList = response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
      });
      confirmationSchedule2 = _myScheduleList[0];
     
     
   
    if(response.error == null){
      setState(() {
        _myScheduleList = response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
        
      });
      confirmationSchedule2 = _myScheduleList[0];
    
    }
    else if(response.error == APIConstants.serverError){
      // logout().then((value)  {
      //   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>LoginPage()), (route) => false);
      // });
    }
    else{
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}')));
    } 

  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retrieveSchedule();
  }

  @override
  Widget build(BuildContext context){
    var number = NumberFormat.currency(name: 'MZN');
    bool dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
       appBar: AppBar(
        title: Text('My Schedules',style: Theme.of(context).textTheme.bodyLarge),
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
      body: _loading ? const Center(
          child: Padding(
              
              padding: EdgeInsets.all(8),
            
                        child: Center(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CupertinoActivityIndicator(
                              // backgroundColor: TColors.primary,
                              color: TColors.primary,
        
                            ),
                            Text(TText.pleaseWait)
                            
                          ],
                        )))
                      
        ) : 
                 SingleChildScrollView(
                   child: Column(
                    children: [
                       
                        Padding(
                        padding: EdgeInsets.all(8.0),
                        child:  Center(
                          child: Image(image: AssetImage(dark ? TImages.lightAppLogo : TImages.darkAppLogo),height: 50, width: 50,)
                        ),
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
                              '#${confirmationSchedule2.id}',
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
                              '${confirmationSchedule2.clubName}',
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
                              '${confirmationSchedule2.firstName} ${confirmationSchedule2.lastName}',
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
                              '${confirmationSchedule2.email}',
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
                              '${confirmationSchedule2.courtName}',
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
                              '${confirmationSchedule2.date}',
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
                              '${confirmationSchedule2.startTime} - ${confirmationSchedule2.endTime}',
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
                              '${confirmationSchedule2.price}MT',
                              style: Theme.of(context).textTheme.bodyMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Center(
                                 child: SizedBox(
                    height: 100,
                    child: SfBarcodeGenerator(
                        value: '${confirmationSchedule2.id}',
                        symbology: QRCode(),
                      ),
                                 ),
                               ),
                        
                      //         Center(
                      //   child: Column(
                      //     mainAxisSize: MainAxisSize.min,
                      //     children: [
                      //       ElevatedButton(
                      //         onPressed: (){
                      //           _createPdf(confirmationSchedule2);
                      //         },
                      //         child: const Text('Imprimir',),
                      //       ),
                      //       const SizedBox(height: 20,),
                            
                      //     ],
                      //   ),
                      // ),
                 
                        
                         
                          
                    ],
                                 ),
                 )
         
            
  
          
        );
      
    
  }

    /// create PDF & print it
  Future<void> _createPdf(ConfirmationSchedule schedule) async {
    
    final doc = pw.Document();

    final image = await imageFromAssetBundle(TImages.darkAppLogo);
    /// for using an image from assets
    // final image = await imageFromAssetBundle('assets/image.png');
    
    var number = NumberFormat.currency(name: 'MZN');
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.roll80,
        build: (pw.Context context) {
          return pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [

            pw.Padding(
              padding: const pw.EdgeInsets.all(8),
              child: pw.Container(
              
            child: pw.Image(image,height: 50, width: 50,),
              )
            ),
            pw.Align(
                  alignment: pw.Alignment.center,
                  child: pw.Padding(
                  padding: pw.EdgeInsets.all(8.0),
                        child: pw.Text('MUNICIPIO DA BEIRA',style: pw.TextStyle(fontSize: 16,fontWeight: pw.FontWeight.bold),),
                  ),
              ),
              pw.Align(
                  alignment: pw.Alignment.topCenter,
                  child: pw.Padding(
                  padding: pw.EdgeInsets.all(8.0),
                        child: pw.Text('CONSELHO',style: pw.TextStyle(fontSize: 16,fontWeight: pw.FontWeight.bold),),
                  ),
              ),
            pw.Align(
                  alignment: pw.Alignment.topCenter,
                  child: pw.Padding(
                  padding: pw.EdgeInsets.all(8.0),
                        child: pw.Text('MUNICIPAL DA BEIRA',style: pw.TextStyle(fontSize: 16,fontWeight: pw.FontWeight.bold),),
                  ),
              ),
            // pw.Padding(
            //   padding: const pw.EdgeInsets.all(8),
            //   child: pw.Center(
            // child: pw.Text('MUNICIPIO DA BEIRA',style:  pw.TextStyle(fontSize: 16,fontWeight: pw.FontWeight.bold),),
            //   )
            // ),
            // pw.Padding(
            //   padding: const pw.EdgeInsets.all(8),
            //   child: pw.Center(
            // child: pw.Text('CONSELHO MUNICIPAL DA BEIRA',style:  pw.TextStyle(fontSize: 16,fontWeight: pw.FontWeight.bold),),
            //   )
            // ),
             pw.Divider(),
             pw.Padding(
              padding: const pw.EdgeInsets.all(8),
              child: pw.Center(
            child: pw.Text('**Nuit: 500005688**',style:  pw.TextStyle(fontSize: 12)),
              )
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(8),
              child: pw.Center(
            child: pw.Text(' **Data: ${DateFormat('MMM d, HH:mm ').format(DateTime.parse(schedule.endTime))}**',style:  pw.TextStyle(fontSize: 12)),
              )
            ),
             pw.Padding(
              padding: const pw.EdgeInsets.all(8),
              child: pw.Center(
            child: pw.Text('**Criado por: ${schedule.clubName} ${schedule.courtName}**',style:  pw.TextStyle(fontSize: 12)),
              )
            ),
            pw.Divider(),
            pw.Align(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Padding(
                  padding: pw.EdgeInsets.all(8.0),
                        child: pw.Text('Nome: ${schedule.date}',style: const pw.TextStyle(fontSize: 12),),
                  ),
              ),
              pw.Align(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Padding(
                  padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('Dados: ${schedule.obs}',style: const pw.TextStyle(fontSize: 12),),
                  ),
              ),
            pw.Align(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Padding(
                  padding: pw.EdgeInsets.all(8.0),
                        child: pw.Text('Descrição: ${schedule.date}',style: const pw.TextStyle(fontSize: 12),),
                  ),
              ),

            // pw.Align(
            //       alignment: pw.Alignment.centerLeft,
            //       child: pw.Padding(
            //       padding: pw.EdgeInsets.all(8.0),
            //             child: pw.Text('Valor: ${number.format(double.parse(schedule.amount.toString()))}',style: const pw.TextStyle(fontSize: 12),),
            //       ),
            //   ),
              pw.Divider(),
            
             pw.Center(
                        child: pw.Text('**Obrigado**',style: pw.TextStyle(fontSize: 16)),
                    ),
            pw.Center(
                child: pw.SizedBox(
                  child: pw. BarcodeWidget(
                    barcode: pw.Barcode.qrCode(
                      errorCorrectLevel: pw.BarcodeQRCorrectionLevel.high,
                    ),
                    data: '${schedule.id}',
                    width: 100,
                    height: 100,
                  ),
                 
                )
              ),
               pw.SizedBox(height: 5),
              pw.Center(
                child: pw.Text('Beira, Moçambique',style: pw.TextStyle(fontSize: 12)),
              ),
              // pw.Center(
              //   child: pw.Text('+258 842648618',style: pw.TextStyle(fontSize: 12)),
              // ),
              pw.SizedBox(height: 50),
              pw.Center(
                child: pw.Text('***************',style: pw.TextStyle(fontSize: 16)),
              ),


          ]);
        },
      ),
    ); // Page

    /// print the document using the iOS or Android print service:
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => doc.save());

    /// share the document to other applications:
    // await Printing.sharePdf(bytes: await doc.save(), filename: 'my-document.pdf');

    /// tutorial for using path_provider: https://www.youtube.com/watch?v=fJtFDrjEvE8
    /// save PDF with Flutter library "path_provider":
    // final output = await getTemporaryDirectory();
    // final file = File('${output.path}/example.pdf');
    // await file.writeAsBytes(await doc.save());
  }
}




