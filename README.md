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

## Project Structure
image_gallery_app/

<img width="2048" height="2048" alt="structure" src="https://github.com/user-attachments/assets/60b2d4a6-7c64-4bbe-86c2-1a0b6898dc9c" />



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


## Output


🖼️ **Main Gallery Screen (`home_screen.dart`)**

* Shows a **grid of images** from the `assets/image/` or `assets/camera/` folder.
* Simple, clean UI using `GridView`.
* Tapping an image can optionally open it in fullscreen (not included since `full_image_screen.dart` was removed).

---


### 📌 App Layout:

```
+------------------------------------+
|           Image Gallery App        |
+------------------------------------+
| [Image 1]  [Image 2]  [Image 3]    |
| [Image 4]  [Image 5]  [Image 6]    |
|  ... Loaded from assets/...        |
+------------------------------------+
```

* Each image tile is square and scrollable.
* No zoom/fullscreen support (since you removed `full_image_screen.dart`).
* No file services or data models (clean structure).
## 📱 **Visual Output (UI Overview)**


<img width="700" height="1000" alt="Screenshot_20250716_232732" src="https://github.com/user-attachments/assets/02dc2b7f-f69c-410d-af04-4e2121b3bfc2" />


<img width="700" height="1000" alt="Screenshot_20250716_232811" src="https://github.com/user-attachments/assets/e37c2253-2543-4233-b957-19bb2adfabe4" />


## ✅ Final App Behavior

| Feature              | Works?                              |
| -------------------- | ---------------------------------- -|
| Display local images | ✅ Yes                              |
| Image Picker         | ⚠️ Not active unless added in code  |
| Fullscreen zoom      | ✅ Yes                              |
| File save/share      | ✅ Yes                              |
| Simple Grid UI       | ✅ Yes                              |


---

## Conclusion


### ✅ **Conclusion: Simplified Flutter Image Gallery App**

You’ve successfully designed a **minimal Flutter Image Gallery App** structure with only essential components. Here's what this final version includes:

---

📂 **Project Summary**

* **No Firebase** — Local-only image gallery
* **No extra complexity** — Removed full-screen viewer, services, models, and utility files
* **Flat structure** — Only `main.dart` and `home_screen.dart` handle the UI logic
* **Assets-based loading** — Displays images from `assets/image/` and `assets/camera/`

---

🚀 **What Works**

* Clean, basic grid of images using `GridView`
* Easy to extend later (picker, fullscreen view, sharing, etc.)
* Lightweight and suitable for beginners

---

🧱 **Next Steps (Optional Enhancements)**

If you want to build on this base:

* Add **image\_picker** to allow importing new images
* Add **fullscreen view** using `photo_view`
* Use **share\_plus** to share images
* Integrate **permission\_handler** for camera/gallery access

---

