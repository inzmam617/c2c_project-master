import 'package:c2c_project1/components/item_view_card.dart';
import 'package:c2c_project1/screens/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:select_form_field/select_form_field.dart';

final _firestore = FirebaseFirestore.instance;
List<dynamic> savedPostsList = [];

class Item {
  String title;
  String category;
  String place;

  Item({required this.title, required this.category, required this.place});
}

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {

  final List<Map<String, dynamic>> _category = [
    {
      'value': 'All',
      'label': 'All',
    },
    {
      'value': 'Suit',
      'label': 'Suit',
    },
    {
      'value': 'Lashkara',
      'label': 'Lashkara',
    },
    {
      'value': 'Patiala',
      'label': 'Patiala',
    },
    {
      'value': 'Plaazo',
      'label': 'Plaazo',
    },
    {
      'value': 'Saree',
      'label': 'Saree',
    },
  ];

  final List<Map<String, dynamic>> _colors = [
    {
      'value': 'All',
      'label': 'All',
    },
    {
      'value': 'Golden',
      'label': 'Golden',
    },
    {
      'value': 'Yellow',
      'label': 'Yellow',
    },
    {
      'value': 'Blue',
      'label': 'Blue',
    },
    {
      'value': 'Green',
      'label': 'Green',
    },
    {
      'value': 'Violet',
      'label': 'Violet',
    },
    {
      'value': 'Red',
      'label': 'Red',
    },
    {
      'value': 'Brown',
      'label': 'Brown',
    },
    {
      'value': 'Orange',
      'label': 'Orange',
    },
    {
      'value': 'Black',
      'label': 'Black',
    },
    {
      'value': 'Indigo',
      'label': 'Indigo',
    },
    {
      'value': 'White',
      'label': 'White',
    },
    {
      'value': 'Off-White',
      'label': 'Off-White',
    }
  ];

  final List<Map<String, dynamic>> _fabric = [
    {
      'value': 'All',
      'label': 'All',
    },
    {
      'value': 'Cotton',
      'label': 'Cotton',
    },
    {
      'value': 'Silk',
      'label': 'Silk',
    },
    {
      'value': 'Rayon',
      'label': 'Rayon',
    },
    {
      'value': 'Georgette',
      'label': 'Georgette',
    },
    {
      'value': 'Felt',
      'label': 'Felt',
    },
    {
      'value': 'Velvet',
      'label': 'Velvet',
    },
  ];

  final List<Map<String, dynamic>> _size = [
    {
      'value': 'All',
      'label': 'All',
    },
    {
      'value': 'XS',
      'label': 'XS',
    },
    {
      'value': 'S',
      'label': 'S',
    },
    {
      'value': 'M',
      'label': 'M',
    },
    {
      'value': 'L',
      'label': 'L',
    },
    {
      'value': 'XL',
      'label': 'XL',
    },
    {
      'value': 'XXL',
      'label': 'XXL',
    },
    {
      'value': 'XXXL',
      'label': 'XXXL',
    },
  ];

  final List<Map<String, dynamic>> _occasion = [
    {
      'value': 'All',
      'label': 'All',
    },
    {
      'value': 'Wedding',
      'label': 'Wedding',
    },
    {
      'value': 'Anniversary',
      'label': 'Anniversary',
    },
    {
      'value': 'Birthday',
      'label': 'Birthday',
    },
    {
      'value': 'Festival',
      'label': 'Festival',
    },
  ];

  final List<Map<String, dynamic>> _sort = [
    {
      'value': 'All',
      'label': 'All',
    },
    {
      'value': 'New Posts',
      'label': 'New Posts',
    },
    {
      'value': 'Old Posts',
      'label': 'Old Posts',
    },
  ];

  final List<Map<String, dynamic>> _price = [
    {
      'value': 'All',
      'label': 'All',
    },
    {
      'value': 'Low to High',
      'label': 'Low to High',
    },
    {
      'value': 'High to Low',
      'label': 'High to Low',
    },
  ];

  final List<Map<String, dynamic>> _condition = [
    {
      'value': 'All',
      'label': 'All',
    },
    {
      'value': 'Poor',
      'label': 'Poor',
    },
    {
      'value': 'Good',
      'label': 'Good',
    },
    {
      'value': 'Excellent',
      'label': 'Excellent',
    },
    {
      'value': 'Brand New',
      'label': 'Brand New',
    },
  ];

  bool value = false;
  String category = 'All';
  String fabric = 'All';
  String color = 'All';
  String occasion = 'All';
  String condition = 'All';
  String price = 'All';
  String sort = 'All';
  String size = 'All';
  String location = 'All';

  late TextButton button;

  TextEditingController textarea = TextEditingController();

  final SliverSimpleGridDelegate gridDelegate =
      const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3);

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
          .where('archive', isEqualTo: 'no')
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
          .where('archive', isEqualTo: 'no')
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
          .where('archive', isEqualTo: 'no')
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
          .where('archive', isEqualTo: 'no')
          .where('productCategory', isEqualTo: category)
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
          .where('archive', isEqualTo: 'no')
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
          .where('archive', isEqualTo: 'no')
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
          .where('archive', isEqualTo: 'no')
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
          .where('archive', isEqualTo: 'no')
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
          .where('archive', isEqualTo: 'no')
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
          .where('archive', isEqualTo: 'no')
          .where('materialCondition', isEqualTo: condition)
          .orderBy('time', descending: true)
          .snapshots();
    }

    // Location is left

    if ((category != 'All') && (color != 'All') && (fabric == 'All')) {
      return _firestore
          .collection('Posts')
          .where('archive', isEqualTo: 'no')
          .where('productCategory', isEqualTo: category)
          .where('color', isEqualTo: color)
          .orderBy('time', descending: true)
          .snapshots();
    }

    if ((category != 'All') && (color == 'All') && (fabric != 'All')) {
      return _firestore
          .collection('Posts')
          .where('archive', isEqualTo: 'no')
          .where('productCategory', isEqualTo: category)
          .where('fabric', isEqualTo: fabric)
          .orderBy('time', descending: true)
          .snapshots();
    }

    if (color != 'All' && category == 'All' && fabric != 'All') {
      return _firestore
          .collection('Posts')
          .where('archive', isEqualTo: 'no')
          .where('color', isEqualTo: color)
          .where('fabric', isEqualTo: fabric)
          .orderBy('time', descending: true)
          .snapshots();
    }
  }

  ifSaved() async {
    try {
      var userData = await FirebaseFirestore.instance
          .collection("userProfile")
          .doc(user?.uid)
          .get();

      savedPostsList = userData.get('savedPosts');
    } catch (e) {
      //print(e);
    }
  }

  requestNotificationPermission() async {
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  @override
  void initState() {
    ifSaved();
    savedPostsList;
    requestNotificationPermission();
    super.initState();
  }

  String searchItem = '';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    showSearch(
                        context: context,
                        // delegate to customize the search bar
                        delegate: CustomSearchDelegate());
                  },
                  child: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  'xCloset',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Ubuntu",
                  ),
                ),
                TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text("Set Your Preference"),
                          content: StatefulBuilder(
                            builder: (BuildContext context,
                                void Function(void Function()) setState) {
                              return SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                child: ListView(
                                  children: [
                                    SelectFormField(
                                      type: SelectFormFieldType
                                          .dropdown, // or can be dialog
                                      initialValue: category,
                                      labelText: 'Category',
                                      items: _category,
                                      onChanged: (category) {
                                        setState(() {
                                          this.category = category;
                                        });
                                      },
                                    ),
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    SelectFormField(
                                      type: SelectFormFieldType
                                          .dropdown, // or can be dialog
                                      initialValue: color,
                                      labelText: 'Color',
                                      items: _colors,
                                      onChanged: (color) {
                                        setState(() {
                                          this.color = color;
                                        });
                                      },
                                    ),
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    SelectFormField(
                                      type: SelectFormFieldType
                                          .dropdown, // or can be dialog
                                      initialValue: fabric,
                                      labelText: 'Fabric',
                                      items: _fabric,
                                      onChanged: (fabric) {
                                        setState(() {
                                          this.fabric = fabric;
                                        });
                                      },
                                    ),
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    SelectFormField(
                                      type: SelectFormFieldType
                                          .dropdown, // or can be dialog
                                      initialValue: occasion,
                                      labelText: 'Occasion',
                                      items: _occasion,
                                      onChanged: (occasion) {
                                        setState(() {
                                          this.occasion = occasion;
                                        });
                                      },
                                    ),
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    SelectFormField(
                                      type: SelectFormFieldType
                                          .dropdown, // or can be dialog
                                      initialValue: size,
                                      labelText: 'Size',
                                      items: _size,
                                      onChanged: (size) {
                                        setState(() {
                                          this.size = size;
                                        });
                                      },
                                    ),
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    SelectFormField(
                                      type: SelectFormFieldType
                                          .dropdown, // or can be dialog
                                      initialValue: condition,
                                      labelText: 'Condition',
                                      items: _condition,
                                      onChanged: (condition) {
                                        setState(() {
                                          this.condition = condition;
                                        });
                                      },
                                    ),
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    SelectFormField(
                                      type: SelectFormFieldType.dropdown,
                                      initialValue: location,
                                      labelText: 'Location',
                                      items: _category, // TO BE CHANGED
                                      onChanged: (location) {
                                        setState(() {
                                          this.location = location;
                                        });
                                      },
                                    ),
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    SelectFormField(
                                      type: SelectFormFieldType.dropdown,
                                      initialValue: sort,
                                      labelText: 'Sort by',
                                      items: _sort,
                                      onChanged: (sort) {
                                        setState(() {
                                          this.sort = sort;
                                        });
                                      },
                                    ),
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    SelectFormField(
                                      type: SelectFormFieldType
                                          .dropdown, // or can be dialog
                                      initialValue: price,
                                      labelText: 'Price',
                                      items: _price,
                                      onChanged: (price) {
                                        setState(() {
                                          this.price = price;
                                        });
                                      },
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          category = 'All';
                                          color = 'All';
                                          fabric = 'All';
                                          color = 'All';
                                          occasion = 'All';
                                          size = 'All';
                                          price = 'All';
                                          condition = 'All';
                                          sort = 'All';
                                        });
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Set as default'),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                          actions: <Widget>[
                            button = TextButton(
                              onPressed: () {
                                setState(() {
                                  category;
                                  color;
                                  fabric;
                                  occasion;
                                  size;
                                  sort;
                                  price;
                                  condition;
                                  location;
                                });
                                Navigator.of(context).pop();
                              },
                              child: const Text("Save"),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.filter_list,
                      color: Colors.white,
                    )),
              ],
            ),
          ),
          body: SafeArea(
            child: StreamBuilder<QuerySnapshot>(
                stream: getStream(),
                builder: (context, snapshot) {
                  try {
                    return (snapshot.connectionState == ConnectionState.waiting)
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : MasonryGridView.builder(
                            shrinkWrap: true,
                            crossAxisSpacing: 1,
                            mainAxisSpacing: 1,
                            itemCount: snapshot.data?.docs.length,
                            gridDelegate: gridDelegate,
                            itemBuilder: (BuildContext context, int index) {
                              if (snapshot.hasData) {
                                final posts = snapshot.data?.docs;

                                List<ItemCardView> draftItems = [];

                                for (var post in posts!) {
                                  ifSaved();
                                  savedPostsList;
                                  draftItems.add(
                                    ItemCardView(
                                      title: post['title'],
                                      cost: post['cost'].toString(),
                                      imageUrl: post['images'][0],
                                      category: post['productCategory'],
                                      brand: post['brand'],
                                      color: post['color'],
                                      fabric: post['fabric'],
                                      pattern: post['pattern'],
                                      description: post['description'],
                                      owner: post['postedBy'],
                                      condition: post['materialCondition'],
                                      uID: post['uID'],
                                      address: post['address'],
                                      images: List<String>.from(post['images']),
                                      onSale: post['onSale'],
                                      docID: post.id,
                                      savedPost:
                                          savedPostsList.contains(post.id)
                                              ? true
                                              : false,
                                      postedOn: post['time'],
                                    ),
                                  );
                                }
                                return draftItems[index];
                              }
                              return Container();
                            });
                  } catch (e) {
                    // print(e);
                  }
                  return const Center(
                    child: Text('No Records Found'),
                  );
                }),
          ),
        ),
      );
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = [
    'Suit',
    'Wedding Gown',
    'Lehenga',
    'Patiala ',
    'Lashkara',
    'Saree',
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var match in searchTerms) {
      if (match.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(match);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}
