import 'dart:html';

InputElement newTodo;
UListElement todoList;
UListElement doneList;

void main() {
  todoList = querySelector('#to-do-list');
  doneList = querySelector('#done-list');

  newTodo = querySelector('#new-to-do');
  newTodo.onChange.listen(addNewTodo); 
}

void addNewTodo(Event e) {
  var item = new LIElement();
  var checkbox = new CheckboxInputElement();
  checkbox.onClick.listen(handleClickedCheckbox);

  item.children.add(checkbox);
  item.appendText(newTodo.value);
  newTodo.value = '';
  todoList.children.add(item);
} 

void handleClickedCheckbox(Event e) {
  CheckboxInputElement checkbox = e.target;
  var listItem = checkbox.parent;
  if(checkbox.checked){
    todoList.children.remove(listItem);
    doneList.children.add(listItem);
  } else {
    doneList.children.remove(listItem);
    todoList.children.add(listItem);
  }
}
