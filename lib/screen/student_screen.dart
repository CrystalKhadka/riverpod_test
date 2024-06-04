import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test/model/student.dart';
import 'package:riverpod_test/view_model/student_view_model.dart';

class StudentScreen extends ConsumerStatefulWidget {
  const StudentScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StudentScreenState();
}

class _StudentScreenState extends ConsumerState<StudentScreen> {
  final _gap = const SizedBox(height: 8);
  final _fnameController = TextEditingController();
  final _lnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final studentState = ref.watch(studentViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Screen'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: _fnameController,
              decoration: const InputDecoration(
                hintText: 'First Name',
                border: OutlineInputBorder(),
              ),
            ),
            _gap,
            TextFormField(
              controller: _lnameController,
              decoration: const InputDecoration(
                hintText: 'Last Name',
                border: OutlineInputBorder(),
              ),
            ),
            _gap,
            ElevatedButton(
              onPressed: () {
                Student student = Student(
                  fname: _fnameController.text,
                  lname: _lnameController.text,
                );
                ref.read(studentViewModelProvider.notifier).addStudent(student);
              },
              child: const Text('Add Student'),
            ),
            _gap,
            studentState.isLoading
                ? const CircularProgressIndicator()
                : studentState.lstStudents.isEmpty
                    ? const Text('No data')
                    : Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount: studentState.lstStudents.length,
                          itemBuilder: (context, index) {
                            Student student = studentState.lstStudents[index];
                            return ListTile(
                                leading: const Icon(Icons.person),
                                tileColor: Colors.blueAccent,
                                title: Text(student.fname),
                                subtitle: Text(student.lname),
                                trailing: Wrap(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                        _fnameController.text = student.fname;
                                        _lnameController.text = student.lname;

                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Stack(
                                                  children: [
                                                    Positioned(
                                                      right: -40,
                                                      top: -40,
                                                      child: InkResponse(
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child:
                                                            const CircleAvatar(
                                                          backgroundColor:
                                                              Colors.red,
                                                          child:
                                                              Icon(Icons.close),
                                                        ),
                                                      ),
                                                    ),
                                                    Form(
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8),
                                                            child:
                                                                TextFormField(
                                                              controller:
                                                                  _fnameController,
                                                              decoration:
                                                                  const InputDecoration(
                                                                hintText:
                                                                    'First Name',
                                                                border:
                                                                    OutlineInputBorder(),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8),
                                                            child:
                                                                TextFormField(
                                                              controller:
                                                                  _lnameController,
                                                              decoration:
                                                                  const InputDecoration(
                                                                hintText:
                                                                    'Last Name',
                                                                border:
                                                                    OutlineInputBorder(),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8),
                                                            child:
                                                                ElevatedButton(
                                                                    child: const Text(
                                                                        'Edit'),
                                                                    onPressed:
                                                                        () {
                                                                      Student student = Student(
                                                                          fname: _fnameController
                                                                              .text,
                                                                          lname:
                                                                              _lnameController.text);
                                                                      ref.read(studentViewModelProvider.notifier).updateStudent(
                                                                          index:
                                                                              index,
                                                                          student:
                                                                              student);
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    }),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            });
                                      },
                                      color: Colors.green,
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {
                                        ref
                                            .read(studentViewModelProvider
                                                .notifier)
                                            .deleteStudent(index);
                                      },
                                      color: Colors.red,
                                    ),
                                  ],
                                ));
                          },
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
