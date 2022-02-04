
import 'package:simo_v_7_0_1/screens/admin_add_products.dart';
import 'package:simo_v_7_0_1/screens/admin_dash_board.dart';
import 'package:simo_v_7_0_1/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthContaner extends StatefulWidget {
  const AuthContaner({Key? key}) : super(key: key);

  @override
  _AuthContanerState createState() => _AuthContanerState();
}


class _AuthContanerState extends State<AuthContaner> {

bool initial =true;
String accessToken ='empty';

  @override
  Widget build(BuildContext context) {
    if (initial) {
      SharedPreferences.getInstance().then((sharedPrefvalue){
        setState(() {
          initial =false;

          accessToken  = sharedPrefvalue.getString('spToken') ?? 'empty';
          print ('  From AuthContainer ===========>  $accessToken');
        });

      });
      return Scaffold(
          body: Center(child: CircularProgressIndicator()));

    }else{

      if( accessToken=='empty')
      { return LoginScreen();}
      else
        { return AdminDashBoard();}

    }

  }
}
