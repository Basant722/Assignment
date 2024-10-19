# Assignment
Image Gallery App
A simple image gallery app built using Swift and the MVVM architecture pattern. This app fetches images from the Unsplash API and displays them in a collection view with search functionality. The app also supports dark mode, accessibility features, and efficient data fetching.

Features
Fetch and display images from the Unsplash API.
Search images using a search bar.
Custom text field and button for submitting forms.
Dark mode support.
Pull-to-refresh functionality for refreshing image data.
Efficient data fetching with async/await.
Graceful handling of network errors.
Accessibility features such as VoiceOver support.
Requirements
Xcode 15.4 or later
Swift 5.9 or later
iOS 14.0 or later
How to Run the Project
Clone the repository:
bash
Copy code
git clone <your-repo-url>
Navigate to the project directory:
bash
Copy code
cd ImageGalleryApp
Open the project in Xcode:
bash
Copy code
open ImageGalleryApp.xcodeproj
Install CocoaPods dependencies (if any):
bash
Copy code
pod install
Build and run the project:
Choose the desired simulator or connect a physical device.
Press Cmd + R to run the project.
Challenges Faced and Solutions
1. Image Duplication
Issue: When loading images from the API, some images were duplicated due to multiple instances of the same ID.
Solution: Used a Set to filter out duplicate image IDs before appending them to the image array.
2. Handling Network Errors
Issue: Handling errors such as no internet connection or invalid responses from the API was crucial to providing a good user experience.
Solution: Implemented a graceful error handling system using UIAlertController to notify users of errors. For instance, in case of a failed network request, the app shows an alert with an appropriate message.
3. Concurrency & Performance
Issue: Ensuring smooth user experience while fetching images without blocking the main thread.
Solution: Implemented image fetching using Swift's modern async/await to handle asynchronous operations efficiently. This prevents the main thread from being blocked during network requests, ensuring the app remains responsive.
4. Dark Mode Support
Issue: Ensuring that the app’s UI looks good in both light and dark mode.
Solution: Used system colors like systemBackground, label, etc., and applied adaptive custom colors programmatically to ensure consistent appearance across light and dark modes.
5. Pull to Refresh
Issue: Enabling the user to refresh the image collection manually using a pull-to-refresh gesture.
Solution: Implemented UIRefreshControl to allow users to refresh the images by pulling down the collection view.
Architecture Choices: MVVM
The project follows the MVVM (Model-View-ViewModel) architecture pattern, which ensures clear separation of concerns and better maintainability:

1. Model
Contains the data structures for holding the fetched image data.
Includes the networking logic for fetching images from the Unsplash API.
2. View
The ViewController displays the images and user interface elements such as the collection view, search bar, custom text field, and button.
Interacts with the user and passes user actions (like search queries) to the ViewModel.
3. ViewModel
The ImageGalleryViewModel contains the logic for fetching images and preparing data for the ViewController.
Handles the fetching of data from the API asynchronously and transforms it into a format that can be easily displayed by the ViewController.
Exposes a closure (onUpdate) to notify the ViewController when the data is ready.
This architecture allows for easier testing and scalability. By separating the data-fetching logic from the view, the code becomes easier to manage and maintain, especially as the app grows.

By following this architecture and solving the above challenges, this app ensures a clean, scalable structure while providing a smooth user experience.

License
MIT License

