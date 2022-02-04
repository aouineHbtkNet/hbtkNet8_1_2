import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simo_v_7_0_1/modals/admin_login_response_model.dart';
import 'package:simo_v_7_0_1/providers/provider_one.dart';
import 'package:simo_v_7_0_1/screens/admin_dash_board.dart';
import 'package:simo_v_7_0_1/screens/register_new_account.dart';
import 'package:simo_v_7_0_1/widgets_utilities/admin_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String id = '/ login';
  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}


class _LoginScreenState extends State {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKeyForLoginScreen = GlobalKey<FormState>();
   String error='';
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderOne>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
                key:_formKeyForLoginScreen,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [

                    SizedBox(height: 20,),
                    Text('Ingresar a mi cuenta', style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey),),
                    SizedBox(height: 40,),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress, textInputAction: TextInputAction.done,
                       controller: _emailController,
                      validator: (value) {if (value == null || value.trim().isEmpty) {return 'Este campo es obligatorio';}
                      else if (value.isEmpty || !value.contains('@')) {return "Entrada invalida.Ex:example@example.com";}
                      else {return null;}},
                      decoration: InputDecoration(hintText: 'Email', label: Text('Email',
                        style: TextStyle(fontSize: 20, color: Colors.blue),),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),),),
                    SizedBox(height: 8,),
                    TextFormField(
                      obscureText: true,
                      keyboardType: TextInputType.text, textInputAction: TextInputAction.done,
                      controller: _passwordController,
                      validator: (value) {if (value == null || value.trim().isEmpty) {return 'Este campo es obligatorio';}
                      else {return null;}},
                      decoration: InputDecoration(hintText: 'Password', label: Text('Password',
                        style: TextStyle(fontSize: 20, color: Colors.blue),),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),),),
                    SizedBox(height: 40,),

                    ElevatedButton(
                      onPressed:() async{
                        if(_formKeyForLoginScreen.currentState!.validate()) {

                          AdminLoginResponse adminLoginResponse = AdminLoginResponse();
                          adminLoginResponse = await ProviderOne().loginInForAdmins(_emailController.text, _passwordController.text);
                          await provider.addTokenToSPA(adminLoginResponse.token);
                          await provider.addUserIdToSPA(adminLoginResponse.id);
                          await provider.addUserNameToSPA(adminLoginResponse.name);
                          await provider.addUserEmailToSPA(adminLoginResponse.email);

                          Navigator.pushNamed(context, AdminDashBoard.id);

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Container(
                              height: 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('Hola ${adminLoginResponse.name}',style: TextStyle(fontSize: 16.0,color: Colors.black),),
                                  Text(adminLoginResponse.message,style: TextStyle(fontSize: 16.0,color: Colors.black),),
                                ],
                              ),
                            ),
                            duration: Duration(milliseconds: 8000),
                            backgroundColor: Colors.amberAccent,
                            padding: EdgeInsets.all(10),
                            elevation: 20,));

                        }
                        },



                        style: ElevatedButton.styleFrom(primary: Colors.amber,),

                       child: Text('Enviar ', style: TextStyle(fontSize: 24)),),
                    SizedBox(height: 40,),

                    ElevatedButton(
                      onPressed:() async{Navigator.pushNamed(context, RegisterNewAccount.id);},
                      style: ElevatedButton.styleFrom(primary: Colors.amber,),
                      child: Text('Crear una cuenta nueva ', style: TextStyle(fontSize: 24 ,),),
                    ),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }

  }


