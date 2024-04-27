import 'package:WeCare/wellness/model/mudras_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class MudrasScreen extends StatefulWidget {
  const MudrasScreen({super.key});

  @override
  State<MudrasScreen> createState() => _MudrasScreenState();
}
List<Mudras> mudrasList() {
  List<Mudras> list = [];
  list.add(Mudras(img: 'assets/yoga/mudras/adi.jpg', title: 'Adi Mudra', description: 'Also known as the first gesture, this mudra calms the mind and nervous system. It can also help prevent snoring and improve oxygen flow to the brain and lungs.'));
  list.add(Mudras(img: 'assets/yoga/mudras/Vayu.jpg', title: 'Vayu Mudra', description: 'This Hatha mudra regulates the gas or wind inside the body. Practicing this mudra over time can help expel gas-related ailments.'));
  list.add(Mudras(img: 'assets/yoga/mudras/Dhyana.jpg', title: 'Dhyana Mudra', description: 'This mudra is often used during meditation and promotes concentration, reflection, and calm energy. It can be found on many Buddha statues and was used by Hindu yogis long before Buddhist meditation.'));
  list.add(Mudras(img: 'assets/yoga/mudras/jnana.jpeg', title: 'Jnana Mudra', description: 'This psychic gesture of knowledge is one of the most common mudras used by yogis in meditation. The name comes from the Sanskrit words jnana, meaning "knowledge", and mudra, meaning "gesture". To perform this mudra, the index finger folds and touches the base of the thumb.'));
  list.add(Mudras(img: 'assets/yoga/mudras/prana.jpg', title: 'Prana Mudra', description: 'This mudra is considered one of the primary mudras because it can awaken drowsy energy in the body.'));
  list.add(Mudras(img: 'assets/yoga/mudras/prithvi.jpeg', title: 'Prithvi Mudra', description: 'This mudra balances the earth element in the body and can strengthen it, relieve fatigue, promote endurance, boost self-confidence, and increase tolerance levels.'));
  list.add(Mudras(img: 'assets/yoga/mudras/varuna.jpeg', title: 'Varuna Mudra', description: 'This simple mudra balances the water element in the body. The name comes from the Sanskrit word Varun, which is the name of the Hindu god of water, and mudra, meaning “gesture” or “seal”.'));
  return list;
}
class _MudrasScreenState extends State<MudrasScreen> {
  List<Mudras> mainMudras = mudrasList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 39,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Mudras',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Lato',
                        color: Colors.deepPurple,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SvgPicture.asset('assets/yoga/yoga.svg'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 1.5,
                // color: Colors.green,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 20),
                      ListView.separated(
                        itemCount: mainMudras.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) {
                          return SizedBox(width: 20);
                        },
                        itemBuilder: (context, index) {
                          var mudra = mainMudras[index];
                          return GestureDetector(
                            onTap: () {

                            },
                            child: MudraCard(image: mudra.img,title: mudra.title,description: mudra.description,),
                          );
                        },
                      ),
                      SizedBox(width: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class MudraCard extends StatelessWidget {
  const MudraCard({Key? key,@required this.image,@required this.title,@required this.description}) : super(key: key);
  final String? image;
  final String? title;
  final String? description;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: 300,
      height: size.height / 1.6,
      decoration: BoxDecoration(
        // color: Color(0xffD0D0D0),
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage('$image'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            // height: 85.h,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            decoration: BoxDecoration(
              color: Color(0xFFD0D0D0).withOpacity(0.9),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$title',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Lato',

                  ),
                ),
                Text(
                  '$description',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    fontFamily: 'Lato',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}