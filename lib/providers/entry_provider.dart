import 'package:flutter/foundation.dart';
import '../models/entry.dart';
import '../repositories/database_repository.dart';

/// Provider: Manages app state and notifies listeners of changes
/// Think of it as a central data store for your entries
class EntryProvider extends ChangeNotifier {
  final DatabaseRepository _repository = DatabaseRepository();

  // Private list of entries
  List<Entry> _entries = [];

  // Loading state
  bool _isLoading = false;

  // Error message
  String? _errorMessage;

  // Public getters (read-only access)
  List<Entry> get entries => _entries;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Load all entries from database
  Future<void> loadEntries() async {
    _setLoading(true);
    _errorMessage = null;

    try {
      _entries = await _repository.getAllEntries();
      notifyListeners(); // Tell UI to rebuild
    } catch (e) {
      _errorMessage = 'Failed to load entries: $e';
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  /// Add a new entry
  Future<void> addEntry(Entry entry) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      // Insert into database
      final id = await _repository.insertEntry(entry);

      // Add to local list with generated ID
      final newEntry = entry.copyWith(id: id);
      _entries.insert(0, newEntry); // Add to top

      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to add entry: $e';
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  /// Update an existing entry
  Future<void> updateEntry(Entry entry) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      await _repository.updateEntry(entry);

      // Update in local list
      final index = _entries.indexWhere((e) => e.id == entry.id);
      if (index != -1) {
        _entries[index] = entry;
      }

      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to update entry: $e';
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  /// Delete an entry
  Future<void> deleteEntry(int id) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      await _repository.deleteEntry(id);

      // Remove from local list
      _entries.removeWhere((entry) => entry.id == id);

      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to delete entry: $e';
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  /// Helper to update loading state
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
