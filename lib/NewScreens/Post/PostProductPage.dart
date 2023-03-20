import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'PostProductDetails.dart';

final List<File> _image = [];
List<File> imagesToBesPosted = [];
class PostProductPage extends StatefulWidget {
  const PostProductPage({Key? key}) : super(key: key);

  @override
  State<PostProductPage> createState() => _PostProductPageState();
}

class _PostProductPageState extends State<PostProductPage> {


  // bool showSpinner = false;
  // bool uploading = false;

  int counter = 0;

  // displayImage() {
  //   if (_image.isEmpty) {
  //     return const Padding(
  //       padding: EdgeInsets.all(8.0),
  //       child: SizedBox(
  //         width: 100.0,
  //         height: 100.0,
  //         child: Center(child: Text('You can add up to 7 more images!')),
  //       ),
  //     );
  //   } else {
  //     return Row(
  //       children: [
  //         Expanded(
  //           child: SizedBox(
  //             width: 100.0,
  //             height: 150.0,
  //             child: GridView.builder(
  //                 itemCount: _image.length,
  //                 physics: const NeverScrollableScrollPhysics(),
  //                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //                   crossAxisCount: 5,
  //                 ),
  //                 itemBuilder: (context, index) {
  //                   return Container(
  //                     margin: const EdgeInsets.all(3),
  //                     decoration: BoxDecoration(
  //                       image: DecorationImage(
  //                           image: FileImage(_image[index]), fit: BoxFit.cover),
  //                     ),
  //                     child: Center(
  //                       child: TextButton(
  //                         onPressed: () {
  //                           setState(() {
  //                             _image.removeAt(index);
  //                             counter -= 1;
  //                           });
  //                         },
  //                         child: Icon(
  //                           Icons.cancel,
  //                           color: Colors.white.withOpacity(0.5),
  //                         ),
  //                       ),
  //                     ),
  //                   );
  //                 }),
  //           ),
  //         ),
  //       ],
  //     );
  //   }
  // }

  chooseImage() async {
    final uploadImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);

    if (uploadImage == null) {
      // setState(() {
      //   showSpinner = false;
      // });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No File Selected!'),
        ),
      );
    } else {
      final path = uploadImage.path;
      File file = File(path);

      setState(() {
        _image.add(file);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
        ),
        title: const Text("Post Product",style: TextStyle(color: Colors.black),),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10,left: 10),
            child: SizedBox(
              height: 180,
              child: Row(children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(color: Colors.grey,blurRadius: 3.5)
                    ]
                  ),
                  // color: Colors.white,
                  height: 180,
                  width: MediaQuery.of(context).size.width / 3,
                  child: InkWell(
                    onTap: (){
                      if (counter != 7 && _image.length != 7) {
                        chooseImage();
                        counter += 1;
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('You cannot post more images!'),
                          ),
                        );
                      }
                    },
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                         SvgPicture.asset("assets/Group 1831.svg",height: 60,),
                          const SizedBox(height: 25,),
                          const Text("Upload Image" ,style: TextStyle(color: Colors.black,fontSize: 12),)
                        ],
                      ),
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 180,
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _image.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(_image[index]), fit: BoxFit.cover),
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                              boxShadow: const [
                                BoxShadow(color: Colors.grey,blurRadius: 3.5)
                              ]
                          ),
                          width: MediaQuery.of(context).size.width / 3.5,
                          child: Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              onTap: (){
                                setState(() {
                                  _image.removeAt(index);
                                  counter -= 1;
                                });
                              },
                              child: Container(
                                height: 20,
                                width: 20,
                                decoration: const BoxDecoration(
                                  color: Colors.white,

                                  borderRadius: BorderRadius.all(Radius.circular(100))
                                ),
                                child: const Center(
                                  child:  Icon(Icons.close, size: 15,),

                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // ),
              ]),
            ),
          ),
          const SizedBox(height: 20,),
          const Center(
            child: Text("you can add up to 7 images!" ,style: TextStyle(color: Colors.black),),
          ),
          const SizedBox(height: 50,),
          Center(
            child: SizedBox(
                width: 200,
                height: 35,
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50))
                        )),
                        backgroundColor: MaterialStateProperty.all(const Color(0xffFD8A00))
                    ),
                    onPressed: (){
                      imagesToBesPosted = _image;
                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                        return const PostProductDetails();
                      }));
                    }, child: const Text("Proceed"))),
          )
        ],
      ),
    );
  }
}
