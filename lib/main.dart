import 'package:flutter/material.dart';
import 'models/note.dart';
import 'widgets/note_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuickNotes',
      debugShowCheckedModeBanner: false, // Remove debug banner
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4A6572), // Muted blue-gray
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: const Color(0xFF4A6572),
          foregroundColor: Colors.white,
          titleTextStyle: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
          ),
        ),
        // Card styling
        cardColor: Colors.white,

        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: const Color(0xFF4A6572), width: 2),
          ),
          filled: true,
          fillColor: Colors.grey.shade50,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4A6572),
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
          ),
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


  // Delete a note from the list
  void _deleteNote(String id) {
    setState(() {
      _notes.removeWhere((note) => note.id == id);
    });
    
    // Show confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Note deleted')),
    );
  }

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
        title: const Text('QuickNotes'),
        actions: [
          // Information icon
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('About QuickNotes'),
                  content: const Text(
                    'A simple note-taking app built with Flutter. '  
                    'Add, view, and delete notes with ease.\n\n'  
                    'Notes are stored in memory only and will be lost when the app is closed.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Close'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.grey.shade100,
              Colors.grey.shade200,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Note input section
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              shadowColor: Colors.black.withOpacity(0.1),
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
                    ElevatedButton.icon(
                      onPressed: () {
                        _addNote();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      icon: const Icon(Icons.add),
                      label: const Text('Add Note'),
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
            
            // Notes list
            Expanded(
              child: _notes.isEmpty
                ? Center(
                    child: Text(
                      'No notes yet. Add your first note above!',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  )
                : ListView.builder(
                    itemCount: _notes.length,
                    itemBuilder: (context, index) {
                      final note = _notes[index];
                      return Dismissible(
                        key: Key(note.id),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20.0),
                          color: Colors.red,
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        onDismissed: (direction) {
                          _deleteNote(note.id);
                        },
                        child: NoteCard(
                          note: note,
                          onDelete: () => _deleteNote(note.id),
                        ),
                      );
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
