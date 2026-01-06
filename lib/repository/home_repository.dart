import 'package:doc_time/model/home_model.dart';

class HomeRepository {
  final List<Todo> _todoList = [];

  List<Todo> get todoList => List.unmodifiable(_todoList);

  void addTodo(Todo todo) {
    _todoList.add(todo);
  }

  void removeTodo(int id) {
    _todoList.removeWhere((data) => data.id == id);
  }

  void updateTodo(int index, Todo todo) {
      _todoList[index] = todo;
  }
}
