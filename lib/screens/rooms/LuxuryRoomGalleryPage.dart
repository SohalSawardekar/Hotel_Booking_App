import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class LuxuryRoomGalleryPage extends StatefulWidget {
  const LuxuryRoomGalleryPage({super.key});

  @override
  _LuxuryRoomGalleryPageState createState() => _LuxuryRoomGalleryPageState();
}

class _LuxuryRoomGalleryPageState extends State<LuxuryRoomGalleryPage> {
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
            child: CircularProgressIndicator()); // Center the loading indicator
  }

  @override
  Widget build(BuildContext context) {
    // Groups of multiple images to be shown per slide
    final List<List<String>> imageGroups = [
      ['assets/images/luxuryRoom.jpeg']
    ];

    const String description =
        'Luxury room with high-end finishes, designed for comfort and relaxation.';
    const String bedDetails = '2 Queen Size Beds';
    const String amenities = 'Free Wi-Fi, TV, Mini-Bar, Jacuzzi';
    const String extraBedCharges = '₹1000 per night';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Luxury Room Gallery'),
        backgroundColor: Colors.indigoAccent, // Stylish color for luxury feel
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Room Image Carousel
            SizedBox(
              height: 250, // Adjusted height for larger image display
              child: PageView.builder(
                itemCount: imageGroups.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imageGroups[index].map((imageUrl) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              15), // Rounded corners for images
                          child: Image.asset(
                            imageUrl,
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width *
                                0.45, // Adjusted width
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // Video Player Section with Padding
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: buildVideoPlayer(),
            ),
            const SizedBox(height: 20),

            // Room Details Section with Card Layout
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
                        'Luxury Room',
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
