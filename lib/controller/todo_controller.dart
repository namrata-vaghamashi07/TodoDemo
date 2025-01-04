// controllers/todo_controller.dart

import 'dart:async';

import 'package:get/get.dart';
import 'package:todo_demo/data/todo_model.dart';
import 'package:todo_demo/data/todo_repository.dart';

class TodoController extends GetxController {
  final TodoRepository todoRepository = TodoRepository.instance;
  RxList<Todo> todoList = <Todo>[].obs;
  RxBool isLoading = false.obs;
  RxInt minutes = 0.obs;
  RxInt seconds = 0.obs;
  Timer? _timer;
  RxBool isPaused = false.obs;
  RxBool isRunning = false.obs;
  RxString todoStatusUpdate = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadTodos();
  }

  // Get todo list
  void loadTodos() async {
    isLoading.value = true;
    todoList.value = await todoRepository.getTodos();
    isLoading.value = false;
  }

  // Add todo item
  void addTodo(Todo todo) async {
    await todoRepository.addTodo(todo);
    loadTodos();
  }

  // Update todo item
  void updateTodo(Todo todo) async {
    await todoRepository.updateTodo(todo);
    loadTodos();
  }

  //Delete todo item
  void deleteTodo(int id) async {
    await todoRepository.deleteTodo(id);
    loadTodos();
  }

  // Init Todo Value Set
  void initTodoValueSet(Todo todo) {
    List<String> parts = todo.timer.split(':');
    minutes.value = int.parse(parts[0]);
    seconds.value = int.parse(parts[1]);
    todoStatusUpdate.value = todo.status;
    isPaused.value = false;
    isRunning.value = false;
  }

  // Start the timer
  void startTimer(String timer, int id) {
    List<String> parts = timer.split(':');

    minutes.value = int.parse(parts[0]);
    seconds.value = int.parse(parts[1]);
    todoStatusUpdate.value = 'In-Progress';
    if (!isRunning.value) {
      isRunning.value = true;
      isPaused.value = false;

      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (minutes.value == 0 && seconds.value == 0) {
          _timer?.cancel();
          isRunning.value = false;
        } else {
          if (seconds.value > 0) {
            seconds.value--;
          } else {
            if (minutes.value > 0) {
              minutes.value--;
              seconds.value = 59;
            }
          }
          var timerString = timerFormat(minutes.value, seconds.value);
          updateTodoStatus(id, todoStatusUpdate.value, timerString);
        }
      });
    }
  }

  // Pause the timer
  void pauseTimer(int id) {
    if (isRunning.value && !isPaused.value) {
      _timer?.cancel();
      isRunning.value = false;
      isPaused.value = true;
      var timerString = timerFormat(minutes.value, seconds.value);
      updateTodoStatus(id, todoStatusUpdate.value, timerString);
    }
  }

  // Resume the timer after pause
  void resumeTimer(int id) {
    todoStatusUpdate.value = 'In-Progress';
    if (!isRunning.value && isPaused.value) {
      isRunning.value = true;
      isPaused.value = false;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (minutes.value == 0 && seconds.value == 0) {
          _timer?.cancel();
          isRunning.value = false;
        } else {
          if (seconds.value > 0) {
            seconds.value--;
          } else {
            if (minutes.value > 0) {
              minutes.value--;
              seconds.value = 59;
            }
          }
          var timerString = timerFormat(minutes.value, seconds.value);
          updateTodoStatus(id, todoStatusUpdate.value, timerString);
        }
      });
    }
  }

  // Stop the timer
  void stopTimer(int id) {
    _timer?.cancel();
    var timerString = timerFormat(minutes.value, seconds.value);
    todoStatusUpdate.value = 'Done';
    updateTodoStatus(id, todoStatusUpdate.value, timerString);
    isRunning.value = false;
    isPaused.value = false;
  }

  // Timer Format mm:ss
  String timerFormat(int minute, int second) {
    return '${minute.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')}';
  }

  // update todo item
  void updateTodoStatus(int id, String status, String timer) async {
    var todo = todoList.firstWhere((todo) => todo.id == id);
    todo.status = status;
    todo.timer = timer;
    updateTodo(todo);
  }
}
