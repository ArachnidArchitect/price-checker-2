import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),  // Adjust the height as needed
        child: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(top: 16.0),  // Add margin/padding here
            child: Text(
              'ECHO',
              style: TextStyle(
                color: Color(0xFF00BF63),
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontFamily: 'Roboto Condensed',
                fontSize: 28,
              ),
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Find the Best Prices, Right Now!',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Image.network(
              'https://leahbasson.github.io/MyImages/projects/store-logos.png',
              fit: BoxFit.contain,
              height: 50,
            ),
            SizedBox(height: 16),
            TextField(
              cursorColor: Colors.black,  // Set cursor color to black
              style: GoogleFonts.poppins(),  // Apply Poppins font for input text
              decoration: InputDecoration(
                hintText: 'e.g Full cream milk',
                hintStyle: GoogleFonts.poppins(),  // Apply Poppins font for placeholder text
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),  // More rounded corners
                  borderSide: BorderSide(
                    color: Color(0xFF00BF63),  // Green border
                    width: 2.0,
                  ),
                ),
                prefixIcon: Icon(Icons.search, color: Color(0xFF00BF63)),  // Green icon
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  borderSide: BorderSide(
                    color: Color(0xFF00BF63),
                    width: 2.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  borderSide: BorderSide(
                    color: Color(0xFF00BF63),
                    width: 2.0,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'No products added yet.',
                  style: TextStyle(fontFamily: 'Roboto Condensed'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
