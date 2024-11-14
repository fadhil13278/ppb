// screens/home_screen.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertodolistsqfliteapp/helpers/drawer_navigation.dart';
import 'package:fluttertodolistsqfliteapp/models/todo.dart';
import 'package:fluttertodolistsqfliteapp/screens/todo_screen.dart';
import 'package:fluttertodolistsqfliteapp/services/todo_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TodoService _todoService;
  List<Todo> _todoList = [];
  Set<int> _checkedItems = {}; // Track checked item IDs
  TextEditingController _searchController = TextEditingController();

  @override
  initState() {
    super.initState();
    _todoService = TodoService();
    getAllTodos();
    _searchController.addListener(() {
      filterSearchResults(_searchController.text);
    });
  }

  getAllTodos() async {
    var todos = await _todoService.readTodos();
    _todoList.clear();
    setState(() {
      todos.forEach((todo) {
        var model = Todo();
        model.id = todo['id'];
        model.title = todo['title'];
        model.description = todo['description'];
        model.category = todo['category'];
        model.todoDate = todo['todoDate'];
        model.isFinished = todo['isFinished'];
        _todoList.add(model);
      });
    });
  }

  filterSearchResults(String query) {
    if (query.isEmpty) {
      getAllTodos();
    } else {
      List<Todo> dummyListData = _todoList.where((item) {
        return item.title.toLowerCase().contains(query.toLowerCase()) ||
            item.description.toLowerCase().contains(query.toLowerCase());
      }).toList();
      setState(() {
        _todoList.clear();
        _todoList.addAll(dummyListData);
      });
    }
  }

  _editTodoItem(BuildContext context, Todo todo) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TodoScreen(todo: todo),
      ),
    );
    if (result == 'updated') {
      getAllTodos(); // Refresh the list after editing
      _showSuccessSnackBar(Text('Todo updated successfully'));
    }
  }

  _deleteCheckedItems() async {
    for (var id in _checkedItems) {
      await _todoService.deleteTodo(id);
    }
    _checkedItems.clear();
    getAllTodos();
    _showSuccessSnackBar(Text('Checked items deleted successfully'));
  }

  _showSuccessSnackBar(message) {
    var _snackBar = SnackBar(content: message);
    ScaffoldMessenger.of(context).showSnackBar(_snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todolist Tiber'),
        actions: <Widget>[
          if (_checkedItems.isNotEmpty) // Show delete icon if there are checked items
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: _deleteCheckedItems,
              tooltip: 'Delete selected items',
            ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(_todoList, _todoService, getAllTodos),
                );
              },
            ),
          ),
        ],
      ),
      drawer: DrawerNavigation(),
      body: ListView.builder(
          itemCount: _todoList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                child: ListTile(
                  leading: Checkbox(
                    value: _checkedItems.contains(_todoList[index].id),
                    onChanged: (value) {
                      setState(() {
                        if (value == true) {
                          _checkedItems.add(_todoList[index].id);
                        } else {
                          _checkedItems.remove(_todoList[index].id);
                        }
                      });
                    },
                  ),
                  title: Text(_todoList[index].title ?? 'No Title'),
                  subtitle: Text(_todoList[index].category ?? 'No Category'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          _editTodoItem(context, _todoList[index]);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          await _todoService.deleteTodo(_todoList[index].id);
                          getAllTodos(); // Refresh the list after deleting an item
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => TodoScreen())),
        child: Icon(Icons.add),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  final List<Todo> todos;
  final TodoService todoService;
  final Function updateTodos;

  CustomSearchDelegate(this.todos, this.todoService, this.updateTodos);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    var results = todos.where((todo) {
      return todo.title.toLowerCase().contains(query.toLowerCase()) ||
          todo.description.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        var todo = results[index];
        return ListTile(
          title: Text(todo.title),
          subtitle: Text(todo.description),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              await todoService.deleteTodo(todo.id);
              updateTodos();
              close(context, null);
            },
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var suggestions = todos.where((todo) {
      return todo.title.toLowerCase().contains(query.toLowerCase()) ||
          todo.description.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        var todo = suggestions[index];
        return ListTile(
          title: Text(todo.title),
          subtitle: Text(todo.description),
        );
      },
    );
  }
}
