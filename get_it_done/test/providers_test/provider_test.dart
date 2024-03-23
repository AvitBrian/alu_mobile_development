import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it_done/providers/provider.dart';

// Mock FirebaseAuth instance
class MockFirebaseAuth extends Mock implements FirebaseAuth {}

// Mock UserCredential class
class MockUserCredential extends Mock implements UserCredential {}

// Mock User class
class MockUser extends Mock implements User {}

// Mock FirebaseFirestore instance
class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

void main() {
//firebase issues.
}
