import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/todo.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({super.key});

  static const routeName = 'add-new';

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _noteController = TextEditingController();
  String dropValue = 'work';
  DateTime? _notificationDate;

  void _picker() async {
    DateTime? nD = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (nD == null) {
      return;
    }
    // ignore: use_build_context_synchronously
    final nT = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 01, minute: 01),
    );
    if (nT == null) {
      return;
    }
    nD = DateTime(nD.year, nD.month, nD.day, nT.hour, nT.minute);
    setState(() {
      _notificationDate = nD;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 30, right: 14, left: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'New Task',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.clear),
                  ),
                ],
              ),
              const SizedBox(height: 27),
              const Text(
                'What are you planning?',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  letterSpacing: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, bottom: 18),
                child: TextField(
                  style: const TextStyle(fontSize: 21),
                  maxLines: 6,
                  controller: _titleController,
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.notifications,
                    size: 35,
                    color: Colors.indigo[300],
                  ),
                  const SizedBox(width: 14),
                  Text(
                    DateFormat.d()
                        .add_MMMM()
                        .add_Hm()
                        .format(_notificationDate ?? DateTime.now())
                        .toString(),
                    style: const TextStyle(fontSize: 20),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: _picker,
                    icon: Icon(
                      Icons.edit,
                      color: Colors.blue[800],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Icon(
                    Icons.note_alt_sharp,
                    size: 35,
                    color: Colors.yellow[400],
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: TextField(
                      controller: _noteController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Add Note',
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  ShaderMask(
                    child: const Icon(
                      Icons.category,
                      size: 35,
                      color: Colors.white,
                    ),
                    shaderCallback: (Rect bounds) {
                      return const LinearGradient(
                        colors: [
                          Colors.blue,
                          Colors.red,
                          Colors.green,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds);
                    },
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: DropdownButton(
                        // hint: const Padding(
                        //   padding: EdgeInsets.all(8.0),
                        //   child: Text('Category'),
                        // ),
                        value: dropValue,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.black),
                        isExpanded: true,
                        iconSize: 42,
                        dropdownColor: Colors.white,

                        // selectedItemBuilder: (context) => ,
                        underline: const Divider(
                          endIndent: 0,
                          indent: 0,
                          height: 0,
                          thickness: 2,
                        ),
                        items: const [
                          DropdownMenuItem(value: 'work', child: Text('Work')),
                          DropdownMenuItem(
                              value: 'music', child: Text('Music')),
                          DropdownMenuItem(
                              value: 'travel', child: Text('Travel')),
                          DropdownMenuItem(
                              value: 'study', child: Text('Study')),
                          DropdownMenuItem(value: 'home', child: Text('Home')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            dropValue = value!;
                          });
                        }),
                  ),
                  const Spacer(
                    flex: 2,
                  )
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Create',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
    ;
  }
}
