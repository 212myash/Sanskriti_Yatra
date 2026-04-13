import 'package:flutter/material.dart';
import 'StateHeritageListPage.dart';

class StateCategoryPage extends StatelessWidget {
  final String stateName;

  StateCategoryPage({super.key, required this.stateName});

  final List<Map<String, String>> categories = [
    {
      "title": "Historical and Heritage Sites",
      "subtitle": "Forts, temples and timeless landmarks",
      "image": "assets/Cat_image/historical_heritage.png"
    },
    {
      "title": "Traditional Arts and Crafts",
      "subtitle": "Handmade art forms and local craft styles",
      "image": "assets/Cat_image/traditional_arts.jpeg"
    },
    {
      "title": "Festivals and Cultural Celebrations",
      "subtitle": "Seasonal traditions and community events",
      "image": "assets/Cat_image/festivals.jpg"
    },
    {
      "title": "Classical Dance and Music",
      "subtitle": "Performing arts and musical heritage",
      "image": "assets/Cat_image/traditional_dance _music.jpg"
    },
    {
      "title": "Language and Literature",
      "subtitle": "Scripts, stories and literary identity",
      "image": "assets/Cat_image/language_literature.png"
    },
    // {
    //   "title": "Unique Traditions and Customs",
    //   "image": "assets/Cat_image/traditions_customs.jpg"
    // },
    {
      "title": "Culinary Heritage",
      "subtitle": "Iconic dishes and regional food culture",
      "image": "assets/Cat_image/culinary_heritage.jpg"
    },
  ];

  Widget _pageForIndex(int index) {
    final title = categories[index]['title'] ?? 'Heritage';
    return StateHeritageListPage(
      stateName: stateName,
      categoryTitle: title,
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isSmall = width < 370;
    final titleSize = isSmall ? 14.0 : 15.5;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          stateName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: Color(0xFF171717),
          ),
        ),
        backgroundColor: const Color(0xFFF5A623),
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFFF4DE), Color(0xFFF7F8FA)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFFFDC9A)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Explore Categories',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1D1E25),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Discover the cultural layers of $stateName',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 2, 12, 12),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: isSmall ? 0.73 : 0.77,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];

                    return Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(18),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => _pageForIndex(index),
                            ),
                          );
                        },
                        child: Ink(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(color: const Color(0xFFF4D7A0)),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x1E000000),
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.asset(
                                      category['image']!,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  category['title']!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: titleSize,
                                    height: 1.12,
                                    color: const Color(0xFF1A1A1A),
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  category['subtitle']!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
