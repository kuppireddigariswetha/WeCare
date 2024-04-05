import 'package:WeCare/authentication/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:WeCare/authentication/view/widgets/dashboard_main.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();
  final _signFormKey = GlobalKey<FormState>();
  int selectedPage = 0;
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final mobileNumber = TextEditingController();
  final hobbies = TextEditingController();
  final emailLogin = TextEditingController();
  final passwordLogin = TextEditingController();
  final String emailPattern =
      r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
// Regex pattern for validating mobile number
  final String mobilePattern = r'^(?:[+0]9)?[0-9]{10}$';

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    } else if (!RegExp(emailPattern).hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mobile number cannot be empty';
    } else if (!RegExp(mobilePattern).hasMatch(value)) {
      return 'Enter a valid mobile number';
    }
    return null;
  }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/login_bg.jpg'), fit: BoxFit.cover)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       const Text('We', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, fontFamily: 'Lato',color: Colors.deepPurple),),
                       const Text('Care', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, fontFamily: 'Lato',fontStyle: FontStyle.italic,color: Colors.deepPurple),),
                     ],
                   ),
                    SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: (){
                            setState(() {
                              selectedPage = 0;
                              email.text = '';
                              firstName.text = '';
                              lastName.text = '';
                              password.text = '';
                              mobileNumber.text ='';
                              hobbies.text = '';
                            });
                          },
                            child: Text('Login', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, fontFamily: 'Lato',color: selectedPage == 0?Colors.black87:Colors.grey))),
                        InkWell(
                            onTap: (){
                              setState(() {
                                selectedPage = 1;
                                emailLogin.text = '';
                                passwordLogin.text = '';
                              });
                            },
                            child: Text('Signup', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, fontFamily: 'Lato',color: selectedPage == 1?Colors.black87:Colors.grey)))
                      ],
                    ),
                  AnimatedCrossFade(firstChild: Form(
                    key: _loginFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20,),
                        TextFormField(
                          controller: emailLogin,
                          decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, fontFamily: 'Lato',),
                              hintText: 'Email',
                              hintStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, fontFamily: 'Lato',color: Colors.grey),
                              border: OutlineInputBorder(),
                          ),
                          validator: (value){
                            return validateEmail(value);
                          },
                        ),
                        const SizedBox(height: 20,),
                        TextFormField(
                          controller: passwordLogin,
                          decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, fontFamily: 'Lato',),
                              hintText: 'Emter you password',
                              hintStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, fontFamily: 'Lato',color: Colors.grey),
                              border: OutlineInputBorder(),
                          ),
                          obscureText: true,
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return 'Please Enter Password';
                            }
                          },
                        ),

                        const SizedBox(height: 20,),
                        Center(
                          child: Container(
                            height: MediaQuery.of(context).size.height*0.06,
                            width: MediaQuery.of(context).size.width*0.70,
                            child: ElevatedButton(onPressed: () async{
                          final isValidated =  _loginFormKey.currentState!.validate();
                            if(isValidated) {
                              var userBox = Hive.box<User>('userDetailsBox');
                              var user = userBox.get(emailLogin.text);
                              if (user != null && user.password == passwordLogin.text) {
                                var settingsBox = await Hive.openBox('mailBox');
                                var userBox = Hive.box<User>('userDetailsBox');
                                var loggedInUser = userBox.get(emailLogin.text);
                                await settingsBox.put('loggedInUser', loggedInUser!.email);
                                SharedPreferences pref = await SharedPreferences.getInstance();
                                await pref.setString('isLoggedIn', 'Yes');
                                await pref.setString('email', loggedInUser.email);
                                await pref.setString('userName', '${loggedInUser.firstName + ' '} ${loggedInUser.lastName}');
                                // Navigate to home page with the user's first name as a route argument
                                await Future.delayed(Duration(milliseconds: 200));
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) => AnimatedDialog(),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Incorrect username or password')),
                                );
                              }
                             }

                            },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Color(0xff5008B5).withOpacity(0.6)), // Transparent background
                                  elevation: MaterialStateProperty.all(6), // No elevation
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),),
                                child: Text('LOGIN',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, fontFamily: 'Lato',color: Colors.white))),
                          ),
                        )
                      ],
                    ),
                  ), secondChild: Form(
                    key: _signFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20,),
                        TextFormField(
                          controller: firstName,
                          decoration: InputDecoration(
                              labelText: 'First Name',
                              labelStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, fontFamily: 'Lato',),
                              hintText: 'Enter your first name',
                              hintStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, fontFamily: 'Lato',color: Colors.grey),
                              border: OutlineInputBorder(),
                          ),
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return 'Please Enter Email Id';
                            }
                          },
                        ),
                        const SizedBox(height: 10,),
                        TextFormField(
                          controller: lastName,
                          decoration: InputDecoration(
                              labelText: 'Last Name',
                              labelStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, fontFamily: 'Lato',),
                              hintText: 'Enter your lastname',
                              hintStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, fontFamily: 'Lato',color: Colors.grey),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return 'Please Enter Email Id';
                            }
                          },
                        ),
                        const SizedBox(height: 10,),
                        TextFormField(
                          controller: email,
                          decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, fontFamily: 'Lato',),
                              hintText: 'Email',
                              hintStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, fontFamily: 'Lato',color: Colors.grey),
                              border: OutlineInputBorder(),
                          ),
                          validator: (value){
                           return validateEmail(value);
                          },
                        ),
                        const SizedBox(height: 10,),
                        TextFormField(
                          controller: password,
                          decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, fontFamily: 'Lato',),
                              hintText: 'Create your password',
                              hintStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, fontFamily: 'Lato',color: Colors.grey),
                              border: OutlineInputBorder(),
                          ),
                          obscureText: true,
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return 'Please Enter Password';
                            }else if(value.length<8){
                              return 'Password must be atleast 8 characters';
                            }
                          },
                        ),

                        const  SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding:  EdgeInsets.only(left: 5),
                          child: Text('Password may be atleast 8 characters ',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, fontFamily: 'Lato',color: selectedPage == 1?Colors.black87:Colors.grey),),
                        ),
                        const SizedBox(height: 10,),
                        TextFormField(
                          controller: mobileNumber,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              labelText: 'Mobile Number',
                              labelStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, fontFamily: 'Lato',),
                              hintText: 'Enter your mobile number',
                              hintStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, fontFamily: 'Lato',color: Colors.grey),
                              border: OutlineInputBorder(),
                          ),
                          validator: (value){
                           return validateMobile(value);
                          },
                        ),

                        const SizedBox(height: 10,),
                        TextFormField(
                          controller: hobbies,
                          decoration: InputDecoration(
                              labelText: 'Hobbies',
                              labelStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 14
                                , fontFamily: 'Lato',),
                              hintText: 'Only Hobbies',
                              hintStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, fontFamily: 'Lato',color: Colors.grey),
                              border: OutlineInputBorder(),
                          ),
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return 'Please Enter your Hobbies';
                            }
                          },
                        ),
                        const SizedBox(height: 10,),
                        Center(
                          child: Container(
                            height: MediaQuery.of(context).size.height*0.06,
                            width: MediaQuery.of(context).size.width*0.70,
                            child: ElevatedButton(onPressed: () async{
                             final isValidated =  _signFormKey.currentState!.validate();
                             if(isValidated) {
                               var box = Hive.box<User>('userDetailsBox');
                               var user = User(
                                 email: email.text,
                                 firstName: firstName.text,
                                 lastName: lastName.text,
                                 password: password.text,
                                 mobileNumber: mobileNumber.text,
                                 hobbies: hobbies.text,
                               );
                               await box.put(user.email, user);
                               var settingsBox = await Hive.openBox('mailBox');
                               await settingsBox.put('loggedInUser', user.email);
                               var savedUser = box.get(user.email);
                               if (savedUser != null) {
                                 ScaffoldMessenger.of(context).showSnackBar(
                                   SnackBar(content: Text('Details Saved : Please Login')),
                                 );
                                 email.text = '';
                                 firstName.text = '';
                                 lastName.text = '';
                                 password.text = '';
                                 mobileNumber.text ='';
                                 hobbies.text = '';
                                 await Future.delayed(Duration(milliseconds: 500));
                                 setState(() {
                                 selectedPage = 0;
                                 });
                               } else {
                                 ScaffoldMessenger.of(context).showSnackBar(
                                   SnackBar(content: Text('Failed to save user')),
                                 );
                               }
                             }else{
                               final snackBar = SnackBar(content: Text('Please Fill All the fileds'));
                               ScaffoldMessenger.of(context).showSnackBar(snackBar);
                             }
                            },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Color(0xff5008B5).withOpacity(0.6)), // Transparent background
                                  elevation: MaterialStateProperty.all(6), // No elevation
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),),
                                child: Text('SIGNUP',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, fontFamily: 'Lato',color: Colors.white))),
                          ),
                        )
                      ],
                    ),
                  ), crossFadeState: selectedPage == 0?CrossFadeState.showFirst:CrossFadeState.showSecond, duration: Duration(milliseconds: 300)),
                  ],
                ),
              ),
            ),
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
class AnimatedDialog extends StatefulWidget {
  @override
  _AnimatedDialogState createState() => _AnimatedDialogState();
}

class _AnimatedDialogState extends State<AnimatedDialog> {
  int optionSelected = -1;
  String selectedFeeling = '';
  List<Feel> feels = [
    Feel(name: "Happy", mood: "😊"),
    Feel(name: "Sad", mood: "😥"),
    Feel(name: "Angry",mood: "😡"),
    Feel(name: "Confusion", mood: "🫤"),
    Feel(name: "Depression", mood: "🫥")
  ];
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [ // Your animated content goes here
                SizedBox(height: 20.0),
                Text(
                  'How do you feel today?',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0),
                SizedBox(
                  height: 74,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    scrollDirection: Axis.horizontal,
                    itemCount: feels.length,
                    itemBuilder: (c, index) {
                      return InkWell(
                        onTap: () async{
                          setState(() {
                            optionSelected = index;
                            selectedFeeling = feels[optionSelected].name;

                          });
                          if(optionSelected == -1 && selectedFeeling.isEmpty){

                          }else{
                            SharedPreferences pref = await SharedPreferences.getInstance();
                            await pref.setString('Feeling', selectedFeeling);
                            await Future.delayed(Duration(milliseconds: 500));
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                DashBoardScreen()), (Route<dynamic> route) => false);
                          }
                        },
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                width: 50,
                                height: 50,
                                color: index == optionSelected
                                  ?getSelectedFeelingColor(selectedFeeling):Colors.deepPurple.withOpacity(0.2),
                                child: Center(
                                  child: Text(
                                    feels[index].mood,
                                    style: TextStyle(fontSize: 28),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              feels[index].name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontFamily: "Lato",
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w400,
                                ),

                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: 42,
                      );
                    },
                  ),
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Color? getSelectedFeelingColor(String feeling){
    print('The Colorrrrrr is $feeling');
    if(feeling == 'Happy'){
      return Color(0xffF8D664).withOpacity(0.8);
    }else if(feeling == 'Sad'){
      return Colors.grey.withOpacity(0.8);
    }else if(feeling == 'Confusion'){
      return Color(0xffab6969);
    }else if(feeling == 'Angry'){
      return Colors.red.withOpacity(0.8);
    }
    else if(feeling == 'Depression'){
      return Color(0xff13273e).withOpacity(0.8);
    }
    return Colors.deepPurple;
  }
}
class Feel {
  late final String name;
  late final String mood;
  Feel({required this.name, required this.mood});
}