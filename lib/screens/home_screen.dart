import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(top: 16.0),
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
              controller: _searchController,
              cursorColor: Colors.black,
              style: GoogleFonts.poppins(),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                hintText: 'e.g Full cream milk',
                hintStyle: GoogleFonts.poppins(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  borderSide: BorderSide(
                    color: Color(0xFF00BF63),
                    width: 2.0,
                  ),
                ),
                prefixIcon: Icon(Icons.search, color: Color(0xFF00BF63)),
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
            SizedBox(height: 16),
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance
      .collection('checkers_products')
      .snapshots(),
  builder: (context, snapshot) {
    if (snapshot.hasError) {
      print('Error: ${snapshot.error}');
      return Center(child: Text('Error: ${snapshot.error}'));  // To show actual error
    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator(
                        color: Color(0xFF00BF63),
                      ));
                    }

                  var products = snapshot.data!.docs;
                  
                  // Filter products based on search query
                  if (_searchQuery.isNotEmpty) {
                    products = products.where((doc) {
                      final data = doc.data() as Map<String, dynamic>;
                      final name = data['name'].toString().toLowerCase();
                      return name.contains(_searchQuery);
                    }).toList();
                  }

                  if (products.isEmpty) {
                    return Center(
                      child: Text(
                        'No products found.',
                        style: TextStyle(fontFamily: 'Roboto Condensed'),
                      ),
                    );
                  }

return ListView.builder(
  itemCount: products.length,
  itemBuilder: (context, index) {
    final data = products[index].data() as Map<String, dynamic>;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Product Image
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(data['image_url'] ?? 'placeholder_url'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(width: 12),

          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data['name'] ?? 'Unknown Product',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Flavored Ice Cream 1L', // You can dynamically add this if available
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),

          // Price & Store Logo
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'R${double.tryParse(data['price']?.toString() ?? '0')?.toStringAsFixed(2) ?? '0.00'}',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00BF63),
                ),
              ),
              SizedBox(height: 4),
              Image.asset(
                'assets/store_logos/${data['store']}.png',
                width: 30,
                height: 30,
              ),
            ],
          ),
        ],
      ),
    );
  },
);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}