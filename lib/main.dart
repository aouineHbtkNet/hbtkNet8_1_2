import 'dart:async';
import 'package:simo_v_7_0_1/providers/provider_two.dart';
import 'package:simo_v_7_0_1/providers/provider_one.dart';
import 'package:simo_v_7_0_1/screens/admin_dash_board.dart';
import 'package:simo_v_7_0_1/screens/admin_add_products.dart';
import 'package:simo_v_7_0_1/screens/admin_show_products_edit_delet.dart';
import 'package:simo_v_7_0_1/screens/admin_edit_product.dart';
import 'package:simo_v_7_0_1/screens/register_new_account.dart';
import 'package:simo_v_7_0_1/screens/admin_inventory.dart';
import 'package:simo_v_7_0_1/screens/login_screen.dart';
import 'package:simo_v_7_0_1/widgets_utilities/authContainer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ProviderOne>(create: (_) => ProviderOne()),
      ChangeNotifierProvider<ProviderTwo>(create: (_) => ProviderTwo()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'hHBTKNET',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color:Colors.amberAccent,
        ),
        brightness: Brightness.light,
        primaryColor: Colors.amberAccent,
        primarySwatch: Colors.blue,
      ),


       initialRoute: AdminDashBoard.id ,// ===============> original



      // initialRoute: AddProduct.id ,
      // onGenerateRoute: (parameterthatcarryingdataintheroute){
      //
      // if(parameterthatcarryingdataintheroute.name == DetailsOfProducto.id)// this is the condition to navigate to one route which is here :DetailsOfProducto.id
      //
      //   {
      // var   data =  parameterthatcarryingdataintheroute.arguments ; // puting the data sent in a variable type var named data
      //   return MaterialPageRoute(builder: (context)=>DetailsOfProducto(data: data,));// returning data inside the constructor}// },



      routes: {

        LoginScreen.id: (context) => LoginScreen(),
        AdminAddProduct.id: (context) => AdminAddProduct(),
        AdminDashBoard.id:(context)=>AuthContaner(),
        AdminInventory.id:(context)=>AdminInventory(),
        RegisterNewAccount.id:(context)=>RegisterNewAccount(),
        AdminEditProduct.id:(context)=>AdminEditProduct(),
        AdminShowProductsEditDelete.id:(context)=>AdminShowProductsEditDelete()

      },
    );
  }
}



