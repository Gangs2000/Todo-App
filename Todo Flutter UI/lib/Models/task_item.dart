class TaskItem{
  final int taskId;
  String taskName;
  int taskStatus;
  DateTime createdDateTime;

  TaskItem({
    required this.taskId,
    required this.taskName,
    this.taskStatus=0,
    required this.createdDateTime,
  });

  factory TaskItem.fromMap(Map taskMap){
    return TaskItem(
      taskId: taskMap['id'],
      taskName: taskMap['taskName'],
      taskStatus: taskMap['taskStatus'],
        createdDateTime: DateTime(
        // Parsing date and time from string
        int.parse(taskMap['createdDate'].split('-')[0]), // Year
        int.parse(taskMap['createdDate'].split('-')[1]), // Month
        int.parse(taskMap['createdDate'].split('-')[2]), // Day
        int.parse(taskMap['createdTime'].split(':')[0]), // Hour
        int.parse(taskMap['createdTime'].split(':')[1]), // Minute
        int.parse(taskMap['createdTime'].split(':')[2]), // Second
      )
    );
  }

  void toggleTask() {
    switch (taskStatus) {
      case 0 || 1 :
        taskStatus=taskStatus + 1;
        break;
      case 2 :
        taskStatus=taskStatus - 1;
        break;
    }
  }
}