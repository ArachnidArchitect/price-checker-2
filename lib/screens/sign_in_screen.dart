import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
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
                      TextSpan(text: 'Sign '),
                      TextSpan(
                        text: 'In',
                        style: TextStyle(color: Color(0xFF00BF63)),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32),
              TextField(
                style: GoogleFonts.poppins(), // Apply Poppins font for input text
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: GoogleFonts.poppins(), // Apply Poppins font for placeholder text
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF00BF63), // Green border
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF00BF63), // Green border
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black, // Black border when focused
                      width: 2.0,
                    ),
                  ),
                  floatingLabelStyle: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: Colors.black, // Black color for floating label
                    ),
                  ),
                ),
                cursorColor: Colors.black, // Black cursor line
              ),
              SizedBox(height: 10),
              TextField(
                style: GoogleFonts.poppins(), // Apply Poppins font for input text
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: GoogleFonts.poppins(), // Apply Poppins font for placeholder text
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF00BF63), // Green border
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF00BF63), // Green border
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black, // Black border when focused
                      width: 2.0,
                    ),
                  ),
                  floatingLabelStyle: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: Colors.black, // Black color for floating label
                    ),
                  ),
                ),
                obscureText: true,
                cursorColor: Colors.black, // Black cursor line
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/home');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF00BF63),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: Text(
                  'Sign In',
                  style: GoogleFonts.poppins(
                    color: Colors.white, // White text color for the button
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
