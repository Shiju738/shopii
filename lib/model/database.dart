import 'package:flutter/material.dart';

// Enum to represent the source of users (active or archived)
enum Source {
  active,
  archived,
}

// User class representing a user in the database
class User {
  final String name;
  final int age;

  User({required this.name, required this.age, required String firstName, required String lastName});
}

// Database class to manage users
class Database extends ChangeNotifier {
  List<User> activeUsers = [];
  List<User> archivedUsers = [];

  // Creates new user and adds to activeUsers
  void addNewUser(User user) {
    activeUsers.add(user);
    notifyListeners();
  }

  // Moves user from active to archived
  void moveToArchived(User user) {
    archivedUsers.add(user);
    activeUsers.remove(user);
    notifyListeners();
  }

  // Moves user from archived to active
  void moveToActive(User user) {
    activeUsers.add(user);
    archivedUsers.remove(user);
    notifyListeners();
  }

  // Deletes user from database based on source
  bool deleteUser({required User user, required Source source}) {
    switch (source) {
      case Source.active:
        activeUsers.remove(user);
        notifyListeners();
        return true;
      case Source.archived:
        archivedUsers.remove(user);
        notifyListeners();
        return true;
    }
  }
}
