import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xffcad2c5),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            Container(
              height: height * 0.40,
              width: width * 0.95,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.indigo.shade400
              ),
              child: Image.asset(
                'assets/icon.png'
              ),
            ),
            SizedBox(height: 50),
            Text(
              'Discover your \nDream job Here',
              style: GoogleFonts.zenKurenaido(
                fontSize: 30,
                fontWeight: FontWeight.w500,
                height: 1.3
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12),
            Text(
              'Lorem ipsum dolor sit amet, consectetur \nadipiscing elit Morbi fermentum nulla metus.',
              style: GoogleFonts.habibi(
                height: 1.3,
                fontSize: 15
              ),
              textAlign: TextAlign.center,
            ),
            Spacer(),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: CustomPaint(
                    foregroundPainter: MyPainter(),
                    child: SizedBox(
                      height: 225,
                      width: width,
                    ),
                  ),
                ),
                GestureDetector(
                 onTap: () {
                   Navigator.of(context).pushNamed('login_page');
                 },
                  child: Container(
                    margin: EdgeInsets.only(top: 60),
                    height: 55,
                    alignment: Alignment.center,
                    width: 230,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffedede9)
                    ),
                    child: Text(
                      'Continue',
                      style: GoogleFonts.balooBhaijaan2(
                        fontSize: 20
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint brush1 = Paint();
    Paint brush2 = Paint();

    brush1.color = Color(0xff8d99ae).withOpacity(0.7);
    brush1.strokeWidth = 5;
    brush1.style = PaintingStyle.fill;

    brush2.color = Color(0xff2b2d42).withOpacity(0.8);
    brush2.strokeWidth = 5;
    brush2.style = PaintingStyle.fill;

    Path path1 = Path();
    Path path2 = Path();

    path1.moveTo(0, size.height * 0.15);
    path1.quadraticBezierTo(size.width * 0.10, size.height * 0.25,
        size.width * 0.20, size.height * 0.15);
    path1.quadraticBezierTo(size.width * 0.30, size.height * 0.05,
        size.width * 0.40, size.height * 0.15);
    path1.quadraticBezierTo(size.width * 0.50, size.height * 0.25,
        size.width * 0.60, size.height * 0.15);
    path1.quadraticBezierTo(size.width * 0.70, size.height * 0.05,
        size.width * 0.80, size.height * 0.15);
    path1.quadraticBezierTo(
        size.width * 0.90, size.height * 0.25, size.width, size.height * 0.15);
    path1.lineTo(size.width, size.height);
    path1.lineTo(0, size.height);
    path1.close();

    path2.moveTo(0, size.height * 0.20);
    path2.quadraticBezierTo(size.width * 0.10, size.height * 0.05,
        size.width * 0.20, size.height * 0.20);
    path2.quadraticBezierTo(size.width * 0.30, size.height * 0.35,
        size.width * 0.40, size.height * 0.20);
    path2.quadraticBezierTo(size.width * 0.50, size.height * 0.05,
        size.width * 0.60, size.height * 0.20);
    path2.quadraticBezierTo(size.width * 0.70, size.height * 0.35,
        size.width * 0.80, size.height * 0.20);
    path2.quadraticBezierTo(
        size.width * 0.90, size.height * 0.05, size.width, size.height * 0.20);
    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    path2.close();

    canvas.drawPath(path1, brush1);
    canvas.drawPath(path2, brush2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
