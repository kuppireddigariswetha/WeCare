import 'package:WeCare/authentication/view/widgets/dashboard_main.dart';
import 'package:flutter/material.dart';

import '../../model/experience_model.dart';
class SharingExperience extends StatefulWidget {
  const SharingExperience({super.key});

  @override
  State<SharingExperience> createState() => _SharingExperienceState();
}

class _SharingExperienceState extends State<SharingExperience> {
  List<Experience> getSharings = [Experience(question: 'Why do I get sick?', answer: 'When you get sick, part or all of your body is not working as it should. The cause of sickness can come from inside your body or from the outside world'),
    Experience(question: ' Which dimension of wellness relates to having a sense of purpose and inner peace, often achieved through meditation, mindfulness, or religious practices?', answer: 'Spiritual Wellness'),
    Experience(question: ' Adequate financial planning, budgeting, and being financially stable are associated with which dimension of wellness?', answer: 'Financial Wellness'),
    Experience(question: ' Which dimension of wellness involves being aware of and appreciating cultural diversity and inclusivity?', answer: 'Cultural Wellness'),
    Experience(question: ' What is the recommended amount of physical activity for adults, as per the World Health Organization (WHO)?', answer: '2.5 hours per week'),
    Experience(question: ' Which dimension of wellness involves taking care of the environment and practicing sustainable habits?', answer: 'Spiritual Wellness'),
    Experience(question: ' How can individuals promote social wellness?', answer: 'By building strong relationships and support networks')];
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child:  Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/login_bg.jpg'), fit: BoxFit.cover)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              Center(child: Image.asset('assets/wellness.jpeg',)),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Sharing Experiences', style: TextStyle(color: Colors.black87,fontSize: 20,fontFamily: 'Lato',fontWeight: FontWeight.w900),),
                    Card(
                      color: Colors.deepPurple,
                      elevation: 5,
                      child: Container(
                        width: 80,
                        height: 35,
                        alignment: Alignment.center,
                        decoration: boxDecorationWithRoundedCorners(
                          borderRadius: BorderRadius.circular(30),
                          backgroundColor: Colors.deepPurple,
                        ),
                        child: Text(
                          'Post',
                          maxLines: 1,
                          style: TextStyle(fontSize: 12, color: Colors.white, fontFamily: 'Lato'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: getSharings.length,
                    itemBuilder: (context, index){
                       return Padding(
                         padding: const EdgeInsets.only(left: 15,right: 15,top: 8),
                         child: Card(
                           elevation: 2,
                           child: Container(
                             margin: EdgeInsets.all(10),
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.start,
                                   children: [
                                     Text('${index+1}', style: TextStyle(color: Colors.deepPurple,fontFamily: 'Lato',fontSize: 15,fontWeight: FontWeight.w700),),
                                     SizedBox(width: 10,),
                                     Container(
                                       width: MediaQuery.of(context).size.width*0.80,
                                       child: Text('${getSharings[index].question}',
                                           maxLines: 10,
                                           overflow: TextOverflow.ellipsis,
                                           style: TextStyle(color: Colors.black87,fontFamily: 'Lato',fontSize: 14,fontWeight: FontWeight.w900)),
                                     )
                                   ],
                                 ),

                                 Padding(
                                   padding: const EdgeInsets.only(left: 23),
                                   child: Text('${getSharings[index].answer}',style: TextStyle(color: Colors.grey,fontFamily: 'Lato',fontSize: 18,fontWeight: FontWeight.w600)),
                                 )
                               ],
                             ),
                           ),
                         ),
                       );
                    }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
