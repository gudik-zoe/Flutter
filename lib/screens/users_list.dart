import 'package:flutter/material.dart';
import 'package:validation_form/helpers/database_helper.dart';
import 'package:validation_form/models/form_model.dart';
import 'package:validation_form/screens/add_user.dart';
import 'package:intl/intl.dart';

class FormValidation extends StatefulWidget {
  @override
  _FormValidationState createState() => _FormValidationState();
}

class _FormValidationState extends State<FormValidation> {
  Future<List<Task>> _taskList;
  final DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');

  @override
  void initState() {
    super.initState();
    _updateTaskList();
  }

  _updateTaskList() {
    setState(() {
      _taskList = DatabaseHelper.instance.getTaskList();
    });
  }

  Widget _buildTask(Task task) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal:20.0),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              task.title,),
            subtitle: Text(
              'DateOfBirth: ${_dateFormatter.format(task.date)}' + '\n'+
              'Password: ${task.priority}',
              // style: TextStyle(
              //   fontSize: 15.0,
              //   decoration: task.status == 0
              //       ? TextDecoration.none
              //       : TextDecoration.lineThrough,
              // ),
            ),
            // trailing: Checkbox(
            //   onChanged: (value) {
            //     task.status = value ? 1 : 0;
            //     DatabaseHelper.instance.updateTask(task);
            //     _updateTaskList();
            //   },
            //   activeColor: Theme.of(context).primaryColor,
            //   value: task.status == 1 ? true : false,
            // ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AddTaskScreen(
                  updateTaskList: _updateTaskList,
                  task: task,
                ),
              ),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AddTaskScreen(
              updateTaskList: _updateTaskList,
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: _taskList,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          // final int completedTaskCount = snapshot.data
          //     .where((Task task) => task.status == 1)
          //     .toList()
          //     .length;

          return ListView.builder(
            // padding: EdgeInsets.symmetric(vertical: 10.0),
            itemCount: 1 + snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Users',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.0),
                     
                    ],
                  ),
                );
              }
              return _buildTask(snapshot.data[index - 1]);
            },
          );
        },
      ),
    );
  }
}
