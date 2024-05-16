import 'package:WeCare/gaming/model/gaming_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class GamingActivities extends StatefulWidget {
  const GamingActivities({super.key});

  @override
  State<GamingActivities> createState() => _GamingActivitiesState();
}
List<GamingModel> gamesList() {
  List<GamingModel> list = [];
  list.add(GamingModel(title: 'Fitness Bingo', description: 'Create bingo cards with various fitness activities like "take the stairs instead of the elevator" or "do 20 squats." Employees mark off squares as they complete activities, aiming to get a bingo or blackout.', ratings: '4.5'));
  list.add(GamingModel(title: 'Mindfulness Meditation Sessions', description: 'Schedule regular mindfulness meditation sessions for employees to unwind and de-stress. You can incorporate guided meditation apps or bring in a professional instructor.', ratings: '5.0'));
  list.add(GamingModel(title: 'Step Challenges', description: 'Encourage employees to track their steps using fitness trackers or apps. Set up challenges where individuals or teams compete to reach a certain number of steps each day or week.', ratings: '4.8'));
  list.add(GamingModel(title: 'Office Olympics', description: 'Organize a day of fun, active challenges in the office or outdoors. Include events like sack races, tug-of-war, or relay races to get everyone moving and laughing.', ratings: '4.3'));
  list.add(GamingModel(title: 'Wellness Trivia', description: 'Test employees knowledge on health and wellness topics with a trivia game. Cover areas like nutrition, exercise, stress management, and mental health', ratings: '4.6'));
  list.add(GamingModel(title: 'Water Intake Challenge', description: 'Encourage employees to drink more water by tracking their daily intake. Set goals and reward those who consistently meet or exceed them', ratings: '5.0'));
  list.add(GamingModel(title: 'Fitness Class Discounts', description: 'Partner with local gyms or fitness studios to offer discounted or free fitness classes to employees. Encourage participation by organizing group outings.', ratings: '3.8'));
  list.add(GamingModel(title: 'Nature Walks', description: 'Arrange group walks during lunch breaks or after work in nearby parks or nature trails. Its a great way to get some fresh air and exercise while bonding with coworkers', ratings: '4.6'));
  list.add(GamingModel(title: 'Wellness Wheel', description: 'Create a spinning wheel with various wellness activities or challenges. Employees can spin the wheel and complete the corresponding task, whether its a short yoga session, a quick stretch break, or a gratitude journaling exercise', ratings: '4.0'));
  list.add(GamingModel(title: 'Healthy Recipe Cook-Off', description: 'Host a cooking competition where employees prepare and share their favorite healthy recipes. You could even have different categories like appetizers, main courses, and desserts.', ratings: '3.5'));
  return list;
}
class _GamingActivitiesState extends State<GamingActivities> {
  List<GamingModel> mainGames = gamesList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: false,
        title: Text("GAMES & ACTIVITES",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900,fontFamily: 'Lato', color: Colors.deepPurple),),
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Icon(Icons.games_outlined),
                    SizedBox(width: 10,),
                    Text(
                      'RECOMMENDED',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w900,
                      ),
                    )
                  ],
                ),
              ),
              ...List.generate(
                gamesList().length,
                    (index) => Container(
                  padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
                  decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 1,
                          color: Color(0xFFD0D0D0),
                        ),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset('assets/games-w.svg',height: 35,width: 35,),
                               SizedBox(width: 8,),
                                Text(
                                  '${gamesList()[index].title}',
                                  style: TextStyle(
                                    color: Colors.deepPurpleAccent.withOpacity(0.7),
                                    fontSize: 16,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4,),
                            Text(
                              '${gamesList()[index].description}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 8,),
                            Text(
                              'Ratings · ${gamesList()[index].ratings}',
                              style: TextStyle(
                                color: Colors.orangeAccent,
                                fontSize: 12,

                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 8,),
                      // Container(
                      //   width: 80,
                      //   height: 80,
                      //   decoration: BoxDecoration(color: Color(0xFF525252)),
                      // ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
