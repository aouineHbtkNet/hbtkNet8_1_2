
import 'package:simo_v_7_0_1/providers/provider_one.dart';
import 'package:simo_v_7_0_1/screens/admin_add_products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'admin_show_products_edit_delet.dart';




// widget to be reused to create items in the grid view ===This widget will be moved to a file of functions


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
            child: Icon(icon, size: 50.0, color: Colors.amber),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              heading,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0,color: Colors.blue,),
            ),
          ),


        ],
      ),
    ),
  );
}


class AdminInventory extends StatelessWidget {
  static const String id = '/admininventory';
  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<ProviderOne>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '',
            style: TextStyle(fontFamily: 'OpenSans'),
          ),
          centerTitle: true,
        ),
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



                    myItem(() {Navigator.pushNamed(context, AdminAddProduct.id,);}, Icons.add, 'anadir un producto nuevo  ',),
                    myItem(() {Navigator.pushNamed(context, AdminShowProductsEditDelete.id);}, Icons.more_horiz_outlined, 'Editar y borrar productos',),
                    myItem(() {}, Icons.assessment_rounded, 'Estadísticas',),



                  ]
              ),
            )
        )
    );
  }
}
