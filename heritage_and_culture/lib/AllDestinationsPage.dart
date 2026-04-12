import 'package:flutter/material.dart';
import 'DestinationDetailPage.dart';

class AllDestinationsPage extends StatelessWidget {
  const AllDestinationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> destinations = [
      {
        "state": "Andhra Pradesh",
        "place": "Tirupati Temple",
        "image": "assets/home_image/tirupati.jpg",
        "description":
            "• Location: Andhra Pradesh, India\n• Religious Significance: One of the holiest pilgrimage sites in Hinduism\n• Main Temple: Sri Venkateswara Temple, dedicated to Lord Venkateswara (Balaji)\n• Tirumala Hills: Temple is located on the seventh peak of the Seshachalam Hills\n• Mythological Connection: Believed to be the earthly abode of Lord Vishnu\n• Architectural Marvel: Dravidian-style temple with intricate carvings and gold-plated sanctum\n• Sacred Idol: The deity’s idol is believed to be self-manifested (Swayambhu)\n• Laddu Prasadam: Famous and sacred offering to devotees\n• Pilgrimage Hub: One of the most-visited religious sites in the world\n• Donation Tradition: Devotees offer hair (Mokku) and monetary contributions to the temple\n• Festivals: Brahmotsavam is the grandest festival, attracting millions of pilgrims\n• Daily Rituals: Temple follows strict and elaborate rituals, including Suprabhatam and Archana\n• Queueless Darshan: Special darshan facilities like VIP and free darshan for devotees\n• Annadanam: Free food distribution to thousands of pilgrims daily\n• Economic Powerhouse: One of the wealthiest temples in the world\n• Natural Beauty: Surrounded by lush green forests and scenic hills\n• Connectivity: Well-connected by road, rail, and Tirupati Airport\n• Religious Harmony: Attracts devotees from all over India, irrespective of background\n• Divine Experience: Symbol of devotion, peace, and spiritual enlightenment\n• Eternal Pilgrimage: Considered a gateway to Moksha (liberation)"
      },
      {
        "state": "Arunachal Pradesh",
        "place": "Tawang Monastery",
        "image": "assets/home_image/tawang.jpg",
        "description":
            "• Location: Arunachal Pradesh, India\n• Religious Significance: Largest monastery in India and second-largest in the world\n• Founded By: Merak Lama Lodre Gyatso in 1680, following the wishes of the 5th Dalai Lama\n• Tibetan Buddhism: Follows the Gelugpa (Yellow Hat) sect of Mahayana Buddhism\n• Architectural Marvel: Traditional Tibetan-style monastery with vibrant murals and thangka paintings\n• Main Prayer Hall: Houses a massive 8-meter-tall golden statue of Lord Buddha\n• Spiritual Center: Home to over 300 monks, preserving ancient Buddhist traditions\n• Library & Scriptures: Contains rare Buddhist manuscripts, Kangyur, and Tengyur texts\n• Scenic Location: Perched at an altitude of 3,000 meters, offering breathtaking Himalayan views\n• Tawang River: Located near the monastery, enhancing its serene environment\n• Cultural Hub: Hosts Buddhist festivals, including Torgya Festival and Losar (Tibetan New Year)\n• Pilgrimage Destination: Attracts Buddhists and tourists seeking spiritual enlightenment\n• War Connection: Played a role in the 1962 Sino-Indian War and has historical significance\n• Museum & Artefacts: Preserves ancient Buddhist relics, masks, and ritual items\n• Meditation & Peace: Offers a tranquil retreat for monks and visitors alike\n• Tourist Attraction: One of the most visited places in Arunachal Pradesh\n• Nearby Sites: Close to Sela Pass, Nuranang Falls, and Jaswant Garh War Memorial\n• Climate: Cold and pleasant, with snowfall in winters adding to its charm\n• Connectivity: Accessible via road from Tezpur and Guwahati, with the nearest airport in Tezpur\n• Symbol of Buddhism: Represents faith, knowledge, and the cultural heritage of the region"
      },
      {
        "state": "Assam",
        "place": "Kamakhya Temple",
        "image": "assets/home_image/kamakhya.jpg",
        "description":
            "• Location: Assam, India\n• Religious Significance: One of the 51 Shakti Peethas dedicated to Goddess Kamakhya\n• Main Deity: Goddess Kamakhya, an incarnation of Goddess Shakti\n• Unique Worship: Represents the goddess in the form of a stone yoni (symbol of feminine power)\n• Festival: Ambubachi Mela, celebrating the annual menstruation of the goddess\n• Mythological Connection: Believed to be where Goddess Sati’s womb fell after her self-immolation\n• Tantric Influence: Major center for Tantra worship and spiritual practices\n• Architectural Style: Blend of Hindu and Assamese temple architecture with beehive-shaped domes\n• Pilgrimage Destination: Attracts devotees, sadhus, and spiritual seekers from across India\n• Sacred Rituals: Devotees offer red-colored cloth symbolizing the goddess's power\n• Nilachal Hill: Located on a scenic hilltop overlooking the Brahmaputra River\n• Historical Significance: Temple was reconstructed in the 17th century by King Nara Narayan\n• Symbol of Feminine Energy: Celebrates womanhood, fertility, and creation\n• Underground Sanctum: The garbhagriha (inner sanctum) has no idol, only a sacred rock\n• Religious Harmony: Associated with both Hinduism and Tantric Buddhism\n• Nearby Temples: Part of the Kamakhya temple complex, which includes temples of other goddesses\n• Cultural Heritage: Plays an essential role in Assamese traditions and folklore\n• Tourist Attraction: One of the most visited religious sites in Northeast India\n• Connectivity: Well-connected by road, rail, and Guwahati International Airport\n• Spiritual Experience: Known for its mystical aura and divine energy"
      },
      {
        "state": "Bihar",
        "place": "Mahabodhi Temple",
        "image": "assets/home_image/mahabodhi.jpg",
        "description":
            "• Location: Bihar, India\n• Religious Significance: One of the holiest Buddhist pilgrimage sites\n• Main Deity: Lord Buddha, commemorating his enlightenment\n• Bodhi Tree: Sacred fig tree under which Buddha attained enlightenment\n• UNESCO Heritage Site: Recognized as a World Heritage Site for its historical importance\n• Architectural Style: Blend of Indian and Buddhist architecture with a towering spire\n• Mahavihara: Ancient monastery complex built by Emperor Ashoka in the 3rd century BCE\n• Diamond Throne: Vajrasana, the spot where Buddha meditated\n• Meditation & Teachings: Center for Buddhist learning, meditation, and chanting\n• Four Surrounding Shrines: Mark places where Buddha meditated for weeks post-enlightenment\n• Sacred Lotus Pond: Associated with Buddha’s meditation and spiritual journey\n• Religious Festivals: Buddha Purnima is celebrated with grandeur\n• Buddhist Influence: Attracts monks and followers from Tibet, Sri Lanka, Japan, and Thailand\n• Historical Resilience: Destroyed and restored multiple times over centuries\n• Pilgrimage Destination: Visited by thousands of devotees and tourists every year\n• Nearby Attractions: Close to other Buddhist sites like Sujata Stupa and Great Buddha Statue\n• Symbol of Peace: Represents spiritual awakening and the path to Nirvana\n• Library & Museum: Preserves ancient Buddhist scriptures and relics\n• Connectivity: Well-connected by road, rail, and Gaya International Airport\n• Eternal Spirituality: A beacon of enlightenment and Buddhist philosophy"
      },
      {
        "state": "Chhattisgarh",
        "place": "Chitrakote Falls",
        "image": "assets/home_image/chitrakote.jpg",
        "description":
            "• Location: Chhattisgarh, India\n• Nickname: Known as the ‘Niagara Falls of India’ due to its wide and majestic flow\n• River: Formed by the Indravati River in the Bastar district\n• Height: Falls from a height of approximately 30 meters (98 feet)\n• Width: Expands up to 300 meters during the monsoon season\n• Scenic Beauty: Surrounded by lush greenery, making it a major tourist attraction\n• Best Time to Visit: Monsoon (July to October) when the falls are at their fullest\n• Cultural Significance: Revered by local tribes and linked to Hindu mythology\n• Adventure Activities: Offers boat rides at the base of the falls for a breathtaking view\n• Illumination: The waterfall is beautifully lit up in the evenings for visitors\n• Nearby Attractions: Close to Kutumsar Caves, Tirathgarh Falls, and Bastar’s tribal villages\n• Wildlife: Located near Kanger Valley National Park, home to diverse flora and fauna\n• Water Source: Perennial waterfall, but water flow reduces in summer\n• Pilgrimage Spot: Features small temples and shrines dedicated to Lord Shiva nearby\n• Tribal Connection: Sacred among the Gond and other indigenous communities\n• Photography Paradise: Offers stunning landscapes and mesmerizing sunset views\n• Accessibility: Nearest city is Jagdalpur, well-connected by road and rail\n• Eco-Tourism Hub: Promotes sustainable tourism and natural conservation\n• Peaceful Retreat: Ideal for nature lovers, photographers, and adventure seekers\n• Symbol of Nature’s Grandeur: One of India’s most spectacular waterfalls"
      },
      {
        "state": "Goa",
        "place": "Baga Beach",
        "image": "assets/home_image/baga_beach.jpg",
        "description":
            "• Location: Goa, India\n• Famous For: One of the most popular and lively beaches in Goa\n• Scenic Beauty: Golden sands, palm trees, and breathtaking sunset views\n• Adventure Activities: Offers parasailing, jet skiing, banana boat rides, and scuba diving\n• Nightlife Hub: Home to vibrant beach clubs, shacks, and party spots like Tito’s and Mambo’s\n• Water Sports: Ideal destination for thrill-seekers and water adventure lovers\n• Beach Shacks: Serves delicious Goan seafood and refreshing tropical drinks\n• Tourist Hotspot: Attracts both domestic and international visitors throughout the year\n• Nearby Attractions: Close to Anjuna Beach, Calangute Beach, and Aguada Fort\n• Dolphin Spotting: Boat tours available for dolphin-watching experiences\n• Shopping: Flea markets and street stalls offer souvenirs, beachwear, and handicrafts\n• Live Music & Events: Hosts music festivals, karaoke nights, and beach parties\n• Ideal Season: Best visited from October to March for pleasant weather\n• Yoga & Relaxation: Many resorts and spas offer beachside yoga and wellness retreats\n• Photography Paradise: Stunning sunrise and sunset views perfect for photography lovers\n• Beach Safety: Lifeguards present for the safety of swimmers and visitors\n• Food & Drinks: Famous for Goan curries, seafood platters, and feni (local drink)\n• Accessibility: Easily reachable from Panaji and Dabolim Airport\n• Family-Friendly: Offers a mix of adventure, relaxation, and entertainment for all ages\n• Symbol of Goa’s Spirit: Represents the energetic and carefree vibe of Goa"
      },
      {
        "state": "Gujarat",
        "place": "Statue of Unity",
        "image": "assets/home_image/statue_unity.jpg",
        "description":
            "• Location: Gujarat, India\n• Tallest Statue: World's tallest statue at 182 meters (597 feet)\n• Dedicated To: Sardar Vallabhbhai Patel, India's 'Iron Man' and first Deputy Prime Minister\n• Inauguration: Unveiled on 31st October 2018 by Prime Minister Narendra Modi\n• Architect: Designed by sculptor Ram V. Sutar\n• Construction Material: Made of bronze-clad iron, with a strong steel framework\n• Viewing Gallery: Offers a panoramic view from 153 meters above ground\n• Museum & Exhibition Hall: Showcases Sardar Patel’s life, India’s freedom struggle, and unification\n• Surrounding Landscape: Located on the Narmada River, near the Sardar Sarovar Dam\n• Valley of Flowers: A beautifully landscaped garden around the statue\n• Light & Sound Show: An evening attraction depicting India’s history and Patel’s contributions\n• Tourism Hub: Attracts millions of visitors from across the world\n• Eco-Friendly Transport: Electric buses and cycles available for exploring the complex\n• Adventure Activities: Boating, jungle safaris, and river rafting nearby\n• Nearby Attractions: Sardar Sarovar Dam, Shoolpaneshwar Wildlife Sanctuary, and Zarwani Waterfalls\n• Best Time to Visit: October to March for pleasant weather\n• Symbol of National Unity: Represents Patel’s role in integrating India’s princely states\n• Economic Impact: Boosts local tourism, employment, and infrastructure development\n• Accessibility: Well-connected by road, rail, and the nearest airport at Vadodara\n• Global Recognition: A landmark showcasing India’s engineering marvel and heritage"
      },
      {
        "state": "Gujarat",
        "place": "Dwarka",
        "image": "assets/home_image/Dwaraka.jpg",
        "description":
            "• Location: Gujarat, India\n• Religious Significance: One of the Char Dham pilgrimage sites in Hinduism\n• Main Temple: Dwarkadhish Temple, dedicated to Lord Krishna\n• Mythological Connection: Believed to be the ancient kingdom of Lord Krishna\n• Sacred River: Situated near the confluence of the Gomti River and the Arabian Sea\n• Bet Dwarka: Island believed to be Lord Krishna’s residence\n• Nageshwar Jyotirlinga: One of the twelve Jyotirlingas of Lord Shiva\n• Rukmini Devi Temple: Dedicated to Krishna’s consort, Rukmini\n• Archaeological Importance: Underwater ruins suggest remnants of ancient Dwarka city\n• Sudama Setu: Bridge connecting Dwarkadhish Temple to panoramic river views\n• Gomti Ghat: Pilgrims take a holy dip before visiting the temple\n• Festivals: Janmashtami is celebrated grandly with rituals and cultural performances\n• Spiritual Hub: Attracts devotees, historians, and seekers of mythology\n• Marine National Park: Nearby Gulf of Kutch offers rich marine biodiversity\n• Lighthouse Point: Provides breathtaking views of the Arabian Sea\n• Connectivity: Well-connected by road, rail, and nearest airport in Jamnagar\n• Historic Legends: Mentioned in Mahabharata and ancient scriptures\n• Religious Harmony: Hosts temples and spiritual sites reflecting diverse traditions\n• Tourism Attraction: Popular for temple visits, beaches, and heritage sites\n• Eternal Pilgrimage: Considered a sacred gateway to Moksha (salvation)"
      },
      {
        "state": "Haryana",
        "place": "Kingdom of Dreams",
        "image": "assets/home_image/kingdom_dreams.webp",
        "description":
            "• Location: Gurugram, Haryana, India\n• India’s First Live Entertainment Destination: A grand cultural and theatrical hub\n• Nautanki Mahal: A state-of-the-art auditorium showcasing Bollywood-style musicals\n• Culture Gully: An indoor street with themed restaurants representing different Indian states\n• Bollywood Connection: Hosts spectacular performances blending music, dance, and drama\n• Unique Architecture: A fusion of Indian heritage and modern design\n• Live Shows: Features larger-than-life productions like ‘Zangoora’ and ‘Jhumroo’\n• Food & Dining: Offers diverse Indian cuisines from Kashmir to Kerala\n• Shopping Experience: Houses handicrafts, souvenirs, and artistic decor from across India\n• Interactive Experiences: Visitors can engage in live street performances and cultural acts\n• International Appeal: Attracts tourists and art lovers from around the world\n• Best Time to Visit: Open throughout the year, with evenings being the most vibrant\n• Corporate & Private Events: Hosts weddings, business conferences, and special occasions\n• Photography Paradise: Vibrant and colorful ambiance perfect for capturing memories\n• Technology & Effects: Uses high-tech special effects, aerial choreography, and 4D experiences\n• Weekend Getaway: Popular among Delhi-NCR residents for entertainment and leisure\n• Accessibility: Easily reachable from Delhi by metro, road, and air\n• Family-Friendly Destination: Offers entertainment for all age groups\n• Symbol of Indian Art & Culture: Celebrates India's diverse traditions through performing arts\n• Must-Visit Attraction: A one-of-a-kind cultural experience in India"
      },
      {
        "state": "Himachal Pradesh",
        "place": "Rohtang Pass",
        "image": "assets/home_image/rohtang.jpeg",
        "description":
            "• Location: Himachal Pradesh, India\n• High-Altitude Mountain Pass: Situated at 3,978 meters (13,050 feet) in the Pir Panjal Range\n• Connects: Manali to Lahaul and Spiti Valleys\n• Scenic Beauty: Offers breathtaking views of snow-capped peaks, glaciers, and lush valleys\n• Adventure Hub: Popular for skiing, snowboarding, paragliding, and mountain biking\n• Best Time to Visit: May to October, as it remains closed during winters due to heavy snowfall\n• Snowfall Destination: One of the few places in India where visitors can experience snow even in summer\n• Photography Paradise: Stunning landscapes, waterfalls, and meandering roads perfect for capturing memories\n• Nearby Attractions: Solang Valley, Beas Kund, and Lahaul-Spiti region\n• Beas River Origin: The Beas River originates from Beas Kund near Rohtang Pass\n• Permit Requirement: Visitors need a special permit to access the pass due to environmental regulations\n• Challenging Terrain: Known for its steep roads, hairpin bends, and unpredictable weather\n• Bollywood Connection: Featured in several Bollywood movies for its mesmerizing backdrop\n• Glacier Sightseeing: Offers views of glaciers like the Sonapani and the twin peaks of Geypan\n• Tourist Hotspot: Attracts thousands of travelers, bikers, and nature lovers every year\n• Local Culture: Provides a glimpse into the lifestyle of Lahauli and Tibetan communities\n• Military Importance: Strategically significant for the Indian Army, connecting key border regions\n• Eco-Tourism Zone: Authorities impose regulations to preserve the fragile ecosystem\n• Accessibility: The nearest city is Manali, well-connected by road, with the nearest airport in Bhuntar\n• Symbol of Himalayan Grandeur: Represents the majestic beauty and adventure spirit of the Himalayas"
      },
      {
        "state": "Jharkhand",
        "place": "Baidhyanath Temple",
        "image": "assets/home_image/baidhyanath.jpg",
        "description":
            "• Location: Deoghar, Jharkhand, India\n• One of the Twelve Jyotirlingas: Considered one of the most sacred Shiva temples in India\n• Religious Significance: Believed to be the place where Ravana worshipped Lord Shiva\n• Major Pilgrimage Destination: Attracts millions of devotees, especially during the Shravan month\n• Complex Structure: Comprises the main Baidyanath temple along with 21 other temples\n• Mythological Connection: Linked to the story of Ravana offering his ten heads to Lord Shiva\n• Unique Worship Ritual: Devotees offer water from the Ganges at Sultanganj, carried on foot to the temple\n• Shravani Mela: A grand annual festival held during July-August, attracting Kanwariyas (pilgrims)\n• Architectural Style: Built in the Nagara style with a pyramidal tower\n• Healing Powers: Believed to have medicinal and spiritual benefits, earning it the name ‘Baidyanath’ (meaning ‘Divine Physician’)\n• Nearby Attractions: Naulakha Temple, Trikuta Parvat, and Satsang Ashram\n• Best Time to Visit: October to March for pleasant weather and comfortable travel\n• Sacred Pond: Mansarovar Kund, where pilgrims take a holy dip before entering the temple\n• Religious Harmony: The temple complex also houses shrines dedicated to Parvati, Ganesha, and other deities\n• Historical Mentions: Referenced in ancient scriptures like the Shiva Purana and Ramayana\n• Devotional Offerings: Devotees offer flowers, milk, and Bilva leaves to Lord Shiva\n• Spiritual Vibes: Considered a powerful energy center for meditation and prayers\n• Accessibility: Well-connected by rail and road, with the nearest airport in Ranchi\n• Symbol of Faith: Represents devotion, healing, and divine blessings of Lord Shiva"
      },
      {
        "state": "Karnataka",
        "place": "Hampi",
        "image": "assets/home_image/hampi.jpeg",
        "description":
            "• Location: Karnataka, India\n• UNESCO World Heritage Site: Recognized for its historical and architectural significance\n• Capital of Vijayanagara Empire: Once a thriving city and a major trade center\n• Ruins and Temples: Features over 1,600 monuments, including temples, palaces, and markets\n• Virupaksha Temple: One of the oldest functioning temples, dedicated to Lord Shiva\n• Vittala Temple: Known for its iconic stone chariot and musical pillars\n• Tungabhadra River: Flows alongside Hampi, adding to its scenic beauty\n• Matanga Hill: Offers a panoramic view of the ancient ruins and sunset spots\n• Elephant Stables: Well-preserved structures used to house royal elephants\n• Lotus Mahal: A unique Indo-Islamic architectural marvel within the Zenana Enclosure\n• Hampi Bazaar: Once a bustling marketplace, now a site of historical exploration\n• Mythological Connection: Believed to be Kishkindha, the monkey kingdom from the Ramayana\n• Monolithic Sculptures: Includes massive statues like Lakshmi Narasimha and Badavilinga\n• Coracle Rides: Traditional round boats used to cross the Tungabhadra River\n• Best Time to Visit: October to March for pleasant weather and sightseeing\n• Hampi Utsav: An annual festival celebrating the city's cultural heritage\n• Backpacker’s Paradise: Attracts travelers for its historical charm, boulder landscapes, and vibrant cafes\n• Cycling & Trekking: Popular activities to explore the ruins and surrounding hills\n• Accessibility: Well-connected by road and rail, with the nearest airport in Hubli\n• Symbol of Grandeur: Represents the glorious past of South Indian dynasties and architectural brilliance"
      },
      {
        "state": "Kerala",
        "place": "Alleppey Backwaters",
        "image": "assets/home_image/alleppey.jpg",
        "description":
            "• Location: Kerala, India\n• Venice of the East: Known for its picturesque canals, lagoons, and lakes\n• Houseboat Cruises: Offers serene backwater experiences in traditional Kettuvallams\n• Vembanad Lake: The largest lake in Kerala, forming the heart of the backwaters\n• Scenic Beauty: Lush greenery, coconut palms, and serene waters create a tranquil escape\n• Snake Boat Races: Hosts the famous Nehru Trophy Boat Race every August\n• Kumarakom Bird Sanctuary: A paradise for bird watchers with migratory species\n• Traditional Village Life: Provides glimpses of local fishermen, toddy tapping, and coir-making\n• Ayurvedic Rejuvenation: Home to wellness retreats offering authentic Ayurvedic therapies\n• Alleppey Beach: A scenic coastal spot with golden sands and a historic lighthouse\n• Floating Markets: Unique markets where vendors sell goods from boats\n• Best Time to Visit: September to March for pleasant weather and lush landscapes\n• Photography Haven: Stunning sunrise and sunset views over the backwaters\n• Canoe & Shikara Rides: Ideal for exploring narrow canals and hidden gems\n• Religious Significance: Home to ancient temples and churches, including Ambalappuzha Sree Krishna Temple\n• Culinary Delights: Offers fresh seafood, Karimeen (pearl spot fish), and traditional Kerala Sadya\n• Eco-Tourism Destination: Emphasizes sustainable tourism and conservation efforts\n• Accessibility: Well-connected by road and rail, with the nearest airport in Kochi\n• Romantic Getaway: Popular among honeymooners for its peaceful and scenic ambiance\n• Symbol of Kerala’s Beauty: A must-visit destination showcasing the charm of God’s Own Country"
      },
      {
        "state": "Madhya Pradesh",
        "place": "Khajuraho Temples",
        "image": "assets/home_image/khajuraho.jpg",
        "description":
            "• Location: Madhya Pradesh, India\n• UNESCO World Heritage Site: Recognized for its stunning temple architecture and intricate carvings\n• Built by Chandela Dynasty: Constructed between 950-1050 AD, showcasing medieval Indian art\n• Famous for Erotic Sculptures: Depicts themes of love, mythology, and everyday life\n• Architectural Marvel: Blends Nagara-style temple design with detailed stone carvings\n• Three Temple Groups: Divided into Western, Eastern, and Southern groups of temples\n• Kandariya Mahadeva Temple: The largest and most ornate temple dedicated to Lord Shiva\n• Lakshmana Temple: Known for its detailed sculptures and religious significance\n• Vishwanath Temple: Houses a beautifully carved Nandi bull and stunning artwork\n• Devi Jagadambi Temple: Dedicated to Goddess Parvati, known for intricate female figurines\n• Jain Temples: Includes Parshvanatha and Adinatha Temples, reflecting Jain heritage\n• Cultural and Spiritual Significance: Represents a blend of Hindu and Jain traditions\n• Sound and Light Show: Narrates the history of Khajuraho in an engaging manner\n• Annual Dance Festival: Hosts a classical dance festival in February, attracting global artists\n• Mythological Connection: Believed to be inspired by celestial architects and divine influences\n• Artistic Grandeur: Carvings depict gods, celestial beings, musicians, warriors, and daily life scenes\n• Best Time to Visit: October to March for pleasant weather and festival experiences\n• Photography Paradise: Offers stunning visuals of ancient temples and sculptures\n• Accessibility: Well-connected by road, rail, and the nearest airport in Khajuraho\n• Symbol of India's Rich Heritage: Showcases the artistic brilliance and cultural depth of ancient India"
      },
      {
        "state": "Maharashtra",
        "place": "Gateway of India",
        "image": "assets/home_image/gateway.jpeg",
        "description":
            "• Location: Mumbai, Maharashtra, India\n• Iconic Landmark: One of Mumbai’s most famous historical monuments\n• Built in 1924: Constructed to commemorate the visit of King George V and Queen Mary to India\n• Indo-Saracenic Architecture: A blend of Hindu, Muslim, and European styles\n• Overlooking the Arabian Sea: A stunning waterfront attraction offering picturesque views\n• Historical Significance: Served as the ceremonial entrance to India for British viceroys\n• Departure Point of the British: The last British troops left India through this gateway in 1948\n• Tourist Attraction: A popular spot for visitors, photographers, and locals\n• Ferry Services: Offers boat rides to Elephanta Caves and coastal tours\n• Taj Mahal Palace Hotel: Located nearby, enhancing the grandeur of the area\n• Best Time to Visit: November to February for pleasant weather and clear skies\n• Illuminated at Night: The gateway looks spectacular with evening lighting\n• Cultural Hub: Hosts local vendors, street performers, and food stalls\n• Symbol of Colonial History: Represents India's transition from British rule to independence\n• Security Landmark: Closely monitored after the 2008 Mumbai attacks\n• Close to Marine Drive: A short distance from another popular Mumbai attraction\n• Public Gathering Spot: Venue for protests, celebrations, and cultural events\n• Accessibility: Well-connected by road and rail, with Chhatrapati Shivaji Maharaj Terminus nearby\n• Nearby Attractions: Prince of Wales Museum, Colaba Causeway, and Rajabai Clock Tower\n• Symbol of Mumbai’s Heritage: A must-visit monument showcasing the city's rich history and grandeur"
      },
      {
        "state": "Maharashtra",
        "place": "Pune",
        "image": "assets/home_image/Shaniwar_Wada.jpg",
        "description":
            "• Location: Maharashtra, India\n• Historical Significance: Former capital of the Maratha Empire\n • Cultural Heritage: Blend of Maratha, Mughal, and British influences\n• Major Festival : Ganesh Chaturthi, celebrating the birth of Lord Ganesha\n• Tourist Hub: Attracts visitors for its historical sites, temples, and cultural events\n• Traditional Handic rafts: Famous for silver and gold jewelry, and intricate woodwork\n• Mughlai Cuisine: Known for dishes like pithla, bhaat, and misal pav\n• Connectivity: Well-connected by road, rail, and air, with Pune Airport nearby\n• Historic Markets : Laxmi Road and Camp area popular for shopping\n• Religious Sites: Houses Shaniwar Wada, Pataleshwar Cave Temple, and Dagdusheth Halwai Temple\n • Gardens & Greenery: Kamala Nehru Park and Bund Garden offer serene escapes\n• British Influence: Features colonial-era structures and churches\n• Photography Paradise: Iconic views of the city from the top of Shaniwar Wada\n• Symbol of Heritage: Represents the rich cultural and historical legacy of Pune"
      },
      {
        "state": "Maharashtra",
        "place": "Mumbai",
        "image": "assets/home_image/Gateway_Of_India.jpeg",
        "description":
            "• Location: Maharashtra, India\n• Financial Capital: India's largest city and economic hub\n• Bollywood Hub: Center of the Indian film industry, known as Bollywood\n• Gateway of India: Iconic monument built during the British era\n• Marine Drive: Famous promenade offering stunning views of the Arabian Sea\n• Elephanta Caves: UNESCO World Heritage Site with ancient rock-cut caves\n• Chhatrapati Shivaji Maharaj Terminus: Historic railway station and architectural marvel\n• Juhu & Girgaum Chowpatty: Popular beaches known for street food and sunset views\n• Business & Trade: Headquarters of major Indian and multinational companies\n• Stock Exchange: Home to the Bombay Stock Exchange (BSE), one of the oldest in Asia\n• Cultural Diversity: Melting pot of various religions, languages, and traditions\n• Festivals: Grand celebrations of Ganesh Chaturthi, Diwali, and Eid\n• Street Food Paradise: Famous for vada pav, pav bhaji, bhel puri, and misal pav\n• Public Transport: Extensive suburban railway, metro, and BEST buses for connectivity\n• Dharavi: One of the largest slums in the world, known for its entrepreneurial spirit\n• Siddhivinayak Temple: Revered temple dedicated to Lord Ganesha\n• Haji Ali Dargah: Iconic mosque and tomb located on an islet in the Arabian Sea\n• Sanjay Gandhi National Park: Green oasis with wildlife, lakes, and ancient caves\n• Nightlife & Entertainment: Vibrant clubs, theaters, and live music venues\n• Iconic Sports Venues: Home to Wankhede Stadium and Mumbai Indians IPL team"
      },
      {
        "state": "Manipur",
        "place": "Loktak Lake",
        "image": "assets/home_image/loktak.jpg",
        "description":
            "• Location: Manipur, India\n• Largest Freshwater Lake in Northeast India: Spanning around 287 sq. km\n• Famous for Phumdis: Floating islands made of vegetation, soil, and organic matter\n• Home to Keibul Lamjao National Park: The world's only floating national park\n• Habitat of Sangai Deer: An endangered species and the state animal of Manipur\n• Scenic Beauty: Offers breathtaking views of crystal-clear waters and lush greenery\n• Loktak Lake Floating Homestays: Provides unique stay experiences on the water\n• Fishermen’s Paradise: Supports a large local fishing community\n• Boating & Canoe Rides: A popular way to explore the floating islands and serene waters\n• Birdwatching Destination: Home to various migratory and resident bird species\n• Loktak Day Celebration: An annual event promoting conservation and eco-tourism\n• Mythological Significance: Believed to have deep cultural and spiritual importance in Manipuri folklore\n• Best Time to Visit: October to March for ideal weather and clear lake views\n• Photography Spot: Captivating sunrise and sunset views over the lake\n• Nearby Attractions: Sendra Island, INA Memorial, and Moirang town\n• Eco-Tourism Initiative: Promoting sustainable tourism while preserving the lake’s ecosystem\n• Traditional Fishing Techniques: Witness unique local fishing practices using handwoven nets\n• Conservation Efforts: Various programs to protect the lake from pollution and overfishing\n• Accessibility: Well-connected to Imphal, with the nearest airport in Imphal (about 50 km away)\n• Symbol of Manipur’s Natural Beauty: A must-visit destination for nature lovers and adventure seekers"
      },
      {
        "state": "Meghalaya",
        "place": "Living Root Bridges",
        "image": "assets/home_image/root_bridges.jpg",
        "description":
            "• Location: Meghalaya, India\n• Natural Wonders: Unique bridges formed by training living tree roots\n• Made from Ficus Elastica: Rubber tree roots are woven and guided over decades\n• Found in Khasi & Jaintia Hills: Mainly seen in Cherrapunji and Mawlynnong\n• Double-Decker Root Bridge: A rare and iconic two-level bridge in Nongriat village\n• Eco-Friendly Engineering: Created without harming the trees, promoting sustainability\n• Takes Decades to Form: Some bridges are over 100 years old, passed down generations\n• Strong & Durable: Can support dozens of people at a time, lasting for centuries\n• Cultural Heritage: Built and maintained by Khasi and Jaintia tribes\n• Monsoon Beauty: Lush greenery and flowing streams make it a magical sight\n• Trekking Experience: Reaching the bridges requires trekking through dense forests\n• Biodiversity Hotspot: Surrounded by exotic flora, waterfalls, and wildlife\n• Best Time to Visit: October to April for pleasant weather and clear trails\n• Photography Paradise: Offers breathtaking views of nature and unique root formations\n• Community Effort: Local villagers nurture and strengthen these bridges over time\n• Close to Other Attractions: Near Nohkalikai Falls, Mawsmai Caves, and Dawki River\n• Example of Bioengineering: Showcases indigenous knowledge and harmony with nature\n• UNESCO Recognition: Proposed as a World Heritage Site for its ecological significance\n• Tourist Attraction: A must-visit for adventure seekers, nature lovers, and eco-tourists\n• Symbol of Sustainable Living: Reflects Meghalaya’s deep connection with nature"
      },
      {
        "state": "Mizoram",
        "place": "Vantawng Falls",
        "image": "assets/home_image/vantawng.webp",
        "description":
            "• Location: Mizoram, India\n• Tallest Waterfall in Mizoram: Cascades from a height of about 750 feet\n• Two-Tiered Waterfall: Creates a breathtaking multi-layered flow\n• Surrounded by Dense Forests: Nestled within lush green tropical vegetation\n• Originates from Vanva River: A pristine water source in Mizoram’s hills\n• Located in Serchhip District: About 137 km from Aizawl, the state capital\n• Best Viewed from a Distance: Due to dense forests, direct access is limited\n• Scenic Beauty: Offers a mesmerizing sight, especially during the monsoon\n• Ideal for Nature Lovers: A serene getaway with untouched natural surroundings\n• Monsoon Marvel: At its most powerful and beautiful from June to September\n• Trekking & Hiking Spot: Nearby trails offer adventurous exploration opportunities\n• Photography Paradise: A perfect location for capturing stunning landscape shots\n• Nearby Attractions: Close to Thenzawl, known for Mizo handloom and handicrafts\n• Eco-Tourism Destination: Promotes sustainable travel and conservation efforts\n• Rich in Biodiversity: Home to various bird species and exotic flora\n• Picnic Spot: A peaceful retreat for relaxation and outdoor meals\n• Cultural Significance: Deeply revered by the local Mizo communities\n• Accessible via Road: Well-connected by road from Aizawl and Serchhip\n• Best Time to Visit: October to March for clearer views and comfortable weather\n• Symbol of Mizoram’s Natural Beauty: One of the state’s most iconic waterfalls"
      },
      {
        "state": "Nagaland",
        "place": "Kohima War Cemetery",
        "image": "assets/home_image/kohima.webp",
        "description":
            "• Location: Kohima, Nagaland, India\n• Memorial Site: Honors soldiers who died in the Battle of Kohima during World War II\n• Maintained by the Commonwealth War Graves Commission: Ensures its preservation and dignity\n• Final Resting Place: Contains over 1,400 graves of Allied soldiers\n• Historical Significance: Marks the site of one of the fiercest battles in the Burma Campaign (1944)\n• Famous Epitaph: Features the moving inscription—'When You Go Home, Tell Them of Us and Say, For Your Tomorrow, We Gave Our Today'\n• Divided into Two Sections: Upper terrace with the memorial and lower section with graves\n• Located on Garrison Hill: Overlooks the city of Kohima, providing a serene atmosphere\n• Former Tennis Court: Built on the site of the British Deputy Commissioner’s bungalow, where intense fighting took place\n• Symbol of Sacrifice: Represents the bravery of soldiers who defended India against Japanese forces\n• Historical Artifacts: Features stone markers and plaques with names of fallen soldiers\n• Peaceful Ambience: A place of reflection and tribute to war heroes\n• Popular Tourist Destination: Draws visitors interested in history and military heritage\n• Well-Maintained Gardens: Provides a tranquil and respectful environment\n• Nearby Attractions: Close to the Kohima Cathedral and Naga Heritage Village\n• Best Time to Visit: October to April for pleasant weather and clear views\n• Educational Significance: A key site for learning about World War II history in India\n• Annual Remembrance Ceremony: Honors fallen soldiers with tributes and wreath-laying events\n• Accessibility: Well-connected by road, approximately 70 km from Dimapur, the nearest airport and railway station\n• Symbol of Indo-British War History: Highlights India’s role in global wartime efforts"
      },
      {
        "state": "Odisha",
        "place": "Konark Sun Temple",
        "image": "assets/home_image/konark.jpg",
        "description":
            "• Location: Odisha, India\n• UNESCO World Heritage Site: Recognized for its architectural brilliance and historical significance\n• Built in the 13th Century: Constructed by King Narasimhadeva I of the Eastern Ganga dynasty\n• Dedicated to the Sun God: A masterpiece of ancient Indian temple architecture\n• Designed as a Chariot: Features 12 intricately carved stone wheels representing time\n• Unique Architecture: Symbolizes the Sun God’s chariot being pulled by seven horses\n• Intricate Stone Carvings: Depicts deities, dancers, warriors, animals, and mythological scenes\n• Historical Significance: Showcases Kalinga architecture at its peak\n• Magnetic Floating Idol Myth: Legends suggest a massive magnet was used in the temple’s construction\n• Erotic Sculptures: Similar to Khajuraho temples, representing themes of life and spirituality\n• Once Near the Sea: Believed to have served as a navigational landmark for sailors\n• Major Tourist Attraction: Draws history enthusiasts, architects, and spiritual seekers\n• Cultural & Religious Importance: Reflects Odisha’s deep-rooted Hindu traditions\n• Konark Dance Festival: An annual classical dance event held near the temple\n• Sunlight Alignment: The temple’s design allowed the first rays of the sun to illuminate the deity inside\n• Partially Ruined: Many sections collapsed over time but still retain their grandeur\n• Conservation Efforts: Maintained by the Archaeological Survey of India (ASI)\n• Best Time to Visit: October to March for favorable weather and cultural events\n• Nearby Attractions: Chandrabhaga Beach, Ramachandi Temple, and Puri Jagannath Temple\n• Symbol of India’s Heritage: A must-visit site showcasing India’s ancient architectural and artistic legacy"
      },
      {
        "state": "Punjab",
        "place": "Golden Temple",
        "image": "assets/home_image/golden_temple.jpg",
        "description":
            "• Location: Amritsar, Punjab, India\n• Holiest Sikh Shrine: The most important pilgrimage site in Sikhism\n• Also Known As: Sri Harmandir Sahib or Darbar Sahib\n• Founded by Guru Arjan: Built in the late 16th century by the fifth Sikh Guru\n• Covered in Gold: The upper floors are adorned with real gold, giving it its iconic look\n• Surrounded by Amrit Sarovar: A sacred water tank believed to have healing properties\n• Open to All: Welcomes people of all religions, castes, and backgrounds\n• Guru Granth Sahib: The holy scripture of Sikhism is housed inside\n• Architectural Marvel: A blend of Indo-Islamic and Sikh architectural styles\n• Langar (Community Kitchen): Serves free meals to thousands daily, regardless of religion or status\n• Four Entrances: Symbolizing openness and acceptance for all humanity\n• Daily Prayers & Hymns: Devotional music (Kirtan) is sung throughout the day\n• Akal Takht: The highest seat of Sikh temporal authority is located within the complex\n• Historical Significance: Witnessed major events, including Operation Blue Star in 1984\n• Nighttime Illumination: Looks stunning when lit up at night, reflecting in the water\n• Best Time to Visit: October to March for pleasant weather and major festivals\n• Major Festivals: Guru Nanak Jayanti, Baisakhi, and Diwali are celebrated grandly\n• Nearby Attractions: Jallianwala Bagh, Wagah Border, and Partition Museum\n• Spiritual Experience: A place of peace, meditation, and divine connection\n• Symbol of Equality & Service: Represents Sikh values of selfless service, humility, and unity"
      },
      {
        "state": "Rajasthan",
        "place": "Hawa Mahal",
        "image": "assets/home_image/hawa_mahal.jpg",
        "description":
            "• Location: Jaipur, Rajasthan, India\n• Also Known As: 'Palace of Winds' or 'Breeze Palace'\n• Built in 1799: Constructed by Maharaja Sawai Pratap Singh\n• Unique Architecture: Designed like Lord Krishna’s crown\n• Five-Story Structure: Features 953 small windows (jharokhas)\n• Purpose: Allowed royal women to observe street life without being seen\n• Made of Red & Pink Sandstone: Blends with Jaipur’s signature architecture\n• Ventilation Marvel: The numerous windows keep the palace naturally cool\n• Fusion of Rajput & Mughal Styles: Showcases intricate latticework and domes\n• No Front Entrance: Accessed through the City Palace complex\n• Stunning Sunrise View: Best visited early morning for golden hues\n• Best Time to Visit: October to March for pleasant weather\n• Nearby Attractions: City Palace, Jantar Mantar, and Albert Hall Museum\n• Symbol of Jaipur: A cultural and historical landmark of Rajasthan\n• Photographers’ Paradise: Offers breathtaking views and intricate details\n• Museum Inside: Showcases artifacts, paintings, and royal history\n• Elevated Balconies: Provide panoramic views of Jaipur city\n• Tourist Hotspot: One of the most visited monuments in India\n• Architectural Inspiration: An example of clever craftsmanship and royal aesthetics\n• Heritage Site: A must-visit for history lovers and architecture enthusiasts"
      },
      {
        "state": "Sikkim",
        "place": "Tsomgo Lake",
        "image": "assets/home_image/tsomgo.jpg",
        "description":
            "• Location: East Sikkim, India\n• Also Known As: Changu Lake\n• Altitude: Situated at an elevation of 3,753 meters (12,313 feet)\n• Glacial Lake: Formed by melting glaciers and surrounded by snow-capped mountains\n• Changing Colors: The lake’s water changes hues with seasons, from deep blue to greenish\n• Frozen in Winter: Completely freezes during winter, creating a breathtaking landscape\n• Sacred Significance: Considered holy by the Sikkimese people and associated with Buddhist and Hindu beliefs\n• Yak Rides: Tourists can enjoy traditional yak rides along the lake’s edge\n• Rich Biodiversity: Home to migratory birds, including Brahminy ducks, and rare flora like primulas and blue poppies\n• Gateway to Nathula Pass: Located on the way to the Indo-China border\n• Best Time to Visit: March to May (for blooming flowers) and October to December (for clear views and snow)\n• Permits Required: Indian nationals need an Inner Line Permit, while foreign tourists require special permission\n• Nearby Attractions: Baba Harbhajan Singh Temple, Nathula Pass, and Kupup Lake\n• Adventure Hub: Popular for trekking and snow activities during winter\n• Spiritual Experience: Local monks predict the future by studying lake patterns\n• Scenic Drive: The journey from Gangtok to Tsomgo Lake offers mesmerizing mountain views\n• Located 40 km from Gangtok: A short but thrilling drive with winding roads\n• Photography Paradise: Captivates visitors with its serene beauty and mirror-like reflections\n• Monsoon Caution: Avoid visiting in heavy rains due to landslides and roadblocks\n• Must-Visit Destination: A highlight of Sikkim tourism and a must-see for nature lovers"
      },
      {
        "state": "Tamil Nadu",
        "place": "Meenakshi Temple",
        "image": "assets/home_image/meenakshi.webp",
        "description":
            "• Location: Madurai, Tamil Nadu, India\n• Dedicated To: Goddess Meenakshi (a form of Parvati) and Lord Sundareswarar (Shiva)\n• Architectural Marvel: A masterpiece of Dravidian architecture\n• Built By: Originally constructed by the Pandya dynasty, later expanded by the Nayak rulers\n• Massive Gopurams: Features 14 intricately carved towers (gopurams), the tallest being 52 meters\n• Hall of Thousand Pillars: A spectacular hall with intricately carved stone pillars\n• Golden Lotus Tank: Sacred temple pond believed to determine literary works' worth\n• Vibrant Sculptures: Depicts mythological stories, gods, and celestial beings\n• Rich Cultural Heritage: A center of Tamil culture, poetry, and devotion\n• Daily Rituals & Ceremonies: Hosts elaborate poojas and processions daily\n• Famous Chithirai Festival: A grand 10-day festival celebrating the divine wedding of Meenakshi and Sundareswarar\n• One of the Oldest Temples: History dates back over 2,500 years\n• Spiritual Significance: Considered one of the most sacred temples in South India\n• Devotee Attraction: Millions of pilgrims visit annually for blessings\n• Best Time to Visit: October to March for pleasant weather and festivals\n• Temple Timings: Open from early morning to late evening for darshan\n• Nearby Attractions: Thirumalai Nayakkar Palace, Gandhi Memorial Museum, and Alagar Kovil\n• Unique Idol of Meenakshi: The goddess is depicted with a parrot in her right hand\n• Symbol of Madurai: Represents the city’s historical and religious significance\n• UNESCO Recognition: Part of India’s tentative list for UNESCO World Heritage Sites"
      },
      {
        "state": "Telangana",
        "place": "Charminar",
        "image": "assets/home_image/charminar.jpg",
        "description":
            "• Location: Hyderabad, Telangana, India\n• Built By: Sultan Muhammad Quli Qutb Shah in 1591\n• Purpose: Constructed to commemorate the end of a plague epidemic\n• Architectural Style: Indo-Islamic with Persian influences\n• Iconic Four Minarets: Symbolizes the four Khalifas of Islam\n• Grand Arches: Each arch stands at 20 meters high, offering a majestic look\n• Mosque on the Top Floor: Houses a functional mosque, one of the oldest in Hyderabad\n• Laad Bazaar Nearby: Famous for bangles, pearls, and traditional Hyderabadi items\n• Historical Landmark: Considered the heart of Hyderabad’s old city\n• Nighttime Illumination: Looks mesmerizing when lit up in the evening\n• Best Time to Visit: October to March for pleasant weather\n• Clock Faces: Four giant clocks were added to the structure in 1889\n• Spiritual Significance: A blend of religious and cultural history\n• 45 Prayer Spaces: Used by worshippers for daily prayers\n• Tourist Attraction: One of the most visited monuments in India\n• Close to Mecca Masjid: One of India’s largest mosques is located nearby\n• Stairs to the Top: Offers panoramic views of the bustling market below\n• UNESCO Tentative List: Nominated as a World Heritage Site\n• Symbol of Hyderabad: Represents the city’s rich heritage and architectural brilliance\n• Festival Hub: Attracts huge crowds during Eid celebrations"
      },
      {
        "state": "Tripura",
        "place": "Neermahal",
        "image": "assets/home_image/neermahal.jpg",
        "description":
            "• Location: Melaghar, Tripura, India\n• Meaning: 'Water Palace' – built in the middle of Rudrasagar Lake\n• Built By: Maharaja Bir Bikram Kishore Manikya in 1930\n• Architectural Style: Fusion of Hindu and Mughal designs\n• Royal Retreat: Served as the summer palace for Tripura’s royal family\n• Two Sections: Andar Mahal (residential area) and open terraces for entertainment\n• Red & White Structure: Symbolizes grandeur and elegance\n• Surrounded by Water: Only water palace in Eastern India\n• Light & Sound Show: Showcases the history and significance of the palace\n• Best Time to Visit: October to March for pleasant weather\n• Boat Ride Experience: Accessible only by boat, offering scenic views\n• Cultural Significance: Hosts annual Neermahal Water Festival\n• Reflection in the Lake: Creates a mesmerizing visual effect\n• Historical Monument: Represents Tripura’s rich heritage and royal past\n• Mughal Garden Influence: Features beautiful gardens and pavilions\n• Bird Watching Spot: Home to migratory birds during winter\n• Nearby Attractions: Rudrasagar Lake, Sipahijala Wildlife Sanctuary\n• Unique in the Northeast: A rare example of Rajput-Mughal architecture in the region\n• Night View: Looks stunning when illuminated at dusk\n• Must-Visit Destination: A blend of history, nature, and architectural beauty"
      },
      {
        "state": "Uttar Pradesh",
        "place": "Taj Mahal",
        "image": "assets/home_image/tajmahal.jpeg",
        "description":
            "• Location: Agra, Uttar Pradesh, India\n• Built By: Emperor Shah Jahan in memory of his wife Mumtaz Mahal\n• Year of Completion: 1653\n• Architectural Style: Mughal architecture with Persian, Islamic, and Indian influences\n• Material Used: White Makrana marble, semi-precious stones, and intricate carvings\n• UNESCO World Heritage Site: Recognized in 1983 for its historical and artistic significance\n• One of the Seven Wonders of the World: A symbol of eternal love\n• Majestic Dome: The central dome rises to 73 meters (240 feet)\n• Four Minarets: Surround the main tomb, slightly tilted outward for protection\n• Intricate Calligraphy: Quranic verses inscribed on the marble walls\n• Inlay Work: Features precious stones like jade, lapis lazuli, and turquoise\n• Reflecting Pool: Enhances the beauty of the monument\n• Gardens: Charbagh-style Persian gardens represent paradise\n• Changing Colors: Appears pinkish in the morning, white in the afternoon, and golden in the moonlight\n• Yamuna River Backdrop: Provides a serene and picturesque setting\n• Tourist Attraction: Over 7 million visitors annually\n• Best Time to Visit: October to March for pleasant weather\n• Taj Mahal at Night: Open for viewing on full moon nights\n• Nearby Attractions: Agra Fort, Mehtab Bagh, and Fatehpur Sikri\n• Symbol of India: One of the most iconic landmarks in the world"
      },
      {
        "state": "Uttar Pradesh",
        "place": "Ayodhya",
        "image": "assets/home_image/Ayodhya.jpeg",
        "description":
            "• Location: Uttar Pradesh, India\n• Historical Significance: Believed to be the birthplace of Lord Ram\n• Religious Importance: One of the seven holiest cities (Sapta Puri) in Hinduism\n• Main Temple: Ram Mandir at Ram Janmabhoomi\n• River: Located on the banks of the sacred Sarayu River\n• Cultural Heritage: Mentioned in ancient texts like the Ramayana\n• Architectural Marvels: Ram Mandir, Hanuman Garhi, Kanak Bhawan, and Nageshwarnath Temple\n• Major Festival: Deepotsav during Diwali, celebrating Ram’s return to Ayodhya\n• Pilgrimage Destination: Millions of devotees visit yearly for religious rituals\n• Spiritual Legacy: Associated with the Ikshvaku dynasty and sage Valmiki\n• Diverse Influence: Includes Hindu, Jain, Buddhist, and Sikh heritage sites\n• Mythological Connection: King Dasharatha ruled from Ayodhya\n• Tourism Hub: Attracts visitors for its temples, ghats, and historical sites\n• Ancient Trade Center: Once a thriving city in ancient India\n• Sacred Ghats: Pilgrims take holy dips in Sarayu River for purification\n• Religious Harmony: Hosts temples, stupas, and gurudwaras reflecting diverse traditions\n• Vedic Connection: Referenced in Vedic scriptures and epics\n• Royal City: Capital of the legendary Kosala kingdom\n• Reconstruction & Development: Undergoing massive infrastructure and cultural revival\n• Symbol of Devotion: Represents faith, tradition, and the spiritual essence of India"
      },
      {
        "state": "Uttar Pradesh",
        "place": "Agra",
        "image": "assets/home_image/Agra_Fort.jpg",
        "description":
            "• Location: Uttar Pradesh, India\n• Historical Significance: Former capital of the Mughal Empire\n• World Heritage Sites: Home to Taj Mahal, Agra Fort, and Fatehpur Sikri\n• Taj Mahal: One of the Seven Wonders of the World, built by Shah Jahan\n• Architectural Marvels: Showcases Mughal architecture with intricate carvings and domes\n• Yamuna River: Situated on the banks of the sacred Yamuna River\n• Agra Fort: A massive red sandstone fort and UNESCO World Heritage Site\n• Fatehpur Sikri: A historic city built by Emperor Akbar, famous for Buland Darwaza\n• Cultural Heritage: Blend of Hindu, Persian, and Mughal influences\n• Major Festival: Taj Mahotsav, celebrating art, craft, and culture\n• Tourist Hub: Attracts millions of visitors worldwide for its iconic monuments\n• Traditional Handicrafts: Famous for marble inlay work, carpets, and leather goods\n• Mughlai Cuisine: Known for dishes like petha, kebabs, and biryani\n• Connectivity: Well-connected by road, rail, and air, with Agra Airport nearby\n• Historic Markets: Sadar Bazaar and Kinari Bazaar popular for shopping\n• Religious Sites: Houses Jama Masjid, Mankameshwar Temple, and Gurudwara Guru Ka Taal\n• Gardens & Greenery: Mehtab Bagh offers a stunning view of the Taj Mahal\n• British Influence: Features colonial-era structures and churches\n• Photography Paradise: Iconic sunrise and sunset views at Taj Mahal\n• Symbol of Love: Represents eternal love and architectural brilliance"
      },
      {
        "state": "Uttarakhand",
        "place": "Kedarnath",
        "image": "assets/home_image/Kedarnath.jpg",
        "description":
            "• Location: Uttarakhand, India\n• Religious Significance: One of the twelve Jyotirlingas dedicated to Lord Shiva\n• Char Dham Yatra: Part of the sacred Char Dham and Panch Kedar pilgrimage\n• Main Temple: Kedarnath Temple, believed to be built by the Pandavas and revived by Adi Shankaracharya\n• Mythological Connection: Associated with the Mahabharata and Lord Shiva’s divine presence\n• Altitude: Situated at 3,583 meters (11,755 ft) in the Himalayas\n• Mandakini River: Flows near the temple, adding to its spiritual charm\n• Architectural Marvel: Stone temple with intricate carvings, standing strong against time\n• Pilgrimage Season: Opens in summer (April-May) and closes in winter (November)\n• Trekking Route: Pilgrims trek 16 km from Gaurikund to reach the temple\n• Helicopter Services: Available for devotees unable to trek\n• Natural Beauty: Surrounded by snow-capped peaks and scenic landscapes\n• Extreme Weather: Harsh winters lead to temple closure, with the deity shifted to Ukhimath\n• Disaster & Resilience: Survived the devastating 2013 Uttarakhand floods\n• Bhairavnath Temple: Protector deity of Kedarnath, located nearby\n• Religious Rituals: Special pujas and Abhishek ceremonies performed daily\n• Connectivity: Nearest road access is at Sonprayag, followed by trek or helicopter\n• Spiritual Experience: Considered a path to salvation and inner peace\n• Tourism & Adventure: Attracts trekkers, nature lovers, and spiritual seekers\n• Eternal Devotion: Symbolizes faith, endurance, and divine energy in the Himalayas"
      },
      {
        "state": "Uttarakhand",
        "place": "Kedarnath Temple",
        "image": "assets/home_image/Kedarnath.jpg",
        "description":
            "• Location: Rudraprayag district, Uttarakhand, India\n• Dedicated To: Lord Shiva, one of the twelve Jyotirlingas\n• Elevation: Situated at 3,583 meters (11,755 feet) above sea level\n• Built By: Originally believed to be built by the Pandavas, later reconstructed by Adi Shankaracharya\n• Architectural Style: Traditional stone temple with a conical Shiva Lingam\n• Surrounded By: Snow-capped Himalayan peaks and the Mandakini River\n• Religious Significance: A vital part of the Char Dham and Panch Kedar pilgrimage\n• Open Season: Accessible only from April to November due to extreme winters\n• Trekking Route: 16 km trek from Gaurikund, offering breathtaking landscapes\n• Kedarnath Floods (2013): The temple miraculously survived a massive natural disaster\n• Adi Shankaracharya Samadhi: A memorial dedicated to the great saint near the temple\n• Spiritual Belief: Devotees believe visiting Kedarnath grants Moksha (liberation)\n• Bhairavnath Temple: A guardian deity of Kedarnath, located nearby\n• Best Time to Visit: May to June and September to October for a safe pilgrimage\n• Night Illumination: The temple looks divine when lit up during evening prayers\n• Rituals & Aarti: Daily worship ceremonies include Mahabhishek and Rudrabhishek\n• Pilgrimage Hub: Attracts millions of devotees and adventure seekers\n• Nearby Attractions: Vasuki Tal, Chorabari Tal, and Triyuginarayan Temple\n• Divine Energy: Considered one of the most spiritually charged places in India"
      },
      {
        "state": "West Bengal",
        "place": "Victoria Memorial",
        "image": "assets/home_image/victoria.webp",
        "description":
            "• Location: Kolkata, West Bengal, India\n• Built In: 1906-1921\n• Built By: Lord Curzon in memory of Queen Victoria\n• Architectural Style: Indo-Saracenic Revival, blending Mughal and British influences\n• Material Used: White Makrana marble, similar to the Taj Mahal\n• Spread Across: 64 acres with lush gardens and water bodies\n• Museum Inside: Showcases British-era paintings, manuscripts, and artifacts\n• Central Dome: Houses a 16-foot bronze Angel of Victory on top\n• Galleries: Includes Royal Gallery, National Leaders Gallery, and Calcutta Gallery\n• Garden Landscaping: Designed by Lord Redesdale and Sir David Prain\n• Light & Sound Show: Depicts the colonial history of India\n• Historical Significance: Symbolizes British rule and India's transition to independence\n• Iconic Reflection: The structure beautifully mirrors in the surrounding lakes\n• Best Time to Visit: October to March for pleasant weather\n• Cultural Hub: Hosts exhibitions, cultural events, and concerts\n• Tourist Attraction: One of the most visited landmarks in Kolkata\n• Open to Public: Functions as both a museum and a heritage site\n• Nearby Attractions: St. Paul’s Cathedral, Birla Planetarium, and Howrah Bridge\n• Evening Illumination: Looks mesmerizing when lit up at night\n• Symbol of Kolkata: Represents the city’s colonial past and artistic heritage"
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Destinations'),
        backgroundColor: const Color(0xFFF5A623),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 columns
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 1.2,
        ),
        itemCount: destinations.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DestinationDetailPage(
                    state: destinations[index]["state"]!,
                    place: destinations[index]["place"]!,
                    imagePath: destinations[index]["image"]!,
                    description: destinations[index]
                        ["description"]!, // Pass the description
                  ),
                ),
              );
            },
            child: Card(
              color: Color(0xFFF5A623), // Set the background color to gray
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 4,
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(10)),
                      child: Image.asset(
                        destinations[index]["image"]!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        Text(
                          destinations[index]["place"]!,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          destinations[index]["state"]!,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
