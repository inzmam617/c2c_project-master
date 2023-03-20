import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget NotificationPage(){
  return Column(
    children: [

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
                  height: 110,
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
                          child: Text("9:41",style: TextStyle(color: Colors.black),),
                        ),
                        Row(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(

                                height: 75,
                                width: 60,
                                decoration: const BoxDecoration(
                                    color:Color(0xffFD8A00),
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                child: Center(
                                  child: SvgPicture.asset("assets/Notification.svg"),
                                ),
                              ),

                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text("Notification 1",style: TextStyle(color: Colors.black),),
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