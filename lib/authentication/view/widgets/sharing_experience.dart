import 'dart:io';

import 'package:WeCare/authentication/view/widgets/dashboard_main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/experience_model.dart';
class SharingExperience extends StatefulWidget {
  const SharingExperience({super.key});

  @override
  State<SharingExperience> createState() => _SharingExperienceState();
}

class _SharingExperienceState extends State<SharingExperience> {
  var box = Hive.box<Experience>('sharingDetailsBox');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<Experience> getSharingExp = [];
  int currentPage = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  var kAnimationDuration = const Duration(milliseconds: 200);
  var kPrimaryColor = Colors.black;
  List<String> getQuotes = ['DO YOGA - COMMUNE WITH NATURE','WE CARE FOR WELLNESS','TURN YOUR IDEAS INTO REALITY','JUST DO GOOD - GOOD THINGS WILL COME BACK TO YOU'];

  AnimatedContainer buildDot(bool isCurrent) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: const EdgeInsets.only(right: 5),
      height: 8,
      width: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isCurrent ? const Color(0xff525252) : const Color(0xffC4C4C4),
      ),
    );
  }
  void _showModalBottomSheet(BuildContext context) {
     TextEditingController titleController = TextEditingController();
     TextEditingController descriptionController = TextEditingController();
     final ImagePicker _picker = ImagePicker();
     Uint8List? imageUint8List;
     XFile? _image;
     showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return StatefulBuilder(builder: (context,state){
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField(
                        controller: titleController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }else if(value.length>=250){
                            return 'Title should be less then 250 characters';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Title here',
                        ),
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        controller: descriptionController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter description';
                          }
                          return null;
                        },
                        maxLines: null,

                        decoration: InputDecoration(
                            hintText: 'Description here',
                            floatingLabelBehavior: FloatingLabelBehavior.auto
                        ),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Center(
                            child: _image == null
                                ? const Text('No image selected.')
                                : Container(
                                height: 50,
                                width: 100,
                                child: Image.file(File(_image!.path))),
                          ),
                          InkWell(
                              onTap: () async{
                                FocusScope.of(context).requestFocus(FocusNode());
                                final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                                List<int> imageBytes = await image!.readAsBytes();
                                imageUint8List = Uint8List.fromList(imageBytes);
                                state(() {
                                  _image = image;
                                });
                              },
                              child: Icon(Icons.image_outlined))
                        ],
                      ),
                      InkWell(
                        onTap: ()
                        async{
                          SharedPreferences pref = await SharedPreferences.getInstance();
                          String getUserName =  pref.getString('userName')??'';
                          final isValidated =  _formKey.currentState!.validate();
                          if(isValidated) {
                            var sharingData = Experience(question: titleController.text, answer: descriptionController.text, Uint8List:  imageUint8List, user: getUserName);
                            await box.add(sharingData);
                            Navigator.pop(context);
              }else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to save - Try Again')),
                );
              }

                        },
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            width: 150,
                            height: 50,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 2),
                            decoration: BoxDecoration(
                                borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0xFF8A3FFC),
                                      Colors.blue,
                                    ])),
                            child: Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(6)),
                                color: Colors.white,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                  'SAVE',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Lato'
                                  )
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(10.0),
                      //   child: ElevatedButton(
                      //     child: Text('Submit'),
                      //     onPressed: () {
                      //       if (_formKey.currentState!.validate()) {
                      //         // If the form is valid, display a Snackbar.
                      //         Navigator.pop(context);
                      //         ScaffoldMessenger.of(context).showSnackBar(
                      //           SnackBar(content: Text('Processing Data')),
                      //         );
                      //       }
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          );

        });

      },
    ).then((value) => {
     setState(() {
     })
     });
  }
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
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 35,
                      height: 35,
                      child: IconButton(
                        visualDensity: VisualDensity.adaptivePlatformDensity,
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.chevron_left,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(width: 30,),
                    Text(
                      "SET AN EXAMPLE",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.deepPurple,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Lato'
                      )
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: SizedBox(
                    height: 100,
                    // color: AppColors.grey,
                    child: Stack(
                      children: [
                        PageView.builder(
                          itemCount: getQuotes.length,
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          onPageChanged: (index) {
                            setState(() {
                              currentPage = index;
                            });
                          },
                          itemBuilder: (c, i) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 20,right: 20),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.transparent,
                                ),
                                height: 100,
                                child: Center(child: Text('${getQuotes[i]}',style: TextStyle(
                                  fontFamily: 'Lato',fontWeight: FontWeight.bold,fontSize: 20,color: Colors.purple
                                ),)),
                              ),
                            );
                          },
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  getQuotes.length,
                                      (index) => buildDot(index == currentPage),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 11,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('User Experiences', style: TextStyle(color: Colors.black87,fontSize: 20,fontFamily: 'Lato',fontWeight: FontWeight.w900),),
                    InkWell(
                      onTap: (){
                        _showModalBottomSheet(context);
                      },
                      child: Card(
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
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: box.length,
                    itemBuilder: (context, index){
                       return Padding(
                         padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                         child: SizedBox(
                           height: 125,
                           // padding: EdgeInsets.only(left: 11.w),
                           child: Row(
                             mainAxisSize: MainAxisSize.max,
                             // crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Center(
                                 child: ClipRRect(
                                   borderRadius: BorderRadius.circular(8),
                                   child: Container(
                                     width: 125,
                                     height: 125,
                                     // margin: EdgeInsets.only(right: 14.w),
                                     child: box.getAt(index)!.Uint8List == null?Image.asset('assets/blog.png'):
                                     Image.memory(box.getAt(index)!.Uint8List),
                                   ),
                                 ),
                               ),
                               Expanded(
                                 child: Row(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Expanded(
                                       child: Padding(
                                         padding: EdgeInsets.only(
                                           left: 15,
                                           right: 2,
                                           top: 10,
                                           bottom: 10,
                                         ),
                                         child: Column(
                                           mainAxisAlignment:
                                           MainAxisAlignment.start,
                                           crossAxisAlignment:
                                           CrossAxisAlignment.start,
                                           children: [
                                             Flexible(
                                               child: Text(
                                                 "${box.getAt(index)!.question}",
                                                 style: TextStyle(
                                                     fontSize: 16,
                                                     color: Colors.black,
                                                     fontStyle: FontStyle.normal,
                                                     fontWeight: FontWeight.w600,
                                                     fontFamily: 'Lato'
                                                 ),
                                                 maxLines: 3,
                                                 overflow: TextOverflow.ellipsis,
                                               ),
                                             ),
                                             SizedBox(
                                               height: 8,
                                             ),
                                             Text(
                                               "${box.getAt(index)!.answer}",
                                               style: TextStyle(
                                                   fontSize: 14,
                                                   color: Colors.black,
                                                   fontStyle: FontStyle.normal,
                                                   fontWeight: FontWeight.w400,
                                                   fontFamily: 'Lato'
                                               ),
                                               maxLines: 2,
                                               overflow: TextOverflow.ellipsis,
                                             ),
                                             SizedBox(
                                               height: 8,
                                             ),
                                           ],
                                         ),
                                       ),
                                     ),
                                   ],
                                 ),
                               )
                             ],
                           ),
                         ),
                       );
                    }
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
