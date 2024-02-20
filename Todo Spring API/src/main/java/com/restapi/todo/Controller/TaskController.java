package com.restapi.todo.Controller;

import com.restapi.todo.Model.TaskItem;
import com.restapi.todo.Service.TaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@RestController
@CrossOrigin("*")
@RequestMapping("/api/todo")
public class TaskController {

    @Autowired TaskService taskService;
    @PostMapping("/addTask")
    public ResponseEntity<TaskItem> addTaskItem(@RequestBody TaskItem taskItem){
        return new ResponseEntity<>(taskService.addTask(taskItem), HttpStatus.CREATED);
    }

    @GetMapping("/getTasks")
    public ResponseEntity<List<TaskItem>> getTasks(){
        return new ResponseEntity<>(taskService.getTasks(), HttpStatus.OK);
    }

    @GetMapping("/getTasks/localDate/{date}")
    public ResponseEntity<List<TaskItem>> getTasksByDate(@PathVariable("date") String dateString){
        return new ResponseEntity<>(taskService.getTasksByDate(LocalDate.parse(dateString)), HttpStatus.OK);
    }

    @GetMapping("/getTasks/status/{status}")
    public ResponseEntity<List<TaskItem>> getTasksByStatus(@PathVariable("status") int status){
        return new ResponseEntity<>(taskService.getTasksByStatus(status), HttpStatus.OK);
    }

    @PutMapping("/updateTaskStatus/taskId/{id}")
    public ResponseEntity<String> updateTaskStatus(@PathVariable("id") long taskId){
        String response = taskService.updateTaskStatus(taskId);
        return new ResponseEntity<>(response, (response.equals("Task Status Updated"))?(HttpStatus.ACCEPTED):(HttpStatus.BAD_REQUEST));
    }

    @PutMapping("/updateTaskName")
    public ResponseEntity<String> updateTaskName(@RequestBody TaskItem taskItem){
        String response = taskService.updateTaskName(taskItem);
        return new ResponseEntity<>(response, (response.equals("Task Name Updated"))?(HttpStatus.ACCEPTED):(HttpStatus.BAD_REQUEST));
    }

    @DeleteMapping("/deleteTask/taskId/{id}")
    public ResponseEntity<String> deleteTask(@PathVariable("id") long taskId){
        String response = taskService.deleteTask(taskId);
        return new ResponseEntity<>(response, (response.equals("Task Removed"))?(HttpStatus.ACCEPTED):(HttpStatus.BAD_REQUEST));
    }
}
