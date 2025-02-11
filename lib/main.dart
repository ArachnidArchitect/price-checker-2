import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/onboarding_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/shopping_lists_screen.dart';
import 'screens/go_premium_screen.dart';
import 'screens/account_screen.dart';
import 'screens/sign_in_screen.dart'; // Import SignInScreen
import 'screens/cart_screen.dart'; // Import CartScreen

void main() {
  runApp(EchoApp());
}

class EchoApp extends StatelessWidget {
  const EchoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Echo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        textTheme: GoogleFonts.robotoCondensedTextTheme(),
      ),
      home: MainScreen(content: OnboardingScreen()), // Default to OnboardingScreen
      routes: {
        '/register': (context) => MainScreen(content: RegisterScreen()), // RegisterScreen within MainScreen
        '/home': (context) => MainScreen(content: HomeScreen()), // HomeScreen within MainScreen
        '/signin': (context) => MainScreen(content: SignInScreen()), // Add route for SignInScreen
        '/cart': (context) => MainScreen(content: CartScreen()), // Add route for CartScreen
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatefulWidget {
  final Widget content;

  const MainScreen({super.key, required this.content});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {  // Removed underscore from class name
  void _onItemTapped(int index) {
    setState(() {
      // Removed _selectedIndex since it's not being used to control widget display
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.content,
      bottomNavigationBar: BottomAppBar(
        color: Color.fromRGBO(0, 191, 99, 1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {
                _onItemTapped(0);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen(content: OnboardingScreen())),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.info, color: Colors.white),
              onPressed: () {
                _onItemTapped(1);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen(content: GoPremiumScreen())),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.list, color: Colors.white),
              onPressed: () {
                _onItemTapped(2);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen(content: ShoppingListsScreen())),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.shopping_cart, color: Colors.white),
              onPressed: () {
                _onItemTapped(3);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen(content: CartScreen())),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.account_circle, color: Colors.white),
              onPressed: () {
                _onItemTapped(4);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen(content: AccountScreen())),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}