import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tronicassociates/screens/commercial.dart';
import 'package:tronicassociates/screens/description.dart';
import 'package:tronicassociates/screens/industrial.dart';
import 'package:tronicassociates/screens/profile.dart';
import 'package:tronicassociates/screens/residential.dart';
import 'package:tronicassociates/services/database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  Stream? postStream;

  getPost() async {
    await databaseMethods.getResidentialPost().then((result) {
      postStream = result;
      print("working till home screen now");
      setState(() {});
    });
  }

  @override
  void initState() {
    getPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const SizedBox(
              height: 25,
            ),
            const AppBar(),
            const WelcomeHead(),
            const Categories(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Industrial()));
                        },
                        child: Container(
                          // height: 30,
                          // width: 60,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 103, 56),
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Center(
                                child: Text(
                              "Industrial",
                              style: GoogleFonts.abel(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            )),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Commercial()));
                        },
                        child: Container(
                          // height: 30,
                          // width: 60,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 103, 56),
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Center(
                                child: Text(
                              "Commercial",
                              style: GoogleFonts.abel(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            )),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Residential()));
                        },
                        child: Container(
                          // height: 30,
                          // width: 60,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 103, 56),
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Center(
                                child: Text(
                              "Residential",
                              style: GoogleFonts.abel(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            )),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Popular(),
            PopularPropertyStream(postStream: postStream),

            // const PopularProperty(
            //   image: "assets/images/image1.jpg",
            // ),
            // const PopularProperty(
            //   image: "assets/images/image2.jpg",
            // ),
            // const PopularProperty(
            //   image: "assets/images/image3.jpg",
            // ),
            // const PopularProperty(
            //   image: "assets/images/image4.jpg",
            // ),
            // const PopularProperty(
            //   image: "assets/images/image5.jpg",
            // ),
            // const PopularProperty(
            //   image: "assets/images/image6.jpg",
            // ),
            // const PopularProperty(
            //   image: "assets/images/image7.jpg",
            // ),
            // const PopularProperty(
            //   image: "assets/images/image8.jpg",
            // ),
            // const PopularProperty(
            //   image: "assets/images/image9.jpg",
            // ),
            // const PopularProperty(
            //   image: "assets/images/image10.jpg",
            // ),
          ],
        ),
      ),
    );
  }
}

class PopularPropertyStream extends StatelessWidget {
  const PopularPropertyStream({
    Key? key,
    required this.postStream,
  }) : super(key: key);

  final Stream? postStream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<dynamic>(
      stream: postStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const ScrollPhysics(),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return PopularProperty(
                    image: snapshot.data.docs[index].data()["image"],
                    sector: snapshot.data.docs[index].data()["sector"],
                    area: snapshot.data.docs[index].data()["area"],
                    tag: snapshot.data.docs[index].data()["tag"],
                    category: snapshot.data.docs[index].data()["category"],
                  );
                })
            : const CircularProgressIndicator();
      },
    );
  }
}

class PopularProperty extends StatelessWidget {
  const PopularProperty({
    Key? key,
    required this.image,
    required this.sector,
    required this.area,
    required this.category,
    required this.tag,
  }) : super(key: key);

  final String image, sector, area, category, tag;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Description(
                      image: image,
                      sector: sector,
                      area: area,
                      category: category,
                      tag: tag,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Hero(
          tag: image,
          child: Card(
            elevation: 5,
            child: Stack(
              children: [
                Container(
                  width: size.width * 1,
                  height: 250,
                  decoration: const BoxDecoration(
                    // image: DecorationImage(
                    //     image: Image.network(image), fit: BoxFit.fill),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: Image.network(
                    image,
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.only(
                            // topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        tag,
                        style: GoogleFonts.roboto(
                            textStyle: const TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: 40,
                        width: size.width * 1,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.85),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    sector,
                                    style: GoogleFonts.roboto(
                                        textStyle: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Text(
                                    area,
                                    style: GoogleFonts.roboto(
                                        textStyle: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Text(
                                    category,
                                    style: GoogleFonts.roboto(
                                        textStyle: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 255, 103, 56))),
                                  ),
                                ],
                              ),
                              // const Spacer(),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     Text(
                              //       "3600 sq m",
                              //       style: GoogleFonts.roboto(
                              //           textStyle: const TextStyle(
                              //               fontWeight: FontWeight.bold)),
                              //     ),
                              //     Text(
                              //       "Call Now",
                              //       style: GoogleFonts.roboto(
                              //           textStyle: const TextStyle(
                              //               fontWeight: FontWeight.bold,
                              //               color: Color.fromARGB(
                              //                   255, 255, 103, 56))),
                              //     ),
                              //   ],
                              // )
                            ],
                          ),
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Popular extends StatelessWidget {
  const Popular({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: [
          Text(
            "Popular",
            style: GoogleFonts.playfairDisplay(
                textStyle: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black)),
          ),
        ],
      ),
    );
  }
}

class CategoryList extends StatelessWidget {
  const CategoryList({
    Key? key,
    required this.category,
  }) : super(key: key);

  final String category;
  void onPressed() {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        // height: 30,
        // width: 60,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 103, 56),
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Center(
              child: Text(
            category,
            style: GoogleFonts.abel(
                textStyle: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white)),
          )),
        ),
      ),
    );
  }
}

class Categories extends StatelessWidget {
  const Categories({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Text(
            "Intrested In",
            style: GoogleFonts.playfairDisplay(
                textStyle: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black)),
          ),
        ],
      ),
    );
  }
}

class WelcomeHead extends StatelessWidget {
  const WelcomeHead({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Profile())),
          child: Column(
            children: [
              Text(
                "Welcome To",
                style: GoogleFonts.playfairDisplay(
                    textStyle: const TextStyle(
                        color: Color.fromARGB(255, 255, 103, 56),
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Tronica Associates",
                style: GoogleFonts.playfairDisplay(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 28)),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Properties & Constructions",
                style: GoogleFonts.playfairDisplay(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14)),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        )
      ],
    );
  }
}

class AppBar extends StatelessWidget {
  const AppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset("assets/icons/menu.svg"),
          // ignore: avoid_unnecessary_containers
          Container(
            child: Row(children: [
              SvgPicture.asset("assets/icons/pin.svg"),
              const SizedBox(
                width: 5,
              ),
              Text(
                "Tronica City",
                style: GoogleFonts.inter(),
              ),
              const SizedBox(
                width: 5,
              ),
              SvgPicture.asset("assets/icons/arrow.svg"),
            ]),
          ),
          SvgPicture.asset("assets/icons/notification.svg"),
        ],
      ),
    );
  }
}
