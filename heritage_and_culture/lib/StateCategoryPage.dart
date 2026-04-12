import 'package:flutter/material.dart';
import 'HistoricalHeritagePage.dart';
import 'TraditionalArtsPage.dart';
import 'FestivalsPage.dart';
import 'DanceMusicPage.dart';
import 'LanguageLiteraturePage.dart';
// import 'TraditionsCustomsPage.dart';
import 'CulinaryHeritagePage.dart';

class StateCategoryPage extends StatelessWidget {
  final String stateName;

  StateCategoryPage({super.key, required this.stateName});

  final List<Map<String, String>> categories = [
    {
      "title": "Historical and Heritage Sites",
      "image": "assets/Cat_image/historical_heritage.png"
    },
    {
      "title": "Traditional Arts and Crafts",
      "image": "assets/Cat_image/traditional_arts.jpeg"
    },
    {
      "title": "Festivals and Cultural Celebrations",
      "image": "assets/Cat_image/festivals.jpg"
    },
    {
      "title": "Classical Dance and Music",
      "image": "assets/Cat_image/traditional_dance _music.jpg"
    },
    {
      "title": "Language and Literature",
      "image": "assets/Cat_image/language_literature.png"
    },
    // {
    //   "title": "Unique Traditions and Customs",
    //   "image": "assets/Cat_image/traditions_customs.jpg"
    // },
    {
      "title": "Culinary Heritage",
      "image": "assets/Cat_image/culinary_heritage.jpg"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(stateName),
        backgroundColor: const Color(0xFFF5A623),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 16,
            childAspectRatio: 0.82,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Widget page;
                switch (index) {
                  case 0:
                    page = HistoricalHeritagePage(stateName: stateName);
                    break;
                  case 1:
                    page = TraditionalArtsPage(stateName: stateName);
                    break;
                  case 2:
                    page = FestivalsPage(stateName: stateName);
                    break;
                  case 3:
                    page = DanceMusicPage(stateName: stateName);
                    break;
                  case 4:
                    page = LanguageLiteraturePage(stateName: stateName);
                    break;
                  case 5:
                    page = CulinaryHeritagePage(stateName: stateName);
                    break;
                  default:
                    return;
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => page),
                );
              },
              child: Card(
                color: const Color.fromARGB(179, 245, 165, 35),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            categories[index]["image"]!,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        categories[index]["title"]!,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          height: 1.1,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
