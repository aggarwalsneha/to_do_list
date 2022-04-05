import 'package:flutter/material.dart';
import 'package:to_do_list/todo.dart';

class TodoView extends StatefulWidget {
  Todo todo;
  TodoView({Key? key, required this.todo}) : super(key: key);

  @override
  _TodoViewState createState() => _TodoViewState(todo: this. todo);
}

class _TodoViewState extends State<TodoView> {
  Todo todo;
  _TodoViewState({required this.todo});
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = todo.title;
    descriptionController.text = todo.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        centerTitle: true,
        elevation: 10,
        backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
        title: const Text("Your Todo",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w700)),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              Container(
                  child: colorOverride(TextField(
                    onChanged: (data) {
                      todo.title = data;
                    },
                    style: const TextStyle(color: Colors.white,fontSize: 25.0),
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(color: Colors.white,fontSize: 22.0),
                      labelText: "Title",
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                    ),
                    controller: titleController,
                  ))),
              const SizedBox(
                height: 25,
              ),
              Container(
                  child: colorOverride(TextField(
                    maxLines: 3,
                    onChanged: (data) {
                      todo.description = data;
                    },
                    style: const TextStyle(color: Colors.white,fontSize: 25.0),
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(color: Colors.white,fontSize: 22.0),
                      labelText: "Description",
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                    ),
                    controller: descriptionController,
                  ))
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 55.0,
        child: BottomAppBar(
          color: const Color.fromRGBO(58, 66, 86, 1.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text("Alert!",style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.w700)),
                          content: Text(
                              "Mark this todo as ${todo.status ? 'not done' : 'done'}  ",
                              style: TextStyle(fontSize: 20.0)),

                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                              child: const Text("No",style: TextStyle(fontSize: 20.0)),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  todo.status = !todo.status;
                                });
                                Navigator.of(ctx).pop();
                              },
                              child: const Text("Yes",style: TextStyle(fontSize: 20.0)),
                            )
                          ],
                        ));
                  },
                  child: Text(
                    "${todo.status ? 'Mark as Not Done' : 'Mark as Done'} ",
                    style: const TextStyle(color: Colors.white,fontSize: 20.0),
                  )),
              const VerticalDivider(
                color: Colors.white,
              ),
              IconButton(
                icon: const Icon(Icons.save, color: Colors.white,size:30.0),
                onPressed: () {
                  Navigator.pop(context, todo);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget colorOverride(Widget child) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.white,
        hintColor: Colors.white,
      ),
      child: child,
    );
  }
}