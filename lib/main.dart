import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/widgets/todoItem.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todos = Todo.toDoList();
  List<Todo> _searchTodo = [];
  TextEditingController todoController = TextEditingController();

  @override
  initState() {
    setState(() {
      _searchTodo = todos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
            ),
            CircleAvatar(
              backgroundImage: AssetImage("assets/profile.png"),
            ),
          ],
        ),
      ),
      body: _body(),
    );
  }

  _body() {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _searchBar(),
            _todos(),
            _input(),
          ],
        )
      ],
    );
  }

  _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: TextField(
            onChanged: (value) => search(value),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Search",
              prefix: Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _todos() {
    return Expanded(
        child: Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text("All Todos"),
          ),
          Expanded(
              child: ListView(
            children: [
              for (Todo todo in _searchTodo.reversed)
                TodoItem(
                    todo: todo,
                    onClick: () {
                      setState(() {
                        todo.isDone = !todo.isDone;
                      });
                    },
                    onDelete: () {
                      setState(() {
                        _searchTodo.remove(todo);
                      });
                    })
            ],
          ))
        ],
      ),
    ));
  }

  _input() {
    return Align(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: todoController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Add New Todo",
                    ),
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      _searchTodo
                          .add(Todo(id: "17", title: todoController.text));
                    });
                  },
                  icon: Icon(Icons.add))
            ],
          ),
        ),
      ),
    );
  }

  void search(String text) {
    List<Todo> result = [];

    if (text.isEmpty) {
      result = todos;
    } else {
      result = todos
          .where(
              (todo) => todo.title.toLowerCase().contains(text.toLowerCase()))
          .toList();
    }

    setState(() {
      _searchTodo = result;
    });
  }
}
