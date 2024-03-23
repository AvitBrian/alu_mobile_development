import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it_done/features/navigation/pages/tasks_page.dart';
import 'package:get_it_done/providers/provider.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

class MockAuthStateProvider extends Mock implements AuthStateProvider {
   @override
  bool get signedState => false;
}

void main() {

  //there is nothing to test. the page is blank by default. :)
 
}


