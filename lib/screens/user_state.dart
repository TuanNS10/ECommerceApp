import 'package:ecommerce_app/screens/landing_page.dart';
import 'package:ecommerce_app/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserState extends StatelessWidget {
  const UserState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, userSnapshot){
          if(userSnapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }else if(userSnapshot.connectionState == ConnectionState.active){
            if(userSnapshot.hasData){
              print('The user is already logged on');
              return MainScreen();
            }else{
              print('The user didn\'t login yet');
              return LandingPage();
            }
          }else
            return Center(
              child: Text('Error occurred'),
            );

        });
  }
}
