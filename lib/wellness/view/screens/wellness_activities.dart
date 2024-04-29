import 'package:WeCare/wellness/view/screens/mudras_screen.dart';
import 'package:WeCare/wellness/view/screens/yoga_screen.dart';
import 'package:flutter/material.dart';
class WellnessActivities extends StatefulWidget {
  const WellnessActivities({super.key});

  @override
  State<WellnessActivities> createState() => _WellnessActivitiesState();
}

class _WellnessActivitiesState extends State<WellnessActivities> {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: false,
        title: Text("WELLNESS FOR YOU",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900,fontFamily: 'Lato', color: Colors.deepPurple),),
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
            child: Icon(Icons.arrow_back_ios_new_outlined)),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/login_bg.jpg'), fit: BoxFit.cover)),
        child: ListView(
          children: [
            // Padding(
            //   padding: const EdgeInsets.only(left: 10,right: 2,top: 10),
            //   child: Container(// Set a fixed width for the scrolling text// Set a fixed height for the scrolling text
            //       child: Text('Wellness is a holistic concept that involves the integration of physical, mental, and spiritual well-being.',style: TextStyle(color: Colors.black87,fontFamily: 'Lato',
            //           fontWeight: FontWeight.w700, fontSize: 16),)
            //   ),
            // ),
            const SizedBox(height: 10,),
            InkWell(
              onTap: (){
                Navigator.push(context,
                  MaterialPageRoute(builder: (c) =>
                      YogaScreen()
                  ),
                );
              },
              child: Cards(
                image: AssetImage('assets/yoga/yoga.jpg'),
                title: 'YOGA',
              ),
            ),
            const SizedBox(height: 10,),
            Cards(
              image: AssetImage('assets/yoga/healing.jpg'),
              title: 'HEAL WITH MUSIC',
            ),
            const SizedBox(height: 10,),
            InkWell(
              onTap: (){
                Navigator.push(context,
                  MaterialPageRoute(builder: (c) =>
                      MudrasScreen()
                  ),
                );
              },
              child: Cards(
                image: AssetImage('assets/yoga/mudra.jpg'),
                title: 'MUDRAS',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class Cards extends StatelessWidget {
  const Cards({
    super.key,
    required this.title,
    required this.image,
  });

  final String title;

  final ImageProvider image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: image,
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: EdgeInsets.only(left: 25),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-1.00, 0.00),
            end: Alignment(1, 0),
            colors: [
              Color(0xFF3D3D3D),
              Color(0x00262626),
            ],
          ),
        ),
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}