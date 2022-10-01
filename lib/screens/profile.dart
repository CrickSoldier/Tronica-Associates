import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              FullScreen(size: size),
              BackgroundImage(size: size),
              Positioned(
                top: 50,
                left: 25,
                child: GestureDetector(
                  onTap: (() => Navigator.pop(context)),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(child: Image.asset("assets/icons/back.png")),
                  ),
                ),
              ),
              Info(size: size),
              ProfileImage(),
            ],
          ),
          Spacer(),
          Row(
            children: [
              Container(
                height: 70,
                width: size.width * .6,
                // width: 200,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 103, 56),
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(20))),
                child: Center(
                    child: Text(
                  "Call Now",
                  style: GoogleFonts.abel(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                )),
              ),
              Container(
                height: 70,
                width: size.width * .4,
                // width: 200,
                // decoration: BoxDecoration(
                //     color: Color.fromARGB(255, 255, 103, 56),
                //     borderRadius: BorderRadius.circular(20)),
                child: Center(
                    child: Text(
                  "Office Direction",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.abel(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                )),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 200,
        left: 1,
        right: 1,
        child: CircleAvatar(
          radius: 50,
          foregroundImage: AssetImage("assets/images/profile.png"),
        ));
  }
}

class Info extends StatelessWidget {
  const Info({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 250,
      right: 1,
      left: 1,
      bottom: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Container(
          height: size.height * 6,
          width: size.width * .9,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.blue.withOpacity(.5),
                blurRadius: 20.0,
                offset: Offset(1, 1)),
          ], color: Colors.white, borderRadius: BorderRadius.circular(30)),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                "Tronica",
                style: GoogleFonts.playfairDisplay(
                    textStyle:
                        TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
              ),
              Text(
                "Associates",
                style: GoogleFonts.playfairDisplay(
                    textStyle:
                        TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: Center(
                  child: Text(
                    "Sector D1,  Opposite to  Tronica Police Choki,   Delhi- Tronica City Road",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.abel(
                        textStyle: TextStyle(
                      fontSize: 14,
                    )),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.workspace_premium_outlined,
                          color: Color.fromARGB(255, 255, 103, 56),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "1996-Present",
                          style: GoogleFonts.abel(
                              textStyle: TextStyle(fontSize: 14)),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.timer,
                          color: Color.fromARGB(255, 255, 103, 56),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "10am - 9pm",
                          style: GoogleFonts.abel(
                              textStyle: TextStyle(fontSize: 14)),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star_rate_rounded,
                          color: Color.fromARGB(255, 255, 103, 56),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "5.0",
                          style: GoogleFonts.abel(
                              textStyle: TextStyle(fontSize: 14)),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => {},
                    child: Text("9871773818"),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color.fromARGB(255, 255, 103, 56),
                      disabledForegroundColor: Colors.grey.withOpacity(0.38),
                      disabledBackgroundColor: Colors.grey.withOpacity(0.12),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => {},
                    child: Text("9711661436"),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color.fromARGB(255, 255, 103, 56),
                      disabledForegroundColor: Colors.grey.withOpacity(0.38),
                      disabledBackgroundColor: Colors.grey.withOpacity(0.12),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Center(
                  child: Text(
                    "Tronica Assocaites is most trusted Business entity in Tronica City. It was established in 1996 and serving its best for its customers till now.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.abel(
                        textStyle: TextStyle(
                      fontSize: 14,
                    )),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.check_box_rounded,
                          color: Colors.green,
                        ),
                        Text(
                          "Sell",
                          style: GoogleFonts.abel(
                              textStyle: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.check_box_rounded,
                          color: Colors.green,
                        ),
                        Text(
                          "Purchase",
                          style: GoogleFonts.abel(
                              textStyle: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.check_box_rounded,
                          color: Colors.green,
                        ),
                        Text(
                          "Rent",
                          style: GoogleFonts.abel(
                              textStyle: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.check_box_rounded,
                          color: Colors.green,
                        ),
                        Text(
                          "Construction",
                          style: GoogleFonts.abel(
                              textStyle: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * .4,
      child: Image.asset(
        "assets/images/image1.jpg",
        fit: BoxFit.fill,
      ),
    );
  }
}

class FullScreen extends StatelessWidget {
  const FullScreen({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * .85,
    );
  }
}
