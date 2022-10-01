import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Description extends StatefulWidget {
  const Description(
      {super.key,
      required this.image,
      required this.sector,
      required this.area,
      required this.category,
      required this.tag});
  final String image, sector, area, category, tag;

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        backgroundColor: Colors.green,
        child: const Icon(Icons.call),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PropertyImageHeader(
            size: size,
            image: widget.image,
            tag: widget.tag,
          ),
          PropertyInfo(
            sector: widget.sector,
            area: widget.area,
          ),
          Category(
            size: size,
            category: widget.category,
          ),
          const Spacer(),
          Row(
            children: [
              Container(
                width: size.width * .7,
                height: size.width * .2,
                decoration: const BoxDecoration(
                    color: Colors.red,
                    // border: Border.all(color: Colors.white, width: 2),
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(20))),
                child: TextButton(
                    onPressed: () => {},
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Enquiry Now",
                        style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                                color: Colors.white,
                                // fontWeight: FontWeight.bold,
                                fontSize: 28)),
                      ),
                    )),
              ),
              // Container(
              //   width: size.width * .3,
              //   height: size.width * .2,
              //   decoration: BoxDecoration(
              //       color: Colors.red,
              //       border: Border.all(color: Colors.white, width: 2),
              //       borderRadius:
              //           BorderRadius.only(topLeft: Radius.circular(20))),
              //   child: TextButton(
              //       onPressed: () => {},
              //       child: Padding(
              //         padding: const EdgeInsets.all(10.0),
              //         child: Text(
              //           "Call",
              //           style: GoogleFonts.roboto(
              //               textStyle: TextStyle(
              //                   color: Colors.white,
              //                   fontWeight: FontWeight.bold,
              //                   fontSize: 28)),
              //         ),
              //       )),
              // )
            ],
          )
        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  const Category({
    Key? key,
    required this.size,
    required this.category,
  }) : super(key: key);

  final Size size;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: size.height * .05,
        width: size.width * .6,
        decoration: BoxDecoration(
            color: Colors.orange, borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Text(
            category,
            style: GoogleFonts.roboto(
                textStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24)),
          ),
        ),
      ),
    );
  }
}

class PropertyInfo extends StatelessWidget {
  const PropertyInfo({
    Key? key,
    required this.sector,
    required this.area,
  }) : super(key: key);

  final String sector, area;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            sector,
            style: GoogleFonts.roboto(
                textStyle:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
          ),
          Text(
            area,
            style: GoogleFonts.roboto(
                textStyle:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
          )
        ],
      ),
    );
  }
}

class PropertyImageHeader extends StatelessWidget {
  const PropertyImageHeader({
    Key? key,
    required this.size,
    required this.image,
    required this.tag,
  }) : super(key: key);

  final Size size;
  final String image, tag;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: size.height * .7,
          // decoration: BoxDecoration(
          //     color: Colors.green,
          //     borderRadius: BorderRadius.only(
          //         bottomLeft: Radius.circular(30),
          //         bottomRight: Radius.circular(30))),
        ),
        Container(
          height: size.height * .65,
          width: double.infinity,
          decoration: BoxDecoration(
              color: const Color.fromARGB(179, 0, 183, 255).withOpacity(.2),
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35))),
          child: Hero(
            tag: image,
            child: Image.network(
              image,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
          top: 50,
          left: 25,
          child: GestureDetector(
            onTap: (() => Navigator.pop(context)),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Center(child: Image.asset("assets/icons/back.png")),
            ),
          ),
        ),
        // Positioned(
        //   top: 50,
        //   right: 25,
        //   child: Container(
        //     height: 40,
        //     width: 40,
        //     decoration: BoxDecoration(
        //         color: Colors.white, borderRadius: BorderRadius.circular(10)),
        //   ),
        // ),
        Positioned(
          bottom: 10,
          left: 120,
          right: 120,
          child: Center(
            child: Container(
              height: size.height * .065,
              width: size.width * .25,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.orange, width: 2)),
              child: Center(
                  child: Text(
                tag,
                style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
              )),
            ),
          ),
        ),
      ],
    );
  }
}
