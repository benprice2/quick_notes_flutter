# QuickNotes

A simple, clean Flutter application for creating and managing notes. QuickNotes provides a minimalist interface for adding, viewing, and deleting notes with a focus on simplicity and usability.

![QuickNotes App](screenshots/app_preview.png)

> Note: The screenshot above is a placeholder. Replace it with an actual screenshot of your app.

## Features

- Clean, minimal Material Design interface
- Create notes with title and optional description
- View notes in reverse chronological order (newest first)
- Delete notes with swipe gesture or delete button
- Responsive design that works across different screen sizes

## Project Structure

- `lib/models`: Contains the Note model class
- `lib/widgets`: Contains reusable widgets like NoteCard
- `lib/main.dart`: Main application entry point and UI logic

## Getting Started

### Prerequisites

- Flutter SDK installed on your machine
- An IDE (VS Code, Android Studio, etc.)

### Running the App

1. Clone this repository
2. Navigate to the project directory
3. Run the following commands:

```bash
flutter pub get
flutter run
```

## Development Notes

This app uses basic state management with `setState()` for simplicity. Notes are stored in memory only and will be lost when the app is closed.

## Future Enhancements

- Persistent storage using shared preferences or a local database
- Note categories/tags
- Search functionality
- Note editing
- Dark mode theme support

## Development Process

This app was developed following a structured approach with the following stages:

1. **Project Setup**: Initialize Flutter project and set up folder structure
2. **Data Model**: Create the Note model class with title, description, and timestamp
3. **UI Layout**: Build the main app layout with Material Design components
4. **State Management**: Implement functionality to add notes with setState()
5. **List Display**: Create the NoteCard widget and display notes in reverse chronological order
6. **Delete Functionality**: Add swipe-to-delete and delete button functionality
7. **UI Polish**: Enhance the visual design with improved styling and animations
8. **Testing**: Manual testing of all note actions
9. **Documentation**: Create comprehensive README with instructions

## Technical Details

- **State Management**: Uses Flutter's built-in setState() for simplicity
- **UI Framework**: Material Design 3 with custom color scheme
- **Animations**: Includes subtle animations for better user experience
- **Responsive Design**: Adapts to different screen sizes
- **Gesture Support**: Implements swipe-to-delete for intuitive interaction
