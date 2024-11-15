// screens/todo_screen.dart
import 'package:flutter/material.dart';
import 'package:fluttertodolistsqfliteapp/models/todo.dart';
import 'package:fluttertodolistsqfliteapp/services/category_service.dart';
import 'package:fluttertodolistsqfliteapp/services/todo_service.dart';
import 'package:intl/intl.dart';

class TodoScreen extends StatefulWidget {
  final Todo todo; // Removed null safety marker

  TodoScreen({this.todo}); // Constructor remains the same

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  var _todoTitleController = TextEditingController();
  var _todoDescriptionController = TextEditingController();
  var _todoDateController = TextEditingController();
  var _selectedValue;
  var _categories = List<DropdownMenuItem>.empty(growable: true);
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  DateTime _dateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      // Load existing Todo data if editing
      _todoTitleController.text = widget.todo.title ?? '';
      _todoDescriptionController.text = widget.todo.description ?? '';
      _todoDateController.text = widget.todo.todoDate ?? '';
      _selectedValue = widget.todo.category;
    }
    _loadCategories();
  }

  _loadCategories() async {
    var _categoryService = CategoryService();
    var categories = await _categoryService.readCategories();
    categories.forEach((category) {
      setState(() {
        _categories.add(DropdownMenuItem(
          child: Text(category['name']),
          value: category['name'],
        ));
      });
    });
  }

  _selectedTodoDate(BuildContext context) async {
    var _pickedDate = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (_pickedDate != null) {
      setState(() {
        _dateTime = _pickedDate;
        _todoDateController.text = DateFormat('yyyy-MM-dd').format(_pickedDate);
      });
    }
  }

  _showSuccessSnackBar(message) {
    var _snackBar = SnackBar(content: message);
    ScaffoldMessenger.of(context).showSnackBar(_snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text(widget.todo == null ? 'Create Todo' : 'Edit Todo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _todoTitleController,
              decoration: InputDecoration(
                  labelText: 'Title', hintText: 'Write Todo Title'),
            ),
            TextField(
              controller: _todoDescriptionController,
              decoration: InputDecoration(
                  labelText: 'Description', hintText: 'Write Todo Description'),
            ),
            TextField(
              controller: _todoDateController,
              decoration: InputDecoration(
                labelText: 'Date',
                hintText: 'Pick a Date',
                prefixIcon: InkWell(
                  onTap: () {
                    _selectedTodoDate(context);
                  },
                  child: Icon(Icons.calendar_today),
                ),
              ),
            ),
            DropdownButtonFormField(
              value: _selectedValue,
              items: _categories,
              hint: Text('Category'),
              onChanged: (value) {
                setState(() {
                  _selectedValue = value;
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              onPressed: () async {
                var todoObject = Todo();
                todoObject.title = _todoTitleController.text;
                todoObject.description = _todoDescriptionController.text;
                todoObject.isFinished = widget.todo != null ? widget.todo.isFinished : 0;
                todoObject.category = _selectedValue.toString();
                todoObject.todoDate = _todoDateController.text;

                var _todoService = TodoService();
                if (widget.todo == null) {
                  // Adding a new Todo
                  var result = await _todoService.saveTodo(todoObject);
                  if (result > 0) {
                    _showSuccessSnackBar(Text('Created'));
                  }
                } else {
                  // Updating an existing Todo
                  todoObject.id = widget.todo.id;
                  var result = await _todoService.updateTodo(todoObject);
                  if (result > 0) {
                    _showSuccessSnackBar(Text('Updated'));
                    Navigator.pop(context, 'updated');
                  }
                }
              },
              color: Colors.blue,
              child: Text(
                widget.todo == null ? 'Save' : 'Update',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
