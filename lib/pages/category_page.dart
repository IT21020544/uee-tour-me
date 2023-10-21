import 'package:flutter/material.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';
import 'package:tour_me/constants.dart';
import 'package:tour_me/pages/details_page.dart';
import 'package:tour_me/pages/palceholder.dart';
import 'package:tour_me/utils/upload_user_details.dart';
import 'package:tour_me/widgets/loading_popup.dart';
import 'package:tour_me/widgets/message_popup.dart';

class CategoryPage extends StatelessWidget {
  static const String routeName = '/category';
  const CategoryPage({super.key});

  void _onSelect(BuildContext context, String userRole) async {
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    pref.putString(MyPrefTags.userRole, userRole, isEncrypted: true);

    if (userRole == MyStrings.traveler) {
      //TODO: navigate to traveller preferecnes page
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          PlaceholderPage.routeName,
          (route) => false,
        );
      }
    } else if (context.mounted) {
      LoadingPopup().display(context, message: 'Please Wait...');

      bool success = false;
      try {
        success = await uploadUserDetails(context);
      } catch (e, trace) {
        print("Error: $e");
        print("StackTrace: $trace");
      }
      LoadingPopup().remove();

      if (!success) {
        if (context.mounted) MessagePopUp.display(context);
      }
    }

    if (userRole == MyStrings.host) {
      //TODO: navigate to host dashboard
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          PlaceholderPage.routeName,
          (route) => false,
        );
      }
    } else if (userRole == MyStrings.merchant) {
      //TODO: navigate to merchant dashboard
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          PlaceholderPage.routeName,
          (route) => false,
        );
      }
    } else {
      if (context.mounted) {
        MessagePopUp.display(
          context,
          onDismiss: () {
            pref.clearAll();
            Navigator.pushNamedAndRemoveUntil(
              context,
              DetailsPage.routeName,
              (route) => false,
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Select Category'),
      ),
      body: Column(children: [
        // Traveller
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => _onSelect(context, MyStrings.traveler),
            child: ListTile(
              leading: Image.asset(MyImages.traveler),
              title: const Text(
                'Traveler',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: MyColors.pink,
                ),
              ),
              contentPadding: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(
                  color: MyColors.pink,
                  width: 2.5,
                ),
              ),
            ),
          ),
        ),
        // Location Host
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => _onSelect(context, MyStrings.host),
            child: ListTile(
              leading: Image.asset(MyImages.location),
              title: const Text(
                'Location Hosts',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: MyColors.pink,
                ),
              ),
              contentPadding: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(
                  color: MyColors.pink,
                  width: 2.5,
                ),
              ),
            ),
          ),
        ),
        // Merchants
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => _onSelect(context, MyStrings.merchant),
            child: ListTile(
              leading: Image.asset(MyImages.merchant),
              title: const Text(
                'Merchants',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: MyColors.pink,
                ),
              ),
              contentPadding: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(
                  color: MyColors.pink,
                  width: 2.5,
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
