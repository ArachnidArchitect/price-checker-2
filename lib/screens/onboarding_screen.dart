import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            // Removed mainAxisAlignment.center to allow custom spacing from the top
            children: [
              // Add a SizedBox here to create more space above the title
              SizedBox(height: 60), // Adjust the height value as needed

              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Text(
                  'ECHO',
                  style: TextStyle(
                    color: Color(0xFF00BF63),
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Roboto Condensed',
                    fontSize: 36,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 48),
              Padding(
                padding: const EdgeInsets.only(top: 24.5),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    children: [
                      TextSpan(text: 'Welcome to '),
                      TextSpan(
                        text: 'Echo',
                        style: TextStyle(color: Color(0xFF00BF63)),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: RichText(
                  text: TextSpan(
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    children: [
                      TextSpan(
                        text: 'Compare Prices Across ',
                        style: TextStyle(color: Color(0xFF00BF63)),
                      ),
                      TextSpan(
                        text: 'Top Stores',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32),
              Text(
                'Easily compare prices across Checkers, Pick n Pay, Woolworths, Spar, and Shoprite daily. Make informed decisions and shop smarter!',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 32),
              Image.network(
                'https://leahbasson.github.io/MyImages/projects/store-logos.png',
                fit: BoxFit.contain,
                height: 50,
              ),
              SizedBox(height: 32),
              RichText(
                text: TextSpan(
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  children: [
                    TextSpan(
                      text: 'Save Your ',
                      style: TextStyle(color: Color(0xFF00BF63)),
                    ),
                    TextSpan(
                      text: 'Favourite ',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: 'Items',
                      style: TextStyle(color: Color(0xFF00BF63)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Track your go-to products effortlessly and quickly check their prices across stores, saving you even more time.',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 24),
              RichText(
                text: TextSpan(
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  children: [
                    TextSpan(
                      text: 'Simple ',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: 'and Intuitive Search',
                      style: TextStyle(color: Color(0xFF00BF63)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Use the search bar to find products quickly and see how prices stack up across all five stores in real-time.',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              SizedBox(height: 32),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/register');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Create an ',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Text(
                        'account',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Color(0xFF00BF63),
                            decoration: TextDecoration.none, // No underline
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
