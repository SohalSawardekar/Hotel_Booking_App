import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class StandardRoomGalleryPage extends StatefulWidget {
  const StandardRoomGalleryPage({super.key});

  @override
  _StandardRoomGalleryPageState createState() =>
      _StandardRoomGalleryPageState();
}

class _StandardRoomGalleryPageState extends State<StandardRoomGalleryPage> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    // Initialize the video controller
    _videoController = VideoPlayerController.asset(
        'assets/videos/standard_room.mp4') // Replace with actual video path
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
        : const Center(
            child: CircularProgressIndicator()); // Center the loading indicator
  }

  @override
  Widget build(BuildContext context) {
    final List<List<String>> imageGroups = [
      ['assets/images/standardroom.jpg']
    ];

    const String description =
        'Comfortable standard room with basic amenities and a cozy feel.';
    const String bedDetails = '1 King Size Bed';
    const String amenities = 'Free Wi-Fi, TV, Mini-Bar, Shower';
    const String extraBedCharges = '₹500 per night';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Standard Room Gallery'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Room Image Carousel with Multiple Images
            SizedBox(
              height: 250, // Adjusted to make room for multiple images
              child: PageView.builder(
                itemCount: imageGroups.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imageGroups[index].map((imageUrl) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(15), // Rounded corners
                          child: Image.asset(
                            imageUrl,
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width *
                                0.45, // Adjust width
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // Video Player Section
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
                        'Standard Room',
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
