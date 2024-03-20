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
  group('AuthStateProvider', () {
    late AuthStateProvider authStateProvider;
    late MockFirebaseAuth mockFirebaseAuth;
    late MockFirebaseFirestore mockFirestore;
    late MockUserCredential mockUserCredential;
    late MockUser mockUser;

    setUp(() {
      mockFirebaseAuth = MockFirebaseAuth();
      mockFirestore = MockFirebaseFirestore();
      mockUserCredential = MockUserCredential();
      mockUser = MockUser();
      authStateProvider = AuthStateProvider();
    });

    test('SignUp - Successful', () async {
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
              email: anyNamed('email'), password: anyNamed('password')))
          .thenAnswer((_) => Future.value(mockUserCredential));
      when(mockUserCredential.user).thenReturn(mockUser);
      when(mockUser.uid).thenReturn('test_uid');
      await authStateProvider.signUp('test@example.com', 'password', 'Test User');
      expect(authStateProvider.currentUser, mockUser);
      expect(authStateProvider.uid, 'test_uid');
      expect(authStateProvider.isLoggedIn, true);
    });

    test('SignUp - Error', () async {
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
              email: anyNamed('email'), password: anyNamed('password')))
          .thenThrow(FirebaseAuthException(code: 'error', message: 'Error message'));
      await authStateProvider.signUp('test@example.com', 'password', 'Test User');
      expect(authStateProvider.hasError, true);
      expect(authStateProvider.errorCode, 'Error message');
      expect(authStateProvider.isLoggedIn, false);
    });

    test('SignIn - Successful', () async {
      when(mockFirebaseAuth.signInWithEmailAndPassword(
              email: anyNamed('email'), password: anyNamed('password')))
          .thenAnswer((_) => Future.value(mockUserCredential));
      when(mockUserCredential.user).thenReturn(mockUser);
      when(mockUser.uid).thenReturn('test_uid');
      await authStateProvider.signInWithEmailAndPassword('test@example.com', 'password');
      expect(authStateProvider.currentUser, mockUser);
      expect(authStateProvider.uid, 'test_uid');
      expect(authStateProvider.isLoggedIn, true);
    });

    test('SignIn - Error', () async {
      when(mockFirebaseAuth.signInWithEmailAndPassword(
              email: anyNamed('email'), password: anyNamed('password')))
          .thenThrow(FirebaseAuthException(code: 'error', message: 'Error message'));
      await authStateProvider.signInWithEmailAndPassword('test@example.com', 'password');
      expect(authStateProvider.hasError, true);
      expect(authStateProvider.errorCode, 'Error message');
      expect(authStateProvider.isLoggedIn, false);
    });

    test('SignOut', () async {
      when(mockFirebaseAuth.signOut()).thenAnswer((_) => Future.value());
      authStateProvider.currentUser = mockUser;
      authStateProvider.uid = 'test_uid';
      authStateProvider.isLoggedIn = true;
      await authStateProvider.signOut();
      expect(authStateProvider.currentUser, null);
      expect(authStateProvider.uid, null);
      expect(authStateProvider.isLoggedIn, false);
    });
  });
}
