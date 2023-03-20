import 'dart:io';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:path/path.dart' as Path;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import '../../bottom_icons_icons.dart';
import '../Cart/CartPage.dart';
import '../HomePages/Home.dart';
import '../MyCloset/MyClosetPage.dart';
import '../ProfilePage/ProfilePage.dart';
import 'PostProductPage.dart';

late String uploadedDraftImage;
late File uploadedFile;
List<String> imgRef = [];
String userAddress = '';
class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {


  // String description = '';
  // int productPrice = 0;
  // late String postUser;
  // String userAddress = '';
  // List<String> imgRef = [];
  // String productTitle = '';
  // String productCategory = '';
  // String materialCondition = '';
  // String productBrand = '';
  // String productFabric = '';
  // String productPattern = '';
  // String productColor = '';
  // String productSubColor = '';
  // String productOccasion = '';
  // String productSize = '';
  // final Storage storage = Storage();
  bool showSpinner = false;

  XFile? uploadImage;
  List pages = [
    const HomePage(),
    const CartPage(),
    const PostPage(),
    const MyClosetPage(),
    const ProfilePage(),


  ];

  int currentIndex = 0;

  void _onItemTapped(int Index){
    setState(() {

      currentIndex = Index;

    });
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
      return pages[Index];
    }));
    print(Index);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Post Product",style: TextStyle(color: Colors.black,fontSize: 18),),
      ),
      extendBody: true,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 3.0,
              ),
            ],
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20)
            ),
          ),
          margin: const EdgeInsets.all(5),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20)
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.white,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  label: "Home",
                  icon: Container(
                    //padding: const EdgeInsets.all(7),
                      child: const Icon(
                        Icons.home_filled,
                        //color: Colors.grey,
                      )),
                  //label: '',
                ),
                BottomNavigationBarItem(
                  label: "Cart",
                  icon: Container(
                    //padding: const EdgeInsets.all(7),
                      child: const Icon(
                          BottomIcons.buy
                        // color: Colors.grey,
                      )),
                  //label: '',
                ),
                BottomNavigationBarItem(
                  label: "Post",
                  icon: Container(
                    //padding: const EdgeInsets.all(7),
                      child: const Icon(
                          BottomIcons.camera
                        //  color: Colors.grey,
                      )),
                ),
                BottomNavigationBarItem(
                  label: "My Closet" ,

                  icon: Container(
                    //padding: const EdgeInsets.all(7),
                      child: const Icon(
                          BottomIcons.iconly_light_bag
                        //  color: Colors.grey,
                      )),
                  //label: '',
                ),
                BottomNavigationBarItem(
                  label: "Account",
                  icon: Container(
                    //padding: const EdgeInsets.all(7),
                      child: const Icon(
                          BottomIcons.profile
                        // color: Colors.grey,
                      )),
                  //label: '',
                ),




              ],
              currentIndex: 2,
              selectedIconTheme:
              const IconThemeData(color: Color(0xffFD8A00), size: 25),
              unselectedIconTheme:
              const IconThemeData(color: Colors.grey, size: 20),
              selectedItemColor: const Color(0xffFD8A00),
              unselectedItemColor: Colors.grey,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              onTap: _onItemTapped,
              selectedFontSize: 9,
              unselectedFontSize: 8,
              type: BottomNavigationBarType.fixed,
            ),
          ),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 3.5
                    )
                  ],
                    color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),

                height: 180,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: SvgPicture.asset("assets/Camera.svg",height: 60,),
                      ),
                      const SizedBox(height: 30,),
                      const Text("Camera",style: TextStyle(color: Colors.black,fontSize: 15),)

                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Center(
              child: SizedBox(
                  width: 150,
                  height: 35,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(50))
                          )),
                          backgroundColor: MaterialStateProperty.all(const Color(0xffFD8A00))
                      ),
                      onPressed: () async {
                        setState(() {
                          showSpinner = true;
                        });

                        uploadImage = await ImagePicker().pickImage(
                            source: ImageSource.camera, imageQuality: 50);

                        if (uploadImage == null) {
                          setState(() {
                            showSpinner = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('No File Selected!'),
                            ),
                          );
                        } else {
                          final path = uploadImage?.path;
                          final fileName = Path.basename(path!);
                          uploadedDraftImage = fileName.toString();

                          uploadedFile = File(path);
                          setState(() {
                            showSpinner = false;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PostProductPage()),
                          );
                        }
                        // Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                        //   return const TabBarPage();
                        // }));
                      }, child: const Text("Take Photo"))),
            ),
            const SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Container(
                decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 3.5
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),

                height: 180,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: SvgPicture.asset("assets/Image 2.svg",height: 60,),
                      ),
                      const SizedBox(height: 30,),
                      const Text("Gallery",style: TextStyle(color: Colors.black,fontSize: 15),)

                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Center(
              child: SizedBox(
                  width: 150,
                  height: 35,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(50))
                          )),
                          backgroundColor: MaterialStateProperty.all(const Color(0xffFD8A00))
                      ),
                      onPressed: () async {
                        setState(() {
                          showSpinner = true;
                        });

                        final uploadImage = await ImagePicker().pickImage(
                            source: ImageSource.gallery, imageQuality: 25);

                        if (uploadImage == null) {
                          setState(() {
                            showSpinner = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('No File Selected!'),
                            ),
                          );
                        } else {
                          final path = uploadImage.path;
                          final fileName = Path.basename(uploadImage.path);
                          uploadedDraftImage = fileName.toString();

                          uploadedFile = File(path);
                          setState(() {
                            showSpinner = false;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PostProductPage()),
                          );
                        }
                        // Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                        //   return const PostProductPage();
                        // }));
                      }, child: const Text("Choose Photo"))),
            )

          ],
        ),
      )
    );
  }
}
