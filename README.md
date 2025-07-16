# image_gallery

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Project Stucture
image_gallery_app/

<img width="2048" height="2048" alt="structure" src="https://github.com/user-attachments/assets/0691aec4-56c7-4b1d-baa1-8ddb2da14ac7" />


## Dependencies 

1. image_picker
Version: ^1.0.4
Purpose: Pick images from the gallery or camera.

Usage:

final picker = ImagePicker();
final pickedFile = await picker.pickImage(source: ImageSource.gallery); // or ImageSource.camera
Common Use Case:

User taps "Add Image" → opens gallery/camera → image gets added to gallery view.

2. path_provider
Version: ^2.1.2
Purpose: Get platform-specific directories, like app storage path.

Usage:

final dir = await getApplicationDocumentsDirectory();
final path = dir.path; // e.g., /data/user/0/com.example.app/files/
Common Use Case:

Saving picked images locally.

Loading user-saved images on app startup.

3. photo_view
Version: ^0.14.0
Purpose: Show images in fullscreen with pinch-to-zoom support.

Usage:

PhotoView(
  imageProvider: FileImage(File(imagePath)),
);
Common Use Case:

Tapping on a gallery image → opens fullscreen zoomable view.

4. share_plus
Version: ^7.2.1
Purpose: Share images or text via native share dialogs (WhatsApp, Gmail, etc).

Usage:

Share.shareFiles([imagePath], text: 'Check out this image!');
Common Use Case:

User taps "Share" → opens system share sheet with the selected image.

## Use Case


 The image displays a use case diagram illustrating the user 
journey for selecting an image from a mobile device's gallery. It begins with a client 
device (Android or iPhone) initiating the "Open Image Gallery App" action. This leads to 
the display of various folders (e.g., Camera, Downloads, Screenshots). The user then 
selects a folder, after which the images within that chosen folder are displayed, allowing 
the user to pick a specific image before the process concludes.
![use case](https://github.com/user-attachments/assets/1914ca4c-30b8-4d61-8443-11f324b4fe26)


## Sequence Diagram

This image depicts a flowchart of an image gallery application's 
user flow. It illustrates how a user can browse image folders, then view individual 
images, and enter a fullscreen mode. From fullscreen, options for sharing, editing (like 
cropping or enhancing), and setting the image as wallpaper are presented.

![sequnce](https://github.com/user-attachments/assets/0c6a9ec1-ad1a-4744-ac49-56c907549938)

