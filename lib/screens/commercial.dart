import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/database.dart';
import 'description.dart';

class Commercial extends StatefulWidget {
  const Commercial({super.key});

  @override
  State<Commercial> createState() => _CommercialState();
}

class _CommercialState extends State<Commercial> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  Stream? postStream;

  getPost() async {
    await databaseMethods.getCommercialPost().then((result) {
      postStream = result;
      print("working till industrial now");
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 103, 56),
        title: Center(
          child: Text(
            "Commercial Properties",
            style: GoogleFonts.roboto(
                textStyle: const TextStyle(color: Colors.white)),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            PropertyStream(postStream: postStream),
          ],
        ),
      ),
    );
  }
}

class PropertyStream extends StatelessWidget {
  const PropertyStream({
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
                  return Property(
                    image: snapshot.data.docs[index].data()["image"],
                    sector: snapshot.data.docs[index].data()["sector"],
                    area: snapshot.data.docs[index].data()["area"],
                    tag: snapshot.data.docs[index].data()["tag"],
                    category: snapshot.data.docs[index].data()["category"],
                  );
                })
            : const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class Property extends StatelessWidget {
  const Property({
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
