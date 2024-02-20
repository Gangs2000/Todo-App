package com.restapi.todo.Repository;

import com.restapi.todo.Model.TaskItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;

@Repository
@Transactional
public interface TaskRepository extends JpaRepository<TaskItem, Long> {
    List<TaskItem> findByCreatedDate(LocalDate localDate);
    List<TaskItem> findByTaskStatus(int status);
}
