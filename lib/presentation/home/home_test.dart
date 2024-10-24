import 'package:flutter/material.dart';


class PhotoGalleryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'YoLoApp',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/thai.jpg'), // Profile image
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search all photos',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ChoiceChip(
                      label: Text('Image'),
                      selected: true,
                    ),
                    SizedBox(width: 10),
                    ChoiceChip(
                      label: Text('Video'),
                      selected: false,
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('See all'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                itemCount: 15, // Replace with actual photo count
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/dog$index.jpg', // Replace with actual images
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}