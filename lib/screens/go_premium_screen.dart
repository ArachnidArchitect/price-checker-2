import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GoPremiumScreen extends StatelessWidget {
  const GoPremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
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
                Text(
                  'Premium',
                  style: TextStyle(
                    color: Colors.black, // Black text color
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto Condensed',
                    fontSize: 36,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Unlock exclusive features and get the best prices first with Premium—your smarter way to save!',
                    style: GoogleFonts.poppins(
                      color: Colors.black, // Black text color
                      fontSize: 18, // Adjust the font size as needed
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            'Stay Freemium',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            height: 250, // Fixed height to ensure both containers are the same size
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 2.0),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '• 5 searches per day to find the best prices',
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.poppins(color: Colors.black),
                                ),
                                Text(
                                  '• Create up to 3 shopping lists',
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.poppins(color: Colors.black),
                                ),
                                Text(
                                  '• Basic price comparisons for popular stores',
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.poppins(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            'Premium',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: Color(0xFF00BF63),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            height: 250, // Fixed height to ensure both containers are the same size
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFF00BF63), width: 2.0),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '• Unlimited searches to find deals anytime',
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.poppins(color: Colors.black),
                                ),
                                Text(
                                  '• Unlimited shopping lists',
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.poppins(color: Colors.black),
                                ),
                                Text(
                                  '• Access to exclusive deals and discounts',
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.poppins(color: Colors.black),
                                ),
                                Text(
                                  '• Price drop alerts on favorite items',
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.poppins(color: Colors.black),
                                ),
                                Text(
                                  '• Ad-free browsing',
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.poppins(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/home');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black, // Black background color
                          padding: EdgeInsets.symmetric(horizontal: 10,
                              vertical: 15),
                        ),
                        child: Text(
                          'Back to home',
                          style: GoogleFonts.poppins(
                            color: Colors.white, // White text color
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle the "Coming soon!" button press
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF00BF63), // Green background color
                          padding: EdgeInsets.symmetric(horizontal: 10,
                              vertical: 15),
                        ),
                        child: Text(
                          'Coming soon!',
                          style: GoogleFonts.poppins(
                            color: Colors.white, // White text color
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
