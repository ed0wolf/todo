import 'dart:html';
import 'dart:indexed_db';

InputElement newTodo;
UListElement todoList;
UListElement doneList;

void main() {
  if(!isCompatible()) return; 

  todoList = querySelector('#to-do-list');
  doneList = querySelector('#done-list');

  newTodo = querySelector('#new-to-do');
  newTodo.onChange.listen(addNewTodo); 
}

bool isCompatible(){
  if(IdbFactory.supported) return true;
  
  var body=querySelector('body');
  body.children.clear();
  var error = new SpanElement();
  error.text = "Looks like your browser doesn't support IndexedDB";
  body.children.add(error);
  return false;
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
