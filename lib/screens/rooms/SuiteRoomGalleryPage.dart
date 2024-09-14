import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SuiteRoomGalleryPage extends StatefulWidget {
  const SuiteRoomGalleryPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SuiteRoomGalleryPageState createState() => _SuiteRoomGalleryPageState();
}

class _SuiteRoomGalleryPageState extends State<SuiteRoomGalleryPage> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    // Initialize the video controller
    _videoController = VideoPlayerController.asset(
        'assets/videos/luxury_hotel.mp4')
      ..initialize().then((_) {
        setState(() {}); // Ensure the first frame is shown after initialization
      })
      ..setLooping(true) // Loop the video for continuous play
      ..setVolume(0.5); // Set default volume
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  Widget buildVideoPlayer() {
    return _videoController.value.isInitialized
        ? ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: AspectRatio(
              aspectRatio: _videoController.value.aspectRatio,
              child: VideoPlayer(_videoController),
            ),
          )
        : Center(
            child:
                const CircularProgressIndicator()); // Center the loading indicator
  }

  @override
  Widget build(BuildContext context) {
    // Group of image assets and one video item at the end
    final List<Widget> galleryItems = [
      'assets/images/suiteroom.jpg',
    ].map((imageUrl) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset(
            imageUrl,
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width * 0.9,
          ),
        ),
      );
    }).toList();

    // Adding video as the last item in the gallery
    galleryItems.add(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: buildVideoPlayer(),
      ),
    );

    const String description =
        'Suite offering separate living and sleeping areas with top-tier amenities.';
    const String bedDetails = '1 King Size Bed + 1 Single Bed';
    const String amenities = 'Free Wi-Fi, TV, Mini-Bar, Kitchenette';
    const String extraBedCharges = '₹1200 per night';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Suite Room Gallery'),
        backgroundColor: Colors.deepPurple, // A luxurious color for the suite
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gallery with images first and video last
            SizedBox(
              height: 250, // Adjusted height for images and video
              child: PageView(
                children: galleryItems,
              ),
            ),
            const SizedBox(height: 20),

            // Room Details Section using a Card for a clean design
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Suite Room',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        description,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Bed Type: $bedDetails',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Amenities: $amenities',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Extra Bed Charges: $extraBedCharges',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
