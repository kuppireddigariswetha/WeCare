import 'dart:async';
import 'package:WeCare/authentication/model/categories_main_model.dart';
import 'package:WeCare/authentication/view/widgets/profile_view.dart';
import 'package:WeCare/authentication/view/widgets/rich_text.dart';
import 'package:WeCare/authentication/view/widgets/sharing_experience.dart';
import 'package:WeCare/gaming/view/screens/gaming_screen.dart';
import 'package:WeCare/wellness/view/screens/aichat_screen.dart';
import 'package:WeCare/wellness/view/screens/wellness_activities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}
List<MainCategories> mainCategoriesList() {
  List<MainCategories> list = [];
  list.add(MainCategories(img: 'assets/gaming.svg', name: 'EXPRESSIVE GAMIFICATION', color: Colors.blueAccent));
  list.add(MainCategories(img: 'assets/wellbeing.svg', name: 'WELLNESS FOR YOU', color: Colors.orangeAccent));
  list.add(MainCategories(img: 'assets/share.svg', name: 'SET AN EXAMPLE', color: Colors.pinkAccent));
  list.add(MainCategories(img: 'assets/connect.svg', name: 'CONNECT CORNER', color: Colors.cyan));
  return list;
}
Decoration boxDecorationWithRoundedCorners({
  Color backgroundColor = Colors.white,
  BorderRadius? borderRadius,
  LinearGradient? gradient,
  BoxBorder? border,
  List<BoxShadow>? boxShadow,
  DecorationImage? decorationImage,
  BoxShape boxShape = BoxShape.rectangle,
}) {
  return BoxDecoration(
    color: backgroundColor,
    borderRadius:
    boxShape == BoxShape.circle ? null : (borderRadius ?? BorderRadius.all(Radius.circular(20))),
    gradient: gradient,
    border: border,
    boxShadow: boxShadow,
    image: decorationImage,
    shape: boxShape,
  );
}
Decoration boxDecorationRoundedWithShadow(
    int radiusAll, {
      Color backgroundColor = Colors.deepPurple,
      Color? shadowColor,
      double? blurRadius,
      double? spreadRadius,
      Offset offset = const Offset(0.0, 0.0),
      LinearGradient? gradient,
    }) {
  return BoxDecoration(
    boxShadow: defaultBoxShadow(
      shadowColor: shadowColor ?? Colors.grey.withOpacity(0.2),
      blurRadius: blurRadius ?? 4.0,
      spreadRadius: spreadRadius ?? 1.0,
      offset: offset,
    ),
    color: backgroundColor,
    gradient: gradient,
    borderRadius: BorderRadius.all(Radius.circular(20)),
  );
}
List<BoxShadow> defaultBoxShadow({
  Color? shadowColor,
  double? blurRadius,
  double? spreadRadius,
  Offset offset = const Offset(0.0, 0.0),
}) {
  return [
    BoxShadow(
      color: shadowColor ?? Colors.grey.withOpacity(0.2),
      blurRadius: blurRadius ?? 4.0,
      spreadRadius: spreadRadius ?? 1.0,
      offset: offset,
    )
  ];
}
class _DashBoardScreenState extends State<DashBoardScreen> {
  List<MainCategories> mainCategories = mainCategoriesList();
  String getUserName = '';
  String getEmail = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserDetails();
  }
   void getUserDetails() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      getUserName =  pref.getString('userName')??'';
      getEmail =  pref.getString('email')??'';
    });
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.white,
      body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/login_bg.jpg'), fit: BoxFit.cover)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 39, bottom: 25, left: 24, right: 25),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "$getUserName",
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                    fontSize: 20,
                                    color: Colors.black87,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w600,
                                  ),

                              ),
                              Text(
                                "${greetingMessage()}",
                                style: TextStyle(
                                  fontFamily: 'lato',
                                    fontSize: 16,
                                    color: Colors.deepPurple,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w700,
                                  ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.push(context,
                                MaterialPageRoute(builder: (c) =>
                                    ProfileScreen(getEmail,getUserName)
                                ),
                              );
                            },
                            child: Card(
                              elevation: 5,
                                child: CircleAvatar(
                                    child: SvgPicture.asset('assets/profile.svg',height: 30,width: 30,color: Colors.deepPurple,))),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(

                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20),
                      child: Container(// Set a fixed width for the scrolling text// Set a fixed height for the scrolling text
                        child: Text('A calm mind brings inner strength and self-confidence, so that’s very important for good health.',style: TextStyle(color: Colors.black87,fontFamily: 'Lato',
                        fontWeight: FontWeight.w700, fontSize: 16),)
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Main Categories',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Lato',
                          color: Colors.black87
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20),
                      child: StaggeredGridView.countBuilder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        itemCount: mainCategories.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: (){
                              if(index ==2){
                                Navigator.push(context,
                                  MaterialPageRoute(builder: (c) =>
                                      SharingExperience()
                                  ),
                                );
                              }else if(index ==1){
                                Navigator.push(context,
                                  MaterialPageRoute(builder: (c) =>
                                      WellnessActivities()
                                  ),
                                );
                              }else if(index == 3){

                              }if(index == 0){
                                Navigator.push(context,
                                  MaterialPageRoute(builder: (c) =>
                                      GamingWellness()
                                  ),
                                );
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(16),
                              decoration: boxDecorationWithRoundedCorners(
                                backgroundColor: mainCategories[index].color!,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(
                                    mainCategories[index].img!,
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(height: 16,),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width : 100,
                                        child: Text(
                                          mainCategories[index].name.toString(),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(color: Colors.white,fontFamily: 'Lato',fontWeight: FontWeight.w900,fontSize: 12),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                      Icon(Icons.arrow_forward_ios, color: Colors.white, size: 15),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                        mainAxisSpacing: 16.0,
                        crossAxisSpacing: 16.0,
                      ),
                    ),
                   const SizedBox(width: 20),
                    Container(
                      height: 80,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      margin: EdgeInsets.only(bottom: 16, left: 16, right: 16),
                      decoration: boxDecorationRoundedWithShadow(16, backgroundColor: Colors.deepPurple.withOpacity(0.2)),
                      child: Center(
                        child: ListTile(
                          tileColor: Colors.white,
                          enabled: true,
                          contentPadding: EdgeInsets.zero,
                          leading: Container(
                            height: 50,
                            width: 50,
                            alignment: Alignment.center,
                            decoration: boxDecorationWithRoundedCorners(
                              boxShape: BoxShape.circle,
                              backgroundColor: Colors.white,
                            ),
                            child :
                              SvgPicture.asset('assets/chatbot.svg', height: 30,width: 30,
                                color: Colors.black87,),
                          ),
                          title:Text(
                            'Human in the Loop', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w900, fontSize : 12, fontFamily: 'Lato'),
                          ),
                          trailing: InkWell(
                            onTap: (){
                              Navigator.push(context,
                                MaterialPageRoute(builder: (c) =>
                                    AIChatScreen()
                                ),
                              );
                            },
                            child: Container(
                              width: 80,
                              height: 35,
                              alignment: Alignment.center,
                              decoration: boxDecorationWithRoundedCorners(
                                borderRadius: BorderRadius.circular(30),
                                backgroundColor: Colors.white,
                              ),
                              child: Text(
                                'Start',
                                maxLines: 1,
                                style: TextStyle(fontSize: 12, color: Colors.black87, fontFamily: 'Lato'),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),

    );
  }
  String greetingMessage() {
    var timeNow = DateTime.now().hour;
    if (timeNow <= 11.59) {
      return 'Good Morning';
    } else if (timeNow > 12 && timeNow <= 16) {
      return 'Good Afternoon';
    } else if (timeNow > 16 && timeNow < 20) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }
}