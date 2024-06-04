import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test/model/student.dart';
import 'package:riverpod_test/state/student_state.dart';

final studentViewModelProvider =
    StateNotifierProvider<StudentViewModel, StudentState>((ref) {
  return StudentViewModel();
});

class StudentViewModel extends StateNotifier<StudentState> {
  StudentViewModel() : super(StudentState.initial());

  void addStudent(Student student) async {
    state = state.copyWith(isLoading: true);
    await Future.delayed(
      const Duration(seconds: 2),
    );
    state = state.copyWith(isLoading: false, student: student);
  }

  void deleteStudent(int index) async {
    state = state.copyWith(isLoading: true);
    await Future.delayed(
      const Duration(seconds: 2),
    );
    state = state.deleteAt(isLoading: false, index: index);
  }

  void updateStudent({required int index, required Student student}) async {
    state = state.copyWith(isLoading: true);
    await Future.delayed(
      const Duration(seconds: 2),
    );
    state = state.updateAt(isLoading: false, index: index, student: student);
  }
}
