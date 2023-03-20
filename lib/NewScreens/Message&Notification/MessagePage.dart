import 'package:flutter/material.dart';

Widget MessagePage(){
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.0
                    )
                  ]
                ),
              height: 30,
              width: 60,
              child: const Center(child: Text("ALL",style: TextStyle(color: Colors.black,fontSize: 10),)),
            ),
            const SizedBox(width: 5,),
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0
                    )
                  ]
              ),
              height: 30,
              width: 60,
              child: const Center(child: Text("READ",style: TextStyle(color: Colors.grey,fontSize: 10),)),
            ),
            const SizedBox(width: 5,),
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0
                    )
                  ]
              ),
              height: 30,
              width: 60,
              child: const Center(child: Text("Unread",style: TextStyle(color: Colors.grey,fontSize: 10),)),
            ),
          ],
        ),
      ),

      Expanded(
        child: ListView.builder(
          itemCount: 10,
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.grey,blurRadius: 3.5),

                ]
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children:  [
                    const Align(
                      alignment: Alignment.topRight,
                      child: Text("9:00",style: TextStyle(color: Colors.black),),
                    ),
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: const BoxDecoration(

                              image: DecorationImage(
                                fit: BoxFit.cover,
                                  image: AssetImage("assets/dressThirteen.png",)),
                              borderRadius: BorderRadius.all(Radius.circular(100))
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Person 1",style: TextStyle(color: Colors.black),),
                              Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit.",style: TextStyle(color: Colors.black,fontSize: 10),),
                            ],
                          ),
                        )
                      ],
                    ),

                  ],
                ),
              )
            ),
          );
        },),
      )
    ],
  );
}


