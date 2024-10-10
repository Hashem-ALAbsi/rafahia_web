import 'package:flutter/material.dart';
import 'package:rafahia_web/screens/booking/show_booking/details_booking.dart';
import 'package:rafahia_web/screens/home/home_screen.dart';
import 'package:rafahia_web/uitles/colors.dart';
import 'package:sidebarx/sidebarx.dart';

import '../api/helper/api_Permissions.dart';
import '../api/helper/api_massegefirebase.dart';
import '../api/helper/api_token.dart';
import 'account/account-screen.dart';
import 'account/infor_user/update_user.dart';
import 'account/wallet/crate_wallet.dart';
import 'account/wallet/my_wallet.dart';
import 'account/wallet/no_wallet.dart';
import 'account/wallet/transferwallet_screen.dart';
import 'booking/booking_screen.dart';
import 'favoritecompanys/favorite_screen.dart';
import 'maps_screen/map_main_screen.dart';
import 'userclientes/Login/login_screen.dart';
import 'userclientes/welcom_account.dart';

class Nav_barr extends StatefulWidget {
  Nav_barr({Key? key}) : super(key: key);

  @override
  State<Nav_barr> createState() => _Nav_barrState();
}

var checkid;

class _Nav_barrState extends State<Nav_barr> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getIduser();
    permmessag();
    // getTokenFB();
  }

  getIduser() async {
    int id = await ApiToken.getId();
    setState(() {
      checkid = id;
    });
  }

  getTokenFB() async {
    try {
      String? token = await TestMasseging.getTokenFB();
      // await FirebaseMessaging.instance.getToken();
    } catch (er) {
      // print(er);
    }
  }

  permmessag() async {
    await Permissions.permissionmessag();
    // getTokenFB();
    // testtoken();
  }

  final _controller = SidebarXController(selectedIndex: 0, extended: true);

  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        canvasColor: canvasColor,
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            color: Colors.white,
            fontSize: 46,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      home: Builder(
        builder: (context) {
          final isSmallScreen = MediaQuery.of(context).size.width < 600;
          return Scaffold(
            key: _key,
            appBar: isSmallScreen
                ? AppBar(
                    toolbarHeight: 66,
                    backgroundColor: canvasColor,
                    leading: IconButton(
                      onPressed: () {
                        // if (!Platform.isAndroid && !Platform.isIOS) {
                        //   _controller.setExtended(true);
                        // }
                        _key.currentState?.openDrawer();
                      },
                      icon: const Icon(
                        Icons.menu,
                        color: LigthColor.whiteColor,
                      ),
                    ),
                    actions: [Image.asset("assets/images/logo.png")],
                  )
                : null,
            //D:\Rafahia_Flutter\rafahia_web\assets\images\e.png
            drawer: ExampleSidebarX(controller: _controller),
            body: Row(
              children: [
                if (!isSmallScreen) ExampleSidebarX(controller: _controller),
                Expanded(
                  child: Center(
                    child: _ScreensExample(
                      controller: _controller,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ExampleSidebarX extends StatelessWidget {
  const ExampleSidebarX({
    Key? key,
    required SidebarXController controller,
  })  : _controller = controller,
        super(key: key);

  final SidebarXController _controller;

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: _controller,
      theme: SidebarXTheme(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: canvasColor,
          borderRadius: BorderRadius.circular(20),
        ),
        hoverColor: scaffoldBackgroundColor,
        textStyle: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.7)),
        selectedTextStyle:
            const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        hoverTextStyle: const TextStyle(
          color: LigthColor.maingreencolor,
          // color: LigthColor.maingreencolor,
          fontWeight: FontWeight.w500,
        ),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: canvasColor),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: actionColor.withOpacity(0.37),
          ),
          gradient: const LinearGradient(
            colors: [accentCanvasColor, canvasColor],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.28),
              blurRadius: 30,
            )
          ],
        ),
        iconTheme: IconThemeData(
          color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.80),
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          color: accentCanvasColor,
          size: 20,
        ),
      ),
      extendedTheme: const SidebarXTheme(
        width: 200,
        decoration: BoxDecoration(
          color: canvasColor,
        ),
      ),
      footerDivider: divider,
      headerBuilder: (context, extended) {
        return SizedBox(
          height: 150,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset('assets/images/logo.png'),
          ),
        );
      },
      items: [
        SidebarXItem(
          icon: Icons.home,
          label: 'الرئيسية',
        ),
        const SidebarXItem(
          icon: Icons.event,
          label: 'حجوزاتي',
        ),
        const SidebarXItem(
          icon: Icons.map,
          label: 'الخريطة',
        ),
        const SidebarXItem(
          icon: Icons.favorite,
          label: 'المفضلة',
        ),
        const SidebarXItem(
          icon: Icons.person,
          label: 'حسابي',
        ),
      ],
    );
  }

  void _showDisabledAlert(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Item disabled for selecting',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}

class _ScreensExample extends StatelessWidget {
  const _ScreensExample({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SidebarXController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final pageTitle = _getTitleByIndex(controller.selectedIndex);
        switch (controller.selectedIndex) {
          //==================================================home
          case 0:
            return Home_Screen();
          default:
            return Container(
              child: pageTitle,
            );
        }
      },
    );
  }
}

Widget _getTitleByIndex(int index) {
  switch (index) {
    case 1:
      return checkid == 0 ? WelcomeScreen() : Booking_Screen();

    case 2:
      return MapCompanyScreen();
    // Container(
    //   child: Text("map"),
    // );
    case 3:
      return checkid == 0 ? WelcomeScreen() : FovaretScreen();
    // Container(
    //   child: Text("favorit"),
    // );
    case 4:
      return checkid == 0
          ? WelcomeScreen()
          : Account_screen(
              id: checkid,
            );

    default:
      return Container(
        child: Text("0"),
      );
  }
}

const primaryColor = Color(0xFF685BFF);
const canvasColor = Color.fromARGB(255, 58, 93, 121);
const scaffoldBackgroundColor = Color.fromARGB(255, 255, 255, 255);
const accentCanvasColor = Color.fromARGB(255, 213, 230, 240);
const white = Colors.white;
final actionColor = const Color(0xFF5F5FA7).withOpacity(0.6);
final divider = Divider(color: white.withOpacity(0.3), height: 1);
