import 'package:flutter/material.dart';
import 'package:pharmacy_app/src/pages/consult_pharmacist_page.dart';
import 'package:pharmacy_app/src/pages/initial_tutorial_scrolling_page.dart';
import 'package:pharmacy_app/src/pages/login_page.dart';
import 'package:pharmacy_app/src/pages/main_page.dart';
import 'package:pharmacy_app/src/pages/no_internet_page.dart';
import 'package:pharmacy_app/src/pages/referral_link_page.dart';
import 'package:pharmacy_app/src/pages/splash_page.dart';
import 'package:pharmacy_app/src/pages/verification_page.dart';

typedef RouterMethod = PageRoute Function(RouteSettings, Map<String, String>);

/*
* Page builder methods
*
*/
final Map<String, RouterMethod> _definitions = {
  '/': (settings, _) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) {
        return SplashPage();
      },
    );
  },
  '/noInternet': (settings, _) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) {
        return NoInternetPage();
      },
    );
  },
  '/initial_tutorial_page': (settings, _) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) {
        return InitialTutorialScrollingPage();
      },
    );
  },
  '/login': (settings, _) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) {
        return LoginPage();
      },
    );
  },
  '/main': (settings, params) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) {
        return MainPage();
      },
    );
  },
  '/verification_page': (settings, _) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) {
        return VerificationPage();
      },
    );
  },
  '/consult_pharmacist': (settings, _) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) {
        return ConsultPharmacistPage();
      },
    );
  },
  '/refer_a_friend': (settings, _) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) {
        return ReferralLinkPage();
      },
    );
  },
};

Map<String, String> _buildParams(String key, String name) {
  final uri = Uri.parse(key);
  final path = uri.pathSegments;
  final params = Map<String, String>.from(uri.queryParameters);

  final instance = Uri.parse(name).pathSegments;
  if (instance.length != path.length) {
    return null;
  }

  for (int i = 0; i < instance.length; ++i) {
    if (path[i] == '*') {
      break;
    } else if (path[i][0] == ':') {
      params[path[i].substring(1)] = instance[i];
    } else if (path[i] != instance[i]) {
      return null;
    }
  }
  return params;
}

Route buildRouter(RouteSettings settings) {
  for (final entry in _definitions.entries) {
    final params = _buildParams(entry.key, settings.name);
    if (params != null) {
      print('Visiting: ${settings.name} as ${entry.key}');
      return entry.value(settings, params);
    }
  }

  print('<!> Not recognized: ${settings.name}');
  return FadeInRoute(
    settings: settings,
    builder: (_) {
      return Scaffold(
        body: Center(
          child: Text(
            '"${settings.name}"\nYou should not be here!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.grey[600],
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      );
    },
  );
}

class FadeInRoute<T> extends MaterialPageRoute<T> {
  bool disableAnimation;

  FadeInRoute({
    WidgetBuilder builder,
    RouteSettings settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
    this.disableAnimation = false,
  }) : super(
          settings: settings,
          builder: builder,
          maintainState: maintainState,
          fullscreenDialog: fullscreenDialog,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (this.disableAnimation) return child;
    return FadeTransition(opacity: animation, child: child);
  }
}

/*

* Navigating System *

Navigator.of(context).pushNamed('/book_valet');

Navigator.of(context).pushNamedAndRemoveUntil(
         '/', (Route<dynamic> route) => false);

Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BookingDetailsPage(
                      singleBookingData: singleBookingData,
                      bookingDataList: bookingDataList,
                    )),
          );
 */
