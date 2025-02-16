# MovieMarks

**MovieMarks** is a Flutter application that allows users to discover, bookmark, and manage their favorite movies. The app provides features like movie search, categorization, detailed movie information, and personalized watch lists.

## Features

- **Search Movies**: Find movies by title or genre.
- **Bookmark Favorites**: Save movies to your watch list for easy access later.
- **Categorized Display**: View movies by popularity, rating, or release date.
- **Detailed Information**: Access detailed movie descriptions, cast, and ratings.
- **Watch List Management**: Add or remove movies from your personalized watch list.

<!-- ## Screenshots -->

## Getting Started

### Prerequisites

To run this project, ensure you have:

- [Flutter](https://flutter.dev/docs/get-started/install) installed on your system.
- An editor like [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/).
- A connected device or emulator to run the application.
- The backend for **MovieMarks** is available in a separate repository: [MovieMarks_BE](https://github.com/datlowashere/MovieMarks_BE).

### Installation


1. Clone the repository:
   ```bash
   git clone https://github.com/datlowashere/MovieMarks.git
   ```
2. Navigate to the project directory:
   ```bash
   cd MovieMarks
   ```
3. Fetch the dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```

## Usage

- Launch the app on your device or emulator.
- Search for movies using the search bar.
- Bookmark your favorite movies to add them to your watch list.
- View detailed movie information by selecting a movie from the list.

## Project Structure
The folder struture we built in this project based on layer-first structure and using [Bloc](https://bloclibrary.dev/) to manage states.
 ```
assets/
├─ icons/  	              # Icons to use across the app 
├─ images/		      # Images to use across the app
├─ fonts/	              # Custom fonts used throughout the app
│   
lib/                          # Root Package (Main application logic)
├─ constants/                 # Stores common constants used across the app
├─ data/                      # Data Layer 
│   ├─ models/                # Data Models
│   ├─ services/              # Service Layer
│   ├─ data_sources/          # Data Sources
│       ├─ local/             # Handles local data storage 
│       ├─ remote/            # Handles remote data fetching (API, Firebase, etc.)
│   ├─ repositories/          # Repositories for data management and interaction
├─ presentation/              # UI Layer
│   ├─ routes/
│   ├─ screens/               # App Screens
│       ├─ home/              # Home screen
│           ├─ bloc/          # Business logic components
│           ├─ page/          # Actual page layout for home
│           ├─ widget/        # Widgets used in the home screen
│   ├─ components/            # Reusable UI components
├─ configs/                   # Configuration Files 
│   ├─ app_config.dart        # Application configuration 
│   ├─ themes/                # Theming
├─ utils/                     # Utility functions/helpers
main.dart                     # Entry point for the Flutter application 
.gitignore                    # Specifies which files and directories to ignore in version control
README.md                     # Documentation for the project
 ```

## Dependencies

Key dependencies used in this project:

- **flutter**: SDK for building cross-platform apps.
- **firebase_core**: Core package for Firebase integration.
- **flutter_svg**: Rendering SVG images.
- **http**: For making HTTP requests.
- **flutter_bloc**: State management library.
- **equatable**: Simplifies equality comparisons.
- **shared_preferences**: Persistent storage for simple data.
- **bloc**: State management library.
- **dio**: Advanced HTTP client for Dart.
- **dartz**: Functional programming utilities.
- **flutter_easyloading**: Customizable loading indicators.
- **flashy_tab_bar2**: A modern tab bar.
- **cupertino_icons**: Icons for iOS design.
- **lazy_load_scrollview**: For lazy loading in lists.
- **scrollable_list_tab_scroller**: Tab scrolling functionality.
- **expandable_page_view**: Expandable and swipeable page view.
- **url_launcher**: Launch URLs in browsers or other apps.
- **fluttertoast**: Display toast messages.
- **flutter_otp_text_field**: OTP input fields.
- **flutter_rating_bar**: Rating bar widget.
- **intl**: Internationalization and localization.
- **image_picker**: Pick images from the gallery or camera.
- **permission_handler**: Manage permissions.
- **camera**: Access and control the device camera.
- **shimmer**: Add shimmer effects to UI components.

## Roadmap

- [ ] Add user authentication (Google/Facebook login).
- [ ] Implement filter movies
- [ ] Implement dark mode.
- [ ] Add notifications for new releases.
- [ ] Improve the UI/UX design.

## Contributing

Contributions are welcome! Follow these steps to contribute:

1. Fork the repository.
2. Create a feature branch:
   ```bash
   git checkout -b feature-name
   ```
3. Commit your changes:
   ```bash
   git commit -m "Add your message here"
   ```
4. Push to your branch:
   ```bash
   git push origin feature-name
   ```
5. Create a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Acknowledgements

- Inspired by movie enthusiasts and developers worldwide.
- Thanks to the Flutter community for providing guidance and tools.

## Contact

If you have any questions or feedback, feel free to contact me:

- GitHub: [@datlowashere](https://github.com/datlowashere)
