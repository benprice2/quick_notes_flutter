import 'package:flutter/material.dart';
import '../models/note.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final VoidCallback? onDelete;

  const NoteCard({
    super.key,
    required this.note,
    this.onDelete,
  });

  // Format the date time for display
  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Note title and content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Note title
                        Text(
                          note.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.3,
                          ),
                        ),
                        if (note.description != null && note.description!.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        // Note description
                        Text(note.description!),
                      ],
                    ],
                  ),
                ),
                
                // Delete button
                if (onDelete != null)
                  Container(
                    margin: const EdgeInsets.only(left: 8),
                    child: IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: onDelete,
                      tooltip: 'Delete note',
                      style: IconButton.styleFrom(
                        foregroundColor: Colors.red.shade400,
                        backgroundColor: Colors.red.shade50,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            // Note timestamp
            Container(
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                _formatDateTime(note.createdAt),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }
}
