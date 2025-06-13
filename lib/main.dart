import 'package:flutter/material.dart';
import 'models/note.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuickNotes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: false,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.grey.shade50,
        ),
      ),
      home: const NotesHomePage(),
    );
  }
}

class NotesHomePage extends StatefulWidget {
  const NotesHomePage({super.key});

  @override
  State<NotesHomePage> createState() => _NotesHomePageState();
}

class _NotesHomePageState extends State<NotesHomePage> {
  // List to store notes
  final List<Note> _notes = [];
  
  // Controllers for the text fields
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  
  // Focus nodes to manage keyboard focus
  final FocusNode _titleFocus = FocusNode();
  final FocusNode _descriptionFocus = FocusNode();

  // Add a new note to the list
  void _addNote() {
    // Validate that title is not empty
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a title for your note')),
      );
      return;
    }
    
    // Create a new note
    final newNote = Note(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: _descriptionController.text.trim(),
      createdAt: DateTime.now(),
    );
    
    // Add the note to the list and update the UI
    setState(() {
      _notes.insert(0, newNote); // Add to the beginning for reverse chronological order
      _titleController.clear();
      _descriptionController.clear();
    });
    
    // Return focus to title field for quick note entry
    _titleFocus.requestFocus();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _titleFocus.dispose();
    _descriptionFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('QuickNotes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Note input section
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Title input field
                    TextField(
                      controller: _titleController,
                      focusNode: _titleFocus,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                        hintText: 'Enter note title',
                      ),
                      textInputAction: TextInputAction.next,
                      onSubmitted: (_) {
                        _descriptionFocus.requestFocus();
                      },
                    ),
                    const SizedBox(height: 16),
                    
                    // Description input field
                    TextField(
                      controller: _descriptionController,
                      focusNode: _descriptionFocus,
                      decoration: const InputDecoration(
                        labelText: 'Description (optional)',
                        hintText: 'Enter note description',
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),
                    
                    // Add note button
                    ElevatedButton(
                      onPressed: () {
                        _addNote();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text('Add Note'),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Notes list section header
            const Text(
              'Your Notes',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 8),
            
            // Placeholder for notes list (will be implemented in next stages)
            Expanded(
              child: Center(
                child: Text(
                  'No notes yet. Add your first note above!',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
