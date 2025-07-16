import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(const ImageGalleryApp());
}

class ImageGalleryApp extends StatelessWidget {
  const ImageGalleryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Folders Gallery',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const GalleryScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  Map<String, List<String>> folderImages = {};

  @override
  void initState() {
    super.initState();
    loadImages();
  }

  Future<void> loadImages() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    final imagePaths = manifestMap.keys
        .where((String key) => _isImageFile(key))
        .toList();

    final Map<String, List<String>> folders = {};

    for (var path in imagePaths) {
      final folder = path.split('/')[1];
      folders.putIfAbsent(folder, () => []);
      folders[folder]!.add(path);
    }

    setState(() {
      folderImages = folders;
    });
  }

  bool _isImageFile(String path) {
    final lower = path.toLowerCase();
    return lower.endsWith('.png') ||
        lower.endsWith('.jpg') ||
        lower.endsWith('.jpeg') ||
        lower.endsWith('.gif');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
      ),
      body: folderImages.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: folderImages.keys.length,
        itemBuilder: (context, index) {
          final folderName = folderImages.keys.elementAt(index);
          final images = folderImages[folderName]!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text(
                  folderName.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                ),
                itemCount: images.length,
                itemBuilder: (context, imgIndex) {
                  final imagePath = images[imgIndex];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FullscreenGallery(
                            images: images,
                            initialIndex: imgIndex,
                          ),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class FullscreenGallery extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const FullscreenGallery({
    super.key,
    required this.images,
    required this.initialIndex,
  });

  @override
  State<FullscreenGallery> createState() => _FullscreenGalleryState();
}

class _FullscreenGalleryState extends State<FullscreenGallery> {
  late PageController _pageController;
  late int currentIndex;
  Set<String> favorites = {};

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void _shareImage() {
    final imagePath = widget.images[currentIndex];
    Share.share('Check out this image: $imagePath');
  }

  void _deleteImage() {
    setState(() {
      widget.images.removeAt(currentIndex);
      if (currentIndex >= widget.images.length) {
        currentIndex = widget.images.length - 1;
      }
    });
    if (widget.images.isEmpty) {
      Navigator.pop(context);
    }
  }

  void _toggleFavorite() {
    final imagePath = widget.images[currentIndex];
    setState(() {
      if (favorites.contains(imagePath)) {
        favorites.remove(imagePath);
      } else {
        favorites.add(imagePath);
      }
    });
  }

  void _showDetails() {
    final imagePath = widget.images[currentIndex];
    final imageName = imagePath.split('/').last;
    const imageSize = '2.3 MB';
    const dateTime = '5 July 2025, 10:25 AM';
    const location = 'Hyderabad, India';

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Image Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: $imageName'),
            Text('Size: $imageSize'),
            Text('Date & Time: $dateTime'),
            Text('Location: $location'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          )
        ],
      ),
    );
  }

  void _editImage() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Wrap(
        children: [
          _bottomItem(Icons.crop, 'Framing'),
          _bottomItem(Icons.tune, 'Adjust'),
          _bottomItem(Icons.face_retouching_natural, 'Beauty'),
          _bottomItem(Icons.brush, 'Erase'),
          _bottomItem(Icons.filter, 'Filters'),
          _bottomItem(Icons.border_outer, 'Border'),
        ],
      ),
    );
  }

  void _moreOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Wrap(
        children: [
          _bottomItem(Icons.wallpaper, 'Set as Wallpaper'),
          _bottomItem(Icons.search, 'Google Lens'),
          _bottomItem(Icons.picture_as_pdf, 'Super Document'),
          _bottomItem(Icons.copy, 'Copy to'),
          _bottomItem(Icons.visibility_off, 'Hide'),
          _bottomItem(Icons.edit, 'Rename'),
          _bottomItem(Icons.slideshow, 'Slideshow'),
        ],
      ),
    );
  }

  ListTile _bottomItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('$title selected.')));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final imagePath = widget.images[currentIndex];
    final isFavorite = favorites.contains(imagePath);

    return Scaffold(
      appBar: AppBar(
        title: Text('Image ${currentIndex + 1} / ${widget.images.length}'),
        actions: [
          IconButton(
            icon: Icon(isFavorite ? Icons.star : Icons.star_border),
            onPressed: _toggleFavorite,
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: _showDetails,
          ),
        ],
      ),
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            itemCount: widget.images.length,
            pageController: _pageController,
            onPageChanged: onPageChanged,
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: AssetImage(widget.images[index]),
                initialScale: PhotoViewComputedScale.contained,
                minScale: PhotoViewComputedScale.contained * 0.8,
                maxScale: PhotoViewComputedScale.covered * 3.0,
                heroAttributes:
                PhotoViewHeroAttributes(tag: widget.images[index]),
              );
            },
            scrollPhysics: const BouncingScrollPhysics(),
            backgroundDecoration: const BoxDecoration(color: Colors.black),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha((0.4 * 255).toInt()),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: const Icon(Icons.share, color: Colors.white),
                    onPressed: _shareImage,
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.white),
                    onPressed: _editImage,
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.white),
                    onPressed: _deleteImage,
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert, color: Colors.white),
                    onPressed: _moreOptions,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
