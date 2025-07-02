import 'package:flutter/material.dart';
import 'package:testapp/TeamInfo.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About App',
          style: TextStyle(color: Colors.white), // Set text color to white
        ),
        backgroundColor: const Color(0xFFF5A623), // Set AppBar color
      ),
      backgroundColor: Colors.white, // Set background color to white
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'App Name: Sanskriti Yatra',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Version: 1.0.0',
              style: TextStyle(fontSize: 25),
            ),
            const SizedBox(height: 10),
            const Text(
              'Description:',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              """
                    Sanskriti Yatra 
- A Journey Through India's Glorious Heritage
    Introduction
      
      -Sanskriti Yatra is a unique and immersive mobile application designed to take users on a captivating journey through India’s rich heritage, traditions, and cultural diversity. Whether you are a history enthusiast, a travel lover, or someone eager to connect with the roots of Indian civilization, this app serves as a digital gateway to explore the country’s magnificent past and vibrant traditions.
      
      -The name "Sanskriti Yatra" is derived from two Sanskrit words:-

-Sanskriti (संस्कृति) – meaning culture, tradition, and heritage. It represents the values, customs, art, and historical legacy passed down through generations in India.

-Yatra (यात्रा) – meaning journey, pilgrimage, or expedition. This signifies the travel aspect, as the app takes users on a virtual or real-world journey to various heritage sites and cultural experiences. 
      
      -Together, Sanskriti Yatra means a "Journey through Culture," perfectly capturing the essence of exploring India’s timeless heritage and traditions.
      
# --Features of Sanskriti Yatra

      1. Explore Heritage Sites
            The app provides detailed insights into India’s UNESCO World Heritage Sites, ancient temples, forts, palaces, caves, and historical landmarks. Users can browse through categories like architecture, dynasties, religious sites, and archaeological wonders.

      2. Cultural Festivals & Traditions
            The app provides information on India’s diverse festivals, traditional art forms, classical dances, and folk music. Users can explore stories behind Holi, Diwali, Navratri, Pongal, and many other cultural celebrations.

      3. Stories & Legends
            The app features fascinating myths, legends, and folklore associated with different historical sites and cultural practices, making learning about India's past engaging and enjoyable.

      4. Traditional Dance & Music Library
            Sanskriti Yatra includes an exclusive collection of videos and music that showcase India’s traditional dance forms like Bharatanatyam, Kathak, Odissi, and folk dances like Bhangra and Garba. Users can watch performances, learn about their history, and listen to classical and folk music from different regions of India.

      5. Traditional Cuisine & Culinary Heritage
            Users can explore the rich culinary traditions of different regions of India. From the royal kitchens of Rajasthan to the street food of Kolkata, Sanskriti Yatra provides recipes, histories, and cultural significance of various Indian dishes.

      6. Heritage Walks & Guided Audio Tours
            For those who love to experience history firsthand, the app offers self-guided heritage walks and expert-curated audio tours for famous historical sites. These features provide storytelling, historical facts, and deep insights into places like Jaipur, Varanasi, Hampi, and Delhi.

      7. Workshops & Learning Modules
            Users can access workshops on traditional arts like Madhubani painting, Kathak dance, Hindustani music, and Sanskrit scriptures. Educational resources make it an ideal platform for students and researchers.

      8. Language & Accessibility
            Available in multiple Indian languages, the app ensures inclusivity and accessibility for people from diverse linguistic backgrounds.""",
              style: TextStyle(fontSize: 25),
              textAlign: TextAlign.justify, // Justify the text
            ),
            const SizedBox(height: 10),
            const Text(
              """
Developer: 
              Yash Raj (12201115)
              Saumya Mihir (1220)
              Anuskha Ranjan(1220)
          """,
              style: TextStyle(fontSize: 28),
              // textAlign: TextAlign.justify, // Justify the text
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TeamPage(), // Navigate to TeamPage
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF5A623), // Button color
                ),
                child: const Text(
                  'More Info',
                  style: TextStyle(color: Colors.white), // Button text color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
