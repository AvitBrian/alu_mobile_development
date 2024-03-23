import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it_done/features/navigation/pages/plan_page.dart';
import 'package:get_it_done/providers/provider.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../authentication_test/authentication_test.dart';

class MockAuthStateProvider extends Mock implements AuthStateProvider {
   @override
  bool get signedState => false;
}

void main() {

//fireabse issues  

}

class AuthStateProviderMock extends AuthStateProvider {
  bool deleteTaskCalled = false;
  
  @override
  Future<void> deleteTask(String taskId) async {
    deleteTaskCalled = true;
  }
}
