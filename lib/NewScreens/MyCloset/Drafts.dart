import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Drafts extends StatefulWidget {
  const Drafts({Key? key}) : super(key: key);

  @override
  State<Drafts> createState() => _DraftsState();
}

class _DraftsState extends State<Drafts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2.5
                  )
                ]

              ),
              height: 110,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 80,
                          width: 100,
                          child: Image.asset("assets/box.png"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,

                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Cotton Shirt" ,style: TextStyle(color: Colors.black54,fontSize: 15),),
                              const Text("\$1100" ,style: TextStyle(color: Colors.black54,fontSize: 15 )),
                              TextButton(
                                  onPressed: (){},
                                  child: const Text("Detele from Drafts",style: TextStyle(color: Color(0xffFD8A00),fontSize: 15)))
                            ],
                          ),
                        ),
                      ],
                    ),

                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: (){
                          print("asd");
                          
                        },
                          child: SvgPicture.asset("assets/Edit.svg")),
                    )
                  ],
                ),
              ),
            ),
          );
        },),
      ),
    );
  }
}
