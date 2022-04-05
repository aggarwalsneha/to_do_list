import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:to_do_list/todo.dart';
import 'package:to_do_list/todoView.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:get_storage/get_storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //final box = GetStorage();
  List todos=[];

  setUpTodo()async
  {
   final prefs=await SharedPreferences.getInstance();
   String? stringTodo=prefs.getString('todo');
   List todoList=jsonDecode(stringTodo!);
   for(var todo in todoList)
     {
       setState(() {
         todos.add(Todo(id: Random().nextInt(30), title: '', status:false, description: '').fromJson(todo));
       });
     }
  }

  void saveTodo() async {
    final prefs=await SharedPreferences.getInstance();
    List items = todos.map((e) => e.toJson()).toList();
    prefs.setString('todo', jsonEncode(items));
  }
@override
  void initState()
{
super.initState();
setUpTodo();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('ToDoS',style:TextStyle(fontSize: 25)),
        backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
      ),
      body:ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: todos.length,
        itemBuilder: (BuildContext context,int index){
          return Card(
            elevation: 8.0,
            margin: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8.0),
           child: Container(
            decoration: const BoxDecoration(
           color: Color.fromRGBO(64, 75, 96, .9),
             ),
            child: InkWell(
              onTap: ()async {
                Todo t=await Navigator.push(context, MaterialPageRoute(
                    builder: (context) => TodoView(todo: todos[index])
                )
                );
                setState(() {
                  todos[index] = t;
                });
                saveTodo();
              },
              child:makeListTile(todos[index],index) ,
            ),
          )
          );

        }),
        floatingActionButton:FloatingActionButton(
          child: const Icon(Icons.add,size: 30,),
          onPressed: () {
            addTodo();
            },
          backgroundColor: Colors.black,
        )
    );

  }

  addTodo() async {
    int id = Random().nextInt(30);
    Todo t = Todo(id: id, title: '', description: '', status: false);
    Todo returnTodo = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => TodoView(todo: t)));
    setState(() {
      todos.add(returnTodo);
    });
    saveTodo();
  }
  makeListTile(Todo todo, index) {
    return ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: const EdgeInsets.only(right: 12.0),
          decoration: const BoxDecoration(
              border: Border(
                  right: BorderSide(width: 1.0, color: Colors.white10))),
          child: CircleAvatar(
            backgroundColor: Colors.black26,
            child: Text("${index + 1}",style: TextStyle(fontSize: 20.0),),
          ),
        ),
        title: Row(
          children: [
            Text(
              todo.title,
              style:
              const TextStyle(color: Colors.white, fontSize: 22.0),
            ),
            const SizedBox(
              width: 10,
            ),
            todo.status
                ? const Icon(
              Icons.verified,
              color: Colors.greenAccent,
            )
                : Container()
          ],
        ),

        subtitle: Wrap(
          children: <Widget>[
            Text(todo.description,
                overflow: TextOverflow.clip,
                maxLines: 1,
                style: const TextStyle(color: Colors.white,fontSize: 18.0))
          ],
        ),
        trailing: InkWell(
            onTap: () {
              delete(todo);
            },
            child: const Icon(Icons.delete, color: Colors.red, size: 32.0)
        )
    );
  }

delete(Todo todo){
return showDialog(context: context, builder: (ctx)=>AlertDialog(

  title: const Text('Alert!',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w700),),
  content: const Text('Are you sure to delete?',style:TextStyle(fontSize: 20.0,fontWeight: FontWeight.w700)),
  actions: [
    TextButton(onPressed: (){
      Navigator.pop(ctx);
    },
        child:const Text('No',style:TextStyle(fontSize: 20.0))
    ),
    TextButton(onPressed: (){
      setState(() {
        todos.remove(todo);
      });
      Navigator.pop(ctx);
      saveTodo();
    }, child: const Text('Yes',style:TextStyle(fontSize: 20.0)))
  ],
));
}

}
