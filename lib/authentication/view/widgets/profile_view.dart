import 'package:WeCare/authentication/model/user_model.dart';
import 'package:WeCare/authentication/view/widgets/dashboard_main.dart';
import 'package:WeCare/authentication/view/widgets/login_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ProfileScreen extends StatefulWidget {
  final String email;
  final String userName;
  const ProfileScreen( this.email, this.userName,
      {super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String email = '';
  String phoneNumber ='';
  String hobbies = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email = widget.email;
    getUserDetails();
  }
  void getUserDetails(){
    var userBox = Hive.box<User>('userDetailsBox');
    var loggedInUser = userBox.get(email);
    phoneNumber = loggedInUser!.mobileNumber;
    hobbies = loggedInUser.hobbies;
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.zero),
                  shape: BoxShape.rectangle,
                  color: Colors.deepPurple.withOpacity(0.2),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20),
                      child: Align(alignment: Alignment.topLeft,
                          child: InkWell(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.arrow_back_ios))),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(child: SvgPicture.asset('assets/account.svg'), radius: 40.0, ),
                        SizedBox(height: 8,),
                        Text('${widget.userName}', style: TextStyle(color: Colors.black87, fontSize: 24,fontFamily: 'Lato',fontWeight: FontWeight.w900)),
                        SizedBox(height: 4,),
                        Text('$email', style: TextStyle(color: Colors.black87, fontSize: 16,fontFamily: 'Lato',fontWeight: FontWeight.w900)),
                      ],
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: boxDecorationWithRoundedCorners(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(32)),
                  backgroundColor: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 16.0),
                      padding: EdgeInsets.all(12.0),
                      decoration: boxDecorationRoundedWithShadow(8, backgroundColor: Colors.deepPurple.withOpacity(0.2)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: InkWell(
                          onTap: (){

                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.phone_android_rounded, size: 30, color: Colors.blue),
                                  SizedBox(width: 8,),
                                  Text('$phoneNumber', style:TextStyle(color: Colors.black87,fontSize: 20,fontWeight: FontWeight.w900,fontFamily: 'Lato')),
                                ],
                              ),
                            ],
                          ),

                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5,right: 5),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(bottom: 16.0),
                        padding: EdgeInsets.all(20.0),
                        decoration: boxDecorationRoundedWithShadow(8, backgroundColor: Colors.deepPurple.withOpacity(0.2)),
                        child: Column(
                          crossAxisAlignment : CrossAxisAlignment.start,
                          mainAxisAlignment : MainAxisAlignment.start,
                          children: [
                            Text('HOBBIES : ',style: TextStyle(fontWeight: FontWeight.w900, fontFamily: 'Lato',fontSize:20),),
                            SizedBox(height: 10,),
                            Text('$hobbies', style:TextStyle(color: Colors.black87,fontSize: 20,fontWeight: FontWeight.w400,fontFamily: 'Lato')),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 16.0),
                      padding: EdgeInsets.all(12.0),
                      decoration: boxDecorationRoundedWithShadow(8, backgroundColor: Colors.deepPurple.withOpacity(0.2)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: InkWell(
                          onTap: ()async{
                            var settingsBox = await Hive.openBox('mailBox');
                            await settingsBox
                                .delete('loggedInUser');
                            SharedPreferences pref = await SharedPreferences.getInstance();
                            await pref.remove('isLoggedIn');
                            await pref.remove('email');
                            await pref.remove('userName');
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                LoginPage(title: 'WeCare')), (Route<dynamic> route) => false);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.logout_rounded, size: 30, color: Colors.blue),
                                  SizedBox(width: 8,),
                                  Text('LOGOUT', style:TextStyle(color: Colors.black87,fontSize: 20,fontWeight: FontWeight.w900,fontFamily: 'Lato')),
                                ],
                              ),
                              Icon(Icons.arrow_forward_ios, color: Colors.black87, size: 16),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}
