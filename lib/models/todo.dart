class Todo {
  String id;
  String title;
  bool isDone;

  Todo({required this.id, required this.title, this.isDone = false});

  void isToggleDone() {
    isDone = !isDone;
  }

  static List<Todo> toDoList() {
    return [
      //Initializing some dummy values
      Todo(id: "1", title: "Buy Milk"),
      Todo(id: "2", title: "Buy Eggs", isDone: true),
      Todo(id: "3", title: "Buy Bread")
    ];
  }
}
