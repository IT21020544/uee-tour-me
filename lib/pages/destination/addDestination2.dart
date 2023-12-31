import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:latlong2/latlong.dart';
import 'package:tour_me/constants.dart';
import 'package:tour_me/pages/destination/addDestination.dart';
import 'package:tour_me/pages/destination/paymentDestination.dart';
import 'package:tour_me/pages/maps/get_map_location.dart';
import 'package:tour_me/widgets/destination_owner_bottom_nav.dart';
import 'package:tour_me/widgets/next_back_button.dart';
import 'package:tour_me/widgets/pink_button.dart';
import 'package:tour_me/widgets/upload_image_button.dart';
import 'package:tour_me/widgets/upload_multiple_images.dart';

class DestinationAddPage2 extends StatefulWidget {
  final String destinationName;
  final String streetNo;
  final String streetName;
  final String city;
  final String weekstartTime;
  final String weekendTime;
  final String weekendstartTime;
  final String weekendendTime;
  final String description;

  const DestinationAddPage2({
    super.key,
    required this.destinationName,
    required this.streetNo,
    required this.streetName,
    required this.city,
    required this.weekstartTime,
    required this.weekendTime,
    required this.weekendstartTime,
    required this.weekendendTime,
    required this.description,
  });

  static const String routeName = '/addDestinationPage2';

  @override
  State<DestinationAddPage2> createState() => _DestinationAddPage2State();
}

class _DestinationAddPage2State extends State<DestinationAddPage2> {
  String retirevedlocation = '';
  final TextEditingController _locationNameController = TextEditingController();
  final TextEditingController _streetNoController = TextEditingController();
  final TextEditingController _streetNameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _weekstartTimeController =
      TextEditingController();
  final TextEditingController _weekendTimeController = TextEditingController();
  final TextEditingController _weekendstartTimeController =
      TextEditingController();
  final TextEditingController _weekendendTimeController =
      TextEditingController();
  final TextEditingController _description = TextEditingController();
  // final TextEditingController _locationController = TextEditingController();
  final TextEditingController _locationImage1 = TextEditingController();
  final TextEditingController _locationImage2 = TextEditingController();

  final CollectionReference _destination =
      FirebaseFirestore.instance.collection('Destination');

  void showImageUploadToast(String? imageUrl, bool success) {
    if (imageUrl != null) {
      Fluttertoast.showToast(
        msg: 'Successfully uploaded image: $imageUrl',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
      );
    } else {
      Fluttertoast.showToast(
        msg: 'Sorry, upload failed.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool imageUploaded = false;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
          leading: Image.asset(MyImages.iconLogo),
          title: const Text('Add Destination', style: TextStyle(fontSize: 25)),
          centerTitle: true,
          backgroundColor: Colors.black,
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white.withOpacity(0.5),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(children: [
                PinkButton(
                  onPress: () async {
                    LatLng? location =
                        await GetMapLocation.getLocation(context);

                    if (location != null) {
                      retirevedlocation =
                          "${location.longitude},${location.latitude}";
                      print('location: $retirevedlocation');
                    }
                  },
                  text: 'Set location through Map',
                ),
                const SizedBox(height: 20),
                UploadImageButton(
                  onPress: () async {
                    List<String> urls = await MultipleImageUpload.save(context);

                    if (urls.isNotEmpty) {
                      _locationImage1.text = urls[0];
                      _locationImage2.text = urls[1];
                      setState(() {
                        imageUploaded = true;
                      });
                      print('urls: ${urls}');
                      print('Image1: ${_locationImage1.text}');
                      print('Image2: ${_locationImage2.text}');
                      print('imageUploaded = $imageUploaded');
                      showImageUploadToast(
                          'Successfully Uploaded Images', true);
                    } else {
                      // Handle the case where no URLs were returned (e.g., upload failure)
                      showImageUploadToast('Failed to Upload Image1s', false);
                    }
                  },
                  text: imageUploaded
                      ? 'Destination Image! uploaded \u2713'
                      : 'Upload Destination Image',
                ),
                NextButton(
                  onPress: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DestinationAddPage(),
                      ),
                    );
                  },
                  text: 'Back',
                ),
                NextButton(
                  onPress: () async {
                    final String destinationName = widget.destinationName;
                    final String streetNo = widget.streetNo;
                    final String streetName = widget.streetName;
                    final String city = widget.city;
                    final String weekstartTime = widget.weekstartTime;
                    final String weekendTime = widget.weekendTime;
                    final String weekendstartTime = widget.weekendstartTime;
                    final String weekendendTime = widget.weekendendTime;
                    final String description = widget.description;
                    final String destinationImage1 = _locationImage1.text;
                    final String destinationImage2 = _locationImage2.text;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DestinationPayment(
                          destinationName: destinationName,
                          streetNo: streetNo,
                          streetName: streetName,
                          city: city,
                          weekstartTime: weekstartTime,
                          weekendTime: weekendTime,
                          weekendstartTime: weekendstartTime,
                          weekendendTime: weekendendTime,
                          description: description,
                          location: retirevedlocation,
                          destinationImage1: destinationImage1,
                          destinationImage2: destinationImage2,
                        ),
                      ),
                    );
                  },
                  text: 'Pay',
                ),
              ]),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
      bottomNavigationBar: const DestinationBottomNav(),
    );
  }
}
