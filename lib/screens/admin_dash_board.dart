import 'package:simo_v_7_0_1/widgets_utilities/admin_app_bar.dart';
import 'package:flutter/material.dart';
import 'admin_inventory.dart';




InkWell myItem(
    VoidCallback voidCallback, IconData icon, String heading) {
  return InkWell(
    onTap: voidCallback,
    child: Material(
      color: Colors.white,
      elevation: 14.0,
      shadowColor: Colors.green,
      borderRadius: BorderRadius.circular(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(icon, size: 90.0, color: Colors.amber),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Text(
                  heading,
                  style: TextStyle(fontSize: 20.0,color: Colors.blue,fontWeight: FontWeight.bold),
                )),
          ),


        ],
      ),
    ),
  );
}

class AdminDashBoard extends StatefulWidget {
  static const String id = '/ dashboard';

  @override
  _AdminDashBoardState createState() => _AdminDashBoardState();
}

class _AdminDashBoardState extends State<AdminDashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AdminAppBar(mytext: ''),
        body: Container(
            margin: EdgeInsets.all(10.0),
            child: Center(
              child: GridView.count(
                  primary: true,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  crossAxisSpacing: 20, //vertical  spacing between tiles
                  mainAxisSpacing: 20, //horizontal spacing between tiles
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  children: <Widget>[

                    myItem(() {Navigator.of(context).pushNamed(AdminInventory.id);}, Icons.shop, 'Inventario',),
                    myItem(() {Navigator.of(context).pushNamed(AdminInventory.id);}, Icons.shop, 'Cuentas',),
                    myItem(() {Navigator.of(context).pushNamed(AdminInventory.id);}, Icons.shop, 'Ordenes',),
                    myItem(() {Navigator.of(context).pushNamed(AdminInventory.id);}, Icons.shop, 'Statisticas',),







                  ]),
            )));
  }
}
