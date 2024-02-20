package com.restapi.todo.Interface;

import com.restapi.todo.Model.TaskItem;

import java.time.LocalDate;
import java.util.List;

public interface TaskInterface {
    TaskItem addTask(TaskItem currentTask);
    List<TaskItem> getTasks();
    List<TaskItem> getTasksByDate(LocalDate localDate);
    List<TaskItem> getTasksByStatus(int status);
    String updateTaskStatus(long taskId);
    String updateTaskName(TaskItem currentTask);
    String deleteTask(long taskId);
}
