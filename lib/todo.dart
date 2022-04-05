

class Todo{
  int id;
  String title;
  String description;
  bool status;

  Todo({required this.id,required this.title,required this.description,required this.status})
  {
  id=id;
  title=title;
  description=description;
  status=status;
}
toJson(){
    return{
      "id":id,
      "title":title,
      "description":description,
      "status":status
    };
}
fromJson(jsonData){
    return Todo(
      id:jsonData['id'],
      title: jsonData['title'],
      description: jsonData['description'],
      status: jsonData['status']
  );
}


}