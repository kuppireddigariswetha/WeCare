import 'package:WeCare/authentication/view/widgets/dashboard_main.dart';
import 'package:flutter/material.dart';
import 'package:WeCare/authentication/view/widgets/login_class.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SpalshScreen extends StatefulWidget {
  const SpalshScreen({super.key});

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animate();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height*0.15,
              ),
              /// Rotate widget
              Center(
                child: RotatedBox(
                  quarterTurns: 3,
                  child: GestureDetector(
                    onTap: () {
                     // context.pop();
                    },
                    child: Row(
                      children: [
                        Text(
                          'We ',
                          style:  TextStyle(
                              fontFamily: 'Lato',
                              fontSize: 100,
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w100,
                            ),

                        ),
                        Text(
                          'Care ',
                          style:  TextStyle(
                              fontFamily: 'Lato',
                              fontSize: 120,
                            color: Colors.white.withOpacity(0.7),
                              fontWeight: FontWeight.w400,
                            ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void animate() async{
    await Future.delayed(Duration(milliseconds: 2000),(){
    });
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? isLoggedIn = await pref.getString('isLoggedIn');
    print('IsLoggedIn ----- $isLoggedIn');
    await Future.delayed(Duration(milliseconds: 200),(){
    });
    if(isLoggedIn == null){
      Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (c) =>
            LoginPage(title:'' )
        ),
      );
    }else{
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          DashBoardScreen()), (Route<dynamic> route) => false);
    }

  }
}

