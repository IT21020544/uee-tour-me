import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:tour_me/pages/category_page.dart';
import 'package:tour_me/pages/destination/suggestiontime/tokenvalidation.dart';
import 'package:tour_me/pages/destination/addDestination.dart';
import 'package:tour_me/pages/destination/destination_home.dart';
import 'package:tour_me/pages/details_page.dart';
import 'package:tour_me/pages/journey/view_all_destinations.dart';
import 'package:tour_me/pages/login_page.dart';
import 'package:tour_me/pages/maps/get_map_location.dart';
import 'package:tour_me/pages/palceholder.dart';
import 'package:tour_me/pages/preferences_page.dart';
import 'package:tour_me/pages/register_page.dart';
import 'package:tour_me/pages/souvenir/homePage.dart';
import 'package:tour_me/pages/test_page.dart';
import 'package:tour_me/pages/tourist/favourites_page.dart';
import 'package:tour_me/pages/traveller_create_trip.dart';
import 'package:tour_me/pages/traveller_home.dart';
import 'package:tour_me/pages/welcome_page.dart';
import 'package:tour_me/pages/wishlist.dart';

import 'firebase_options.dart';

void main() async {
  Stripe.publishableKey =
      "pk_test_51O3klFGCqmIXB6lwCavfJNjkN4DaZdy33Q3rraNo1vvvOTvYuuIozLoyMWhIlzhOwxh4K4Fnsj86Q8USrvcHlu5T006AKoawWI";
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: const MaterialColor(
          0xFF171717,
          <int, Color>{
            50: Color(0xFFF2F2F2),
            100: Color(0xFFE6E6E6),
            200: Color(0xFFCCCCCC),
            300: Color(0xFFB3B3B3),
            400: Color(0xFF999999),
            500: Color(0xFF808080),
            600: Color(0xFF666666),
            700: Color(0xFF4D4D4D),
            800: Color(0xFF333333),
            900: Color(0xFF1A1A1A),
          },
        ),
      ),
      initialRoute: WelcomePage.routeName,
      routes: {
        Test.routeName: (context) => const Test(),
        ValidateDestinationToken.routeName: (context) => const ValidateDestinationToken(),
        WelcomePage.routeName: (context) => const WelcomePage(),
        LoginPage.routeName: (context) => const LoginPage(),
        RegisterPage.routeName: (context) => const RegisterPage(),
        CategoryPage.routeName: (context) => const CategoryPage(),
        DetailsPage.routeName: (context) => const DetailsPage(),
        PlaceholderPage.routeName: (context) => const PlaceholderPage(),
        GetMapLocation.routeName: (context) => const GetMapLocation(),
        DestinationHome.routeName: (context) => const DestinationHome(),
        DestinationAddPage.routeName: (context) => const DestinationAddPage(),
        PreferencesPage.routeName: (context) => const PreferencesPage(),
        SouvenirHomePage.routeName: (context) => const SouvenirHomePage(),
        TouristHome.routeName: (context) => const TouristHome(),
        Favourites.routeName: (context) => const Favourites(),
        WishList.routeName: (context) => const WishList(),
        ViewAll.routeName: (context) => const ViewAll(),
        TravelerCreateTrip.routeName: (context) => const TravelerCreateTrip(),
      },
    );
  }
}
