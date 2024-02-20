package com.restapi.todo.Service;

import com.restapi.todo.Interface.TaskInterface;
import com.restapi.todo.Model.TaskItem;
import com.restapi.todo.Repository.TaskRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Service
public class TaskService implements TaskInterface {

    @Autowired TaskItem taskItem;
    @Autowired TaskRepository taskRepository;

    @Override
    public TaskItem addTask(TaskItem currentTask) {
        currentTask.setTaskName(currentTask.getTaskName());
        //Initially task will be 0 - Created
        currentTask.setTaskStatus(0);
        //Setting local date and local time while creating record in database
        currentTask.setCreatedDate(LocalDate.parse(LocalDate.now().format(DateTimeFormatter.ISO_LOCAL_DATE)));
        currentTask.setCreatedTime(LocalTime.parse(LocalTime.now().format(DateTimeFormatter.ofPattern("HH:mm"))));
        return taskRepository.saveAndFlush(currentTask);
    }

    @Override
    public List<TaskItem> getTasks() {
        return taskRepository.findAll();
    }

    @Override
    public List<TaskItem> getTasksByDate(LocalDate localDate) {
        return taskRepository.findByCreatedDate(localDate);
    }

    @Override
    public List<TaskItem> getTasksByStatus(int status) {
        return taskRepository.findByTaskStatus(status);
    }

    @Override
    public String updateTaskStatus(long taskId) {
        if(taskRepository.existsById(taskId)){
            taskItem=taskRepository.findById(taskId).get();
            //Updating the task, Toggling
            int currentTaskStatus= taskItem.getTaskStatus();
            switch (currentTaskStatus){
                case 0,1 : taskItem.setTaskStatus(currentTaskStatus+1); break;
                case 2 : taskItem.setTaskStatus(currentTaskStatus-1); break;
            }
            taskRepository.saveAndFlush(taskItem);
            return "Task Status Updated";
        }
        return "Task ID is not found";
    }

    @Override
    public String updateTaskName(TaskItem currentTask) {
        if(taskRepository.existsById(currentTask.getId())){
            taskItem=taskRepository.findById(currentTask.getId()).get();
            taskItem.setTaskName(currentTask.getTaskName());
            taskRepository.saveAndFlush(taskItem);
            return "Task Name Updated";
        }
        return "Task ID is not found";
    }

    @Override
    public String deleteTask(long taskId) {
        if(taskRepository.existsById(taskId)){
            taskRepository.deleteById(taskId);
            return "Task Removed";
        }
        return "Task ID is not found";
    }
}
