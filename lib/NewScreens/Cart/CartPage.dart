import 'package:flutter/material.dart';
import '../../bottom_icons_icons.dart';
import '../HomePages/Home.dart';
import '../MyCloset/MyClosetPage.dart';
import '../Post/PostPage.dart';
import '../ProfilePage/ProfilePage.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
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
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text("Cart",style: TextStyle(color: Colors.black),),
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
              currentIndex: 1,
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
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height - 250,
            child: ListView.builder(itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 3.5
                    )
                  ]
                ),
                height: 120,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        height: 100,
                        width: 120,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                              image: AssetImage("assets/istockphoto-1189191538-170667a.jpg"))
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text("Scoth Premium" ,style: TextStyle(color: Colors.black,fontSize: 17),),
                        const Text("\$1600" ,style: TextStyle(color: Colors.black,fontSize: 13),),
                        Row(
                          children: const [


                          ],
                        )
                      ],
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: (){},
                          icon: const Icon(Icons.close,color: Colors.black,),
                        ),
                      ),
                    )
                  ]

                ),
              ),);
            },),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Divider(thickness: 1.5,),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Total" ,style: TextStyle(color: Colors.black),),
                Text("\$1475")
              ],
            ),
          ),
          Center(
            child: SizedBox(
              width: 255,
              height: 35,
              child: ElevatedButton(
                  onPressed: () {
                    //Navigator.of(context).push(
                        // MaterialPageRoute(builder: (BuildContext context) {
                        //   return checkout2();
                        // }));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffFD8A00),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32))),
                  child: const Text(
                    "Checkout",
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  )),
            ),
          )
        ],
      )
    );
  }
}
