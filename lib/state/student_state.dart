import 'package:riverpod_test/model/student.dart';

class StudentState {
  final List<Student> lstStudents;
  final bool isLoading;

  StudentState({
    required this.lstStudents,
    required this.isLoading,
  });

  // Initial Cons
  factory StudentState.initial() {
    return StudentState(lstStudents: [], isLoading: false);
  }

  StudentState copyWith({Student? student, bool? isLoading}) {
    return StudentState(
        lstStudents: student != null ? [...lstStudents, student] : lstStudents,
        isLoading: isLoading ?? this.isLoading);
  }

  StudentState deleteAt({required bool isLoading, required int index}) {
    return StudentState(
        lstStudents: lstStudents..removeAt(index), isLoading: isLoading);
  }
}
