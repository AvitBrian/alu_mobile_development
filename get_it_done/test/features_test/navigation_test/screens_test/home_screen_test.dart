import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it_done/features/navigation/screens/home_screen.dart';
import 'package:get_it_done/providers/provider.dart';
import 'package:provider/provider.dart';
import 'package:mockito/mockito.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

// Mock AuthStateProvider class using Mockito
class MockAuthStateProvider extends Mock implements AuthStateProvider {
  @override
  bool get signedState => false;
}

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

void main() {
 //firestore issues.
}
