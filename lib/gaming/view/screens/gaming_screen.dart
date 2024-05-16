import 'package:WeCare/gaming/view/screens/activities_screen.dart';
import 'package:flutter/material.dart';
class GamingWellness extends StatefulWidget {
  const GamingWellness({super.key});

  @override
  State<GamingWellness> createState() => _GamingWellnessState();
}

class _GamingWellnessState extends State<GamingWellness> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: false,
        title: Text("EXPRESSIVE GAMIFICATION",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900,fontFamily: 'Lato', color: Colors.deepPurple),),
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

              },
              child: Cards(
                image: AssetImage('assets/yoga/healing.jpg'),
                title: 'HEALING WITH MUSIC',
              ),
            ),
            const SizedBox(height: 10,),
            InkWell(
              onTap: (){
                Navigator.push(context,
                  MaterialPageRoute(builder: (c) =>
                      GamingActivities()
                  ),
                );
              },
              child: Cards(
                image: AssetImage('assets/yoga/games-fit.jpg'),
                title: 'GAMES',
              ),
            ),
            const SizedBox(height: 10,),
            InkWell(
              onTap: (){
              },
              child: Cards(
                image: AssetImage('assets/yoga/mandala.jpg'),
                title: 'MANDALA',
              ),
            ),
            const SizedBox(height: 10,),
            InkWell(
              onTap: (){
              },
              child: Cards(
                image: AssetImage('assets/yoga/events.jpg'),
                title: 'EVENTS / WORKSHOPS',
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
          fit: BoxFit.fill,
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
