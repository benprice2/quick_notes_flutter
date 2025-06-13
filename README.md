# QuickNotes

A simple, clean Flutter application for creating and managing notes. QuickNotes provides a minimalist interface for adding, viewing, and deleting notes with a focus on simplicity and usability.

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
