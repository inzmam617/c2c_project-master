import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';




final _firestore = FirebaseFirestore.instance;

getStream() {
  if ((category == 'All') &&
      (color == 'All') &&
      (fabric == 'All') &&
      (occasion == 'All') &&
      (sort == 'All') &&
      (price == 'All') &&
      (condition == 'All') &&
      (location == 'All')) {
    return _firestore
        .collection('Posts')
        // .where('archive', isEqualTo: 'no')
        .orderBy('time', descending: true)
        .snapshots();
  }

  if ((category != 'All') &&
      (color != 'All') &&
      (fabric != 'All') &&
      (occasion != 'All') &&
      (sort != 'All') &&
      (price != 'All') &&
      (condition != 'All') &&
      (location != 'All')) {
    return _firestore
        .collection('Posts')
        // .where('archive', isEqualTo: 'no')
        .where('productCategory', isEqualTo: category)
        .where('color', isEqualTo: color)
        .where('fabric', isEqualTo: fabric)
        .where('occasion', isEqualTo: occasion)
        .where('size', isEqualTo: size)
        .where('condition', isEqualTo: condition)
        .where('location', isEqualTo: location)
        .where('sort', isEqualTo: sort)
        .where('price', isEqualTo: price)
        .orderBy('time', descending: true)
        .snapshots();
  }

  if ((category != 'All') &&
      (color == 'All') &&
      (fabric == 'All') &&
      (occasion == 'All') &&
      (sort == 'All') &&
      (price == 'All') &&
      (condition == 'All') &&
      (location == 'All')) {
    return _firestore
        .collection('Posts')
        // .where('archive', isEqualTo: 'no')
        .where('productCategory', isEqualTo: category)
        .orderBy('time', descending: true)
        .snapshots();
  }

  if ((category == 'All') &&
      (color == 'All') &&
      (fabric == 'All') &&
      (occasion == 'All') &&
      (sort == 'All') &&
      (size != 'All') &&
      (price == 'All') &&
      (condition == 'All') &&
      (location == 'All')) {
    return _firestore
        .collection('Posts')
        // .where('archive', isEqualTo: 'no')
        .where('size', isEqualTo: size)
        .orderBy('time', descending: true)
        .snapshots();
  }

  if ((category == 'All') &&
      (color != 'All') &&
      (fabric == 'All') &&
      (occasion == 'All') &&
      (sort == 'All') &&
      (price == 'All') &&
      (condition == 'All') &&
      (location == 'All')) {
    return _firestore
        .collection('Posts')
        // .where('archive', isEqualTo: 'no')
        .where('color', isEqualTo: color)
        .orderBy('time', descending: true)
        .snapshots();
  }

  if ((category == 'All') &&
      (color == 'All') &&
      (fabric != 'All') &&
      (occasion == 'All') &&
      (sort == 'All') &&
      (price == 'All') &&
      (condition == 'All') &&
      (location == 'All')) {
    return _firestore
        .collection('Posts')
        // .where('archive', isEqualTo: 'no')
        .where('fabric', isEqualTo: fabric)
        .orderBy('time', descending: true)
        .snapshots();
  }

  if ((category == 'All') &&
      (color == 'All') &&
      (fabric == 'All') &&
      (occasion != 'All') &&
      (sort == 'All') &&
      (price == 'All') &&
      (condition == 'All') &&
      (location == 'All')) {
    return _firestore
        .collection('Posts')
        // .where('archive', isEqualTo: 'no')
        .where('occasion', isEqualTo: occasion)
        .orderBy('time', descending: true)
        .snapshots();
  }

  if ((category == 'All') &&
      (color == 'All') &&
      (fabric == 'All') &&
      (occasion == 'All') &&
      (sort != 'All') &&
      (price == 'All') &&
      (condition == 'All') &&
      (location == 'All')) {
    return _firestore
        .collection('Posts')
        // .where('archive', isEqualTo: 'no')
        .orderBy('time', descending: (sort == 'Old Posts') ? false : true)
        .snapshots();
  }

  if ((category == 'All') &&
      (color == 'All') &&
      (fabric == 'All') &&
      (occasion == 'All') &&
      (sort == 'All') &&
      (price != 'All') &&
      (condition == 'All') &&
      (location == 'All')) {
    return _firestore
        .collection('Posts')
        // .where('archive', isEqualTo: 'no')
        .orderBy('cost', descending: (price == 'Low to High') ? false : true)
        .orderBy('time', descending: true)
        .snapshots();
  }

  if ((category == 'All') &&
      (color == 'All') &&
      (fabric == 'All') &&
      (occasion == 'All') &&
      (sort == 'All') &&
      (price == 'All') &&
      (condition != 'All') &&
      (location == 'All')) {
    return _firestore
        .collection('Posts')
        // .where('archive', isEqualTo: 'no')
        .where('materialCondition', isEqualTo: condition)
        .orderBy('time', descending: true)
        .snapshots();
  }

  // Location is left

  if ((category != 'All') && (color != 'All') && (fabric == 'All')) {
    return _firestore
        .collection('Posts')
        // .where('archive', isEqualTo: 'no')
        .where('productCategory', isEqualTo: category)
        .where('color', isEqualTo: color)
        .orderBy('time', descending: true)
        .snapshots();
  }

  if ((category != 'All') && (color == 'All') && (fabric != 'All')) {
    return _firestore
        .collection('Posts')
        // .where('archive', isEqualTo: 'no')
        .where('productCategory', isEqualTo: category)
        .where('fabric', isEqualTo: fabric)
        .orderBy('time', descending: true)
        .snapshots();
  }

  if (color != 'All' && category == 'All' && fabric != 'All') {
    return _firestore
        .collection('Posts')
        // .where('archive', isEqualTo: 'no')
        .where('color', isEqualTo: color)
        .where('fabric', isEqualTo: fabric)
        .orderBy('time', descending: true)
        .snapshots();
  }
}
String category = 'All';
String fabric = 'All';
String? color = 'All' ;
String occasion = 'All';
String condition = 'All';
String price = 'All';
String sort = 'All';
String size = 'All';
String location = 'All';
class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}
// const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class _FilterPageState extends State<FilterPage> {

  void initState(){
    super.initState();
    _selectedSize = _sizes.first;
    color = _values.first;
  }
  var selectRange = const RangeValues(0, 200);

  bool selectedblack = true;
  bool selectedblue = true;
  bool selectedred = false;
  bool selectedpurple = true;
  bool selectedbrown = true;
  bool selecteddarkblue = true;


  List<String> _values = [
    'All',
    'Golden',
    'Yellow',
    'Blue',
    'Green',
    'Violet',
    'Red',
    'Brown',
    'Orange',
    'Black',
    'Indigo',
    'White',
    'Off-White'

  ]; String? _selectedSize  ;

  List<String> _sizes = [
    'All',
    'XS',
    'S',
    'M',
    'L',
    'XL',
    'XXL',
    'XXXL',
    // 'Orange',
    // 'Black',
    // 'Indigo',
    // 'White',
    // 'Off-White'

  ];
  bool xs = true;
  bool s = true;
  bool m = true;
  bool l = true;
  bool xl = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
           Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Filter",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "Price range",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2.0)]),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("\$${selectRange.start.toInt()}"),
                        Text("\$${selectRange.end.toInt()}")
                      ],
                    ),
                  ),
                  RangeSlider(
                      inactiveColor: const Color(0xff9B9B9B),
                      activeColor: const Color(0xffFD8A00),
                      min: 0,
                      max: 200,
                      values: selectRange,
                      onChanged: (RangeValues newRange) {
                        setState(() {
                          selectRange = newRange;
                        });
                      }),
                ],
              ),
            ),
          ),
           Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.s,
              children: [
                const Text(
                  "Colors",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
                      const SizedBox(width: 50,),
                      Container(height: 40,
                        width: 100,

                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Colors.white,
                            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2.0)]
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButton<String>(
                                value: color,
                                icon: const Icon(Icons.arrow_downward),
                                elevation: 16,
                                style: const TextStyle(color: Colors.black),
                                underline: const SizedBox.shrink(),
                                onChanged: (String? value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  color = value!;
                                });
                                },
                                items: _values.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                                );
                                }).toList(),
    ),
                          ),
                        ),
                      )

              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   height: 100,
          //   decoration: const BoxDecoration(
          //       color: Colors.white,
          //       boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2.0)]),
          //   child: Center(
          //       child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 10),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       children: [
          //         InkWell(
          //           onTap: () {
          //             setState(() {
          //               selectedblack = !selectedblack;
          //               color = "Black";
          //             });
          //           },
          //           child: selectedblack
          //               ? Container(
          //                   height: 35,
          //                   width: 35,
          //                   decoration: const BoxDecoration(
          //                       color: Colors.black,
          //                       borderRadius:
          //                           BorderRadius.all(Radius.circular(100))),
          //                 )
          //               : Container(
          //                   decoration: BoxDecoration(
          //                       border: Border.all(color: Colors.red),
          //                       //color: Colors.blueGrey,
          //                       borderRadius: const BorderRadius.all(
          //                           Radius.circular(100))),
          //                   child: Padding(
          //                     padding: const EdgeInsets.all(1.5),
          //                     child: Container(
          //                       height: 35,
          //                       width: 35,
          //                       decoration: const BoxDecoration(
          //                           color: Colors.black,
          //                           borderRadius: BorderRadius.all(Radius.circular(100))),
          //                     ),
          //                   ),
          //                 ),
          //         ),
          //         InkWell(
          //           onTap: () {
          //             setState(() {
          //               selectedblue = !selectedblue;
          //               color = "blue";
          //             });
          //           },
          //           child: selectedblue
          //               ? Container(
          //                   height: 35,
          //                   width: 35,
          //                   decoration: const BoxDecoration(
          //                       color: Color(0xff97AABD),
          //                       borderRadius:
          //                           BorderRadius.all(Radius.circular(100))),
          //                 )
          //               : Container(
          //                   decoration: BoxDecoration(
          //                       border: Border.all(color: Colors.red),
          //                       //color: Colors.blueGrey,
          //                       borderRadius: const BorderRadius.all(
          //                           Radius.circular(100))),
          //                   child: Padding(
          //                     padding: const EdgeInsets.all(1.5),
          //                     child: Container(
          //                       height: 35,
          //                       width: 35,
          //                       decoration: const BoxDecoration(
          //                           color: Color(0xff97AABD),
          //                           borderRadius:
          //                               BorderRadius.all(Radius.circular(100))),
          //                     ),
          //                   ),
          //                 ),
          //         ),
          //         InkWell(
          //           onTap: () {
          //             setState(() {
          //               selectedred = !selectedred;
          //               color = "Red";
          //             });
          //           },
          //           child: selectedred
          //               ? Container(
          //                   height: 35,
          //                   width: 35,
          //                   decoration: const BoxDecoration(
          //                       color: Color(0xffB82222),
          //                       borderRadius:
          //                           BorderRadius.all(Radius.circular(100))),
          //                 )
          //               : Container(
          //                   decoration: BoxDecoration(
          //                       border: Border.all(color: Colors.red),
          //                       //color: Colors.blueGrey,
          //                       borderRadius: const BorderRadius.all(
          //                           Radius.circular(100))),
          //                   child: Padding(
          //                     padding: const EdgeInsets.all(1.5),
          //                     child: Container(
          //                       height: 35,
          //                       width: 35,
          //                       decoration: const BoxDecoration(
          //                           color: Color(0xffB82222),
          //                           borderRadius:
          //                               BorderRadius.all(Radius.circular(100))),
          //                     ),
          //                   ),
          //                 ),
          //         ),
          //         InkWell(
          //           onTap: () {
          //             setState(() {
          //               selectedpurple = !selectedpurple;
          //               color = "Violet";
          //             });
          //           },
          //           child: selectedpurple
          //               ? Container(
          //                   height: 35,
          //                   width: 35,
          //                   decoration: const BoxDecoration(
          //                       color: Color(0xffBEA9A9),
          //                       borderRadius:
          //                           BorderRadius.all(Radius.circular(100))),
          //                 )
          //               : Container(
          //                   decoration: BoxDecoration(
          //                       border: Border.all(color: Colors.red),
          //                       //color: Colors.blueGrey,
          //                       borderRadius: const BorderRadius.all(
          //                           Radius.circular(100))),
          //                   child: Padding(
          //                     padding: const EdgeInsets.all(1.5),
          //                     child: Container(
          //                       height: 35,
          //                       width: 35,
          //                       decoration: const BoxDecoration(
          //                           color: Color(0xffBEA9A9),
          //                           borderRadius:
          //                               BorderRadius.all(Radius.circular(100))),
          //                     ),
          //                   ),
          //                 ),
          //         ),
          //         InkWell(
          //           onTap: () {
          //             setState(() {
          //               selectedbrown = !selectedbrown;
          //               color = "Brown";
          //             });
          //           },
          //           child: selectedbrown
          //               ? Container(
          //                   height: 35,
          //                   width: 35,
          //                   decoration: const BoxDecoration(
          //                       color: Color(0xffE2BB8D),
          //                       borderRadius:
          //                           BorderRadius.all(Radius.circular(100))),
          //                 )
          //               : Container(
          //                   decoration: BoxDecoration(
          //                       border: Border.all(color: Colors.red),
          //                       //color: Colors.blueGrey,
          //                       borderRadius: const BorderRadius.all(
          //                           Radius.circular(100))),
          //                   child: Padding(
          //                     padding: const EdgeInsets.all(1.5),
          //                     child: Container(
          //                       height: 35,
          //                       width: 35,
          //                       decoration: const BoxDecoration(
          //                           color: Color(0xffE2BB8D),
          //                           borderRadius:
          //                               BorderRadius.all(Radius.circular(100))),
          //                     ),
          //                   ),
          //                 ),
          //         ),
          //         InkWell(
          //           onTap: () {
          //             setState(() {
          //               selecteddarkblue = !selecteddarkblue;
          //               color = "Indigo";
          //             });
          //           },
          //           child: selecteddarkblue
          //               ? Container(
          //                   height: 35,
          //                   width: 35,
          //                   decoration: const BoxDecoration(
          //                       color: Color(0xff151867),
          //                       borderRadius:
          //                           BorderRadius.all(Radius.circular(100))),
          //                 )
          //               : Container(
          //                   decoration: BoxDecoration(
          //                       border: Border.all(color: Colors.red),
          //                       //color: Colors.blueGrey,
          //                       borderRadius: const BorderRadius.all(
          //                           Radius.circular(100))),
          //                   child: Padding(
          //                     padding: const EdgeInsets.all(1.5),
          //                     child: Container(
          //                       height: 35,
          //                       width: 35,
          //                       decoration: const BoxDecoration(
          //                           color: Color(0xff151867),
          //                           borderRadius:
          //                               BorderRadius.all(Radius.circular(100))),
          //                     ),
          //                   ),
          //                 ),
          //         ),
          //       ],
          //     ),
          //   )),
          // ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Text(
                  "Sizes",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
                SizedBox(width: 50,),
                Container(height: 40,
                  width: 100,

                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.white,
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2.0)]
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton<String>(
                        value: _selectedSize,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        underline: SizedBox.shrink(),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            _selectedSize = value!;
                          });
                        },
                        items: _sizes.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   height: 100,
          //   decoration: const BoxDecoration(
          //       color: Colors.white,
          //       boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2.0)]),
          //   child: Center(
          //       child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 10),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       children: [
          //         InkWell(
          //           onTap: (){
          //             setState(() {
          //               setState(() {
          //                 size = "XS";
          //               });
          //               xs = !xs;
          //
          //             });
          //           },
          //           child: Container(
          //             height: 40,
          //             width: 35,
          //             decoration: BoxDecoration(
          //               // boxShadow: const [
          //               //   BoxShadow(
          //               //     color: Colors.grey,
          //               //     blurRadius: 3.5
          //               //   )
          //               // ],
          //               borderRadius: const BorderRadius.all(Radius.circular(10)),
          //               border: Border.all(color: xs ? Colors.black : const Color(0xffFD8A00)),
          //                 color:
          //                 xs ? Colors.white : const Color(0xffFD8A00)),
          //             child: Center(
          //               child: Text("XS",style: TextStyle(color: xs ? Colors.black :  Colors.white),),
          //             ),
          //           ),
          //         ),
          //         InkWell(
          //           onTap: (){
          //             setState(() {
          //               setState(() {
          //                 size = "S";
          //               });
          //               s = !s;
          //
          //             });
          //           },
          //           child: Container(
          //             height: 40,
          //             width: 35,
          //             decoration: BoxDecoration(
          //               // boxShadow: const [
          //               //   BoxShadow(
          //               //     color: Colors.grey,
          //               //     blurRadius: 3.5
          //               //   )
          //               // ],
          //                 borderRadius: const BorderRadius.all(Radius.circular(10)),
          //                 border: Border.all(color: s ? Colors.black : const Color(0xffFD8A00)),
          //                 color:
          //                 s ? Colors.white : const Color(0xffFD8A00)),
          //             child: Center(
          //               child: Text("S",style: TextStyle(color: s ? Colors.black :  Colors.white),),
          //             ),
          //           ),
          //         ),
          //         InkWell(
          //           onTap: (){
          //             setState(() {
          //
          //               setState(() {
          //                 size = "M";
          //               });
          //               m = !m;
          //
          //             });
          //           },
          //           child: Container(
          //             height: 40,
          //             width: 35,
          //             decoration: BoxDecoration(
          //               // boxShadow: const [
          //               //   BoxShadow(
          //               //     color: Colors.grey,
          //               //     blurRadius: 3.5
          //               //   )
          //               // ],
          //                 borderRadius: const BorderRadius.all(Radius.circular(10)),
          //                 border: Border.all(color: m ? Colors.black : const Color(0xffFD8A00)),
          //                 color:
          //                 m ? Colors.white : const Color(0xffFD8A00)),
          //             child: Center(
          //               child: Text("M",style: TextStyle(color: m ? Colors.black :  Colors.white),),
          //             ),
          //           ),
          //         ),
          //         InkWell(
          //           onTap: (){
          //             setState(() {
          //
          //               setState(() {
          //                 size = "L";
          //               });
          //               l = !l;
          //
          //             });
          //           },
          //           child: Container(
          //             height: 40,
          //             width: 35,
          //             decoration: BoxDecoration(
          //               // boxShadow: const [
          //               //   BoxShadow(
          //               //     color: Colors.grey,
          //               //     blurRadius: 3.5
          //               //   )
          //               // ],
          //                 borderRadius: const BorderRadius.all(Radius.circular(10)),
          //                 border: Border.all(color: l ? Colors.black : const Color(0xffFD8A00)),
          //                 color:
          //                 l ? Colors.white : const Color(0xffFD8A00)),
          //             child: Center(
          //               child: Text("L",style: TextStyle(color: l ? Colors.black :  Colors.white),),
          //             ),
          //           ),
          //         ),
          //         InkWell(
          //           onTap: (){
          //             setState(() {
          //
          //               setState(() {
          //                 size = "XL";
          //               });
          //               xl = !xl;
          //
          //             });
          //           },
          //           child: Container(
          //             height: 40,
          //             width: 35,
          //             decoration: BoxDecoration(
          //               // boxShadow: const [
          //               //   BoxShadow(
          //               //     color: Colors.grey,
          //               //     blurRadius: 3.5
          //               //   )
          //               // ],
          //                 borderRadius: const BorderRadius.all(Radius.circular(10)),
          //                 border: Border.all(color: xl ? Colors.black : const Color(0xffFD8A00)),
          //                 color:
          //                 xl ? Colors.white : const Color(0xffFD8A00)),
          //             child: Center(
          //               child: Text("XL",style: TextStyle(color: xl ? Colors.black :  Colors.white),),
          //             ),
          //           ),
          //         ),
          //
          //       ],
          //     ),
          //   )),
          // ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 2.0)
                    ]),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 35,
                          width: 120,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50)))),
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color(0xffFD8A00))),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                "Apply",
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 35,
                          width: 120,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50)))),
                                  side: MaterialStateProperty.all(
                                      const BorderSide(
                                          color: Color(0xffFD8A00))),
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color(0xffFFFFFF))),
                              onPressed: () {
                                setState(() {

                                   category = 'All';
                                   fabric = 'All';
                                   color = 'All';
                                   occasion = 'All';
                                   condition = 'All';
                                   price = 'All';
                                   sort = 'All';
                                   size = 'All';
                                   location = 'All';
                                });
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                "Discard",
                                style: TextStyle(color: Color(0xffFD8A00)),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
