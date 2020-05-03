import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oyw/client/Screens/add_cart.dart';
import 'package:oyw/client/Screens/chat_rider.dart';
import 'package:oyw/client/Screens/country_select.dart';
import 'package:oyw/client/Screens/destination_view.dart';
import 'package:oyw/client/Screens/favorites.dart';
import 'package:oyw/client/Screens/home.dart';
import 'package:oyw/client/Screens/login.dart';
import 'package:oyw/client/Screens/my_rides.dart';
import 'package:oyw/client/Screens/onboarding.dart';
import 'package:oyw/client/Screens/check_user.dart';
import 'package:oyw/client/Screens/otp_verification.dart';
import 'package:oyw/client/Screens/payment.dart';
import 'package:oyw/client/Screens/phone_registration.dart';
import 'package:oyw/client/Screens/profile.dart';
import 'package:oyw/client/Screens/promotions.dart';
import 'package:oyw/client/Screens/register.dart';
import 'package:oyw/client/Screens/suggested_rides.dart';
import 'package:oyw/client/Screens/unauth.dart';
import 'package:oyw/client/Screens/update_favorite.dart';
import 'package:oyw/client/Screens/update_information.dart';

const String OnboardingRoute = "/";
const String RegisterRoute = "register";
const String LoginRoute = "login";
const String PhoneRegisterRoute = "phone-register";
const String OtpVerificationRoute = "otp-verification";
const String UpdateInformationRoute = "update-information";
const String SelectCountryRoute = "country-select";
const String HomepageRoute = "homepage";
const String DestinationRoute = "destination";
const String UnAuthenticatedPageRoute = "unauth";
const String ProfileRoute = "profile";
const String PaymentRoute = "payment";
const String AddCardRoute = "addCard";
const String ChatRiderRoute = "chatRider";
const String FavoritesRoute = "favorite";
const String UpdateFavoritesRoute = "update-favorite";
const String PromotionRoute = "promotion";
const String SuggestedRidesRoute = "suggested-route";
const String MyRidesRoute = "my-rides";
const String CheckUserRoute = "checkUser";


//Router
Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case OnboardingRoute:
      return MaterialPageRoute(builder: (BuildContext context) => Onboarding());
     case CheckUserRoute:
      return MaterialPageRoute(builder: (BuildContext context) => CheckUser());
    case RegisterRoute:
      return MaterialPageRoute(builder: (BuildContext context) => Register());
    case LoginRoute:
      return MaterialPageRoute(builder: (BuildContext context) => Login());
    case PhoneRegisterRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => PhoneRegistration());
    case OtpVerificationRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => OtpVerification());
    case UpdateInformationRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => UpdateInformation());
    case SelectCountryRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => SelectCountry());
    case HomepageRoute:
      return MaterialPageRoute(builder: (BuildContext context) => HomePage());
    case DestinationRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => DestinationView());
    case UnAuthenticatedPageRoute:
      return MaterialPageRoute(builder: (BuildContext context) => UnAuth());
    case ProfileRoute:
      return MaterialPageRoute(builder: (BuildContext context) => Profile());
    case PaymentRoute:
      return MaterialPageRoute(builder: (BuildContext context) => Payment());
    case AddCardRoute:
      return MaterialPageRoute(builder: (BuildContext context) => AddCard());
    case ChatRiderRoute:
      return MaterialPageRoute(builder: (BuildContext context) => ChatRider());
    case FavoritesRoute:
      return MaterialPageRoute(builder: (BuildContext context) => Favorites());
    case PromotionRoute:
      return MaterialPageRoute(builder: (BuildContext context) => Promotions());
    case UpdateFavoritesRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => UpdateFavorite());
    case SuggestedRidesRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => SuggestedRides());
    case MyRidesRoute:
      return MaterialPageRoute(builder: (BuildContext context) => MyRides());
    default:
      return MaterialPageRoute(builder: (BuildContext context) => Onboarding());
  }
}

class Homepage {}
