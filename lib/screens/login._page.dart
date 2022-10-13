
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  String path="";
  String url="";
  String imgname="";
  TextEditingController name=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController rollno=TextEditingController();
  GlobalKey<FormState> formKey= GlobalKey<FormState>();
  final img='assets/prof.jpg';
  final log1='assets/log1.jpg';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: Colors.white,

          appBar: AppBar(
            backgroundColor: Colors.black87,
            titleSpacing: 25.0,
          title:Container(

            child: Row(

              children: const [

                Icon(Icons.person_add),
                SizedBox(width: 10,),
                Text("Student Login Details")
              ],
            ),
          ),
            titleTextStyle: const TextStyle(fontWeight: FontWeight.w900,fontSize: 20.0),


      ),
          body:Container(
            decoration: BoxDecoration(image: DecorationImage( alignment: Alignment.center,fit: BoxFit.cover,image: AssetImage(log1))),
          child:SingleChildScrollView(

          child:Padding(

          padding: const EdgeInsets.all(10.0),
          child:Form(
            key: formKey,
            child:Column(
            crossAxisAlignment:CrossAxisAlignment.start ,
            children: [
              const SizedBox(height: 30,),
            Center(
              child : Stack(

                  children:[
                    if(path=="")CircleAvatar(
                      radius: 120,
                      backgroundImage: AssetImage(img) ,),
                    if(path!="")CircleAvatar(
                      radius: 120,
                      backgroundImage: FileImage(File(path)),
                    ),




                    Positioned(
                      bottom: 22,
                      right: 20,

                      child:CircleAvatar(
                        backgroundColor: Colors.blue,
                          radius: 20,
                          child:IconButton(
                            icon: Icon(Icons.camera_enhance,color: Colors.tealAccent),
                            color: Colors.white,

                            visualDensity: VisualDensity.adaptivePlatformDensity,
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: ((builder)=>bottomsheet()) ,
                              );
                            },

                          )

                      ),
                    ),
                  ]
              ),

            ),
            const SizedBox(height: 40,),
            Center(
              child:Container(
                width: 308,
                decoration: UnderlineTabIndicator(borderSide: BorderSide(width: 2.0) ),
              child:Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child:SizedBox(
                    width:260,
                    child:TextFormField(
                      textAlign: TextAlign.start,
                      controller: name,
                      decoration: const InputDecoration(
                          hintText: 'Name',
                          prefixIcon: Icon(Icons.perm_identity),
                          border: InputBorder.none
                          // border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)))

                      ),
                      validator: (value) {
                        if(value!.isEmpty||!RegExp(r'^[a-z A-z]+$').hasMatch(value!)){
                          return "Enter a valid Name";
                        }
                        else{
                          return null;
                        }
                      },
                    ),
                  ),
                ),
                IconButton(onPressed: (){
                  setState(() {
                    name=TextEditingController(text: "");
                  });
                },
                    icon: Icon(Icons.clear_sharp))
              ],
            ),
            ),
            ),
            const SizedBox(height: 20,),
            Center(
              child:Container(
              width: 308,
              decoration: UnderlineTabIndicator(borderSide: BorderSide(width: 2.0) ),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child:SizedBox(
                      width:260,
                      child:TextFormField(
                        textAlign: TextAlign.start,
                        controller: email,
                        decoration: const InputDecoration(
                            hintText: 'Email',
                            prefixIcon: Icon(Icons.alternate_email_outlined),
                            border: InputBorder.none
                            // border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)))

                        ),
                        validator: (value) {
                          if(value!.isEmpty||!RegExp(r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$').hasMatch(value!)){
                            return "Enter a valid Email";
                          }
                          else{
                            return null;
                          }
                        },
                      ),
                    ),
                  ),
                  IconButton(onPressed: (){
                    setState(() {
                      email=TextEditingController(text: "");
                    });
                  },
                      icon: Icon(Icons.clear_sharp))
                ],
              ),
            ),
            ),
            SizedBox(height: 20,),
            Center(
              child:Container(
                width: 308,
                decoration: UnderlineTabIndicator(borderSide: BorderSide(width: 2.0) ),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child:Container(
                      width:260 ,

                      child:TextFormField(
                        textAlign: TextAlign.start,
                        controller: rollno,
                        decoration: const InputDecoration(
                            hintText: 'Roll Number',
                            prefixIcon: Icon(Icons.numbers_outlined),
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if(value!.isEmpty||!RegExp(r'^[a-z 0-9 A-z]{10}$').hasMatch(value!)){
                            return "Enter a valid Roll Number";
                          }
                          else{
                            return null;
                          }
                        },
                      ),
                    ),
                  ),
                  IconButton(onPressed: (){
                    setState(() {
                      rollno=TextEditingController(text: "");
                    });
                  },
                      icon: Icon(Icons.clear_sharp))
                ],
              ),
              ),
            ),
            SizedBox(height: 20,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
            children:[

              FloatingActionButton.extended(
                  label: const Text("clear"),
                  backgroundColor: Colors.black,
                  elevation: 10.0,
                  extendedPadding: EdgeInsets.all(40.0),
                  onPressed: (){
                    setState(() {
                      name=TextEditingController(text: "");
                      email=TextEditingController(text: "");
                      rollno=TextEditingController(text: "");
                    });
                  },
              ),

              const SizedBox(width: 73,),
              FloatingActionButton.extended(
                  label: Text("Submit"),
                    backgroundColor: Colors.black,
                    elevation: 10.0,
                    extendedPadding: EdgeInsets.all(40.0),
                    onPressed: ()async {
                      if(formKey.currentState!.validate()){
                        if(path!=""){
                          final iname=imgname;
                          try{
                            await FirebaseStorage.instance.ref('profile_pic/$iname').putFile(File(path));
                          }on FirebaseException catch (e){print(e);}
                          String dt=await FirebaseStorage.instance.ref('profile_pic/$iname').getDownloadURL();
                          setState(() {
                            url=dt;
                          });
                        }
                        FirebaseFirestore.instance.collection("Login").add({
                          "name":name.text,
                          "email":email.text,
                          "roll_no":rollno.text,
                          "ipath":url,
                          "docid":"",
                        }).then((value){
                          FirebaseFirestore.instance.collection("Login").doc(value.id).update(
                              {"docid":value.id});

                        }).catchError((error) => print("Failed to add new profile due to $error"));

                        Navigator.pop(context);
                      }

                    } ,


               ),


           ]
            ),
              SizedBox(height: 400,)
          ],
        ),
      ),
          ),
          ),
          ),
    );
  }
  Widget bottomsheet() {
    return Container(
      height: 125.0,
      width: MediaQuery.of(context).size.width,
      color: Colors.white70,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          if(path=="")FloatingActionButton.extended(
              label: Text("Camera"),
              onPressed:()async{
                final pick= await ImagePicker().pickImage(source:ImageSource.camera);
                if(pick==null){
                  Navigator.pop(context);
                  return;
                }
                else{

                  setState((){
                    imgname=pick.name;
                    path=pick.path;
                  });
                }
                Navigator.pop(context);
              },
              icon: Icon(Icons.camera),
              backgroundColor: Colors.black87
          ),
          if(path=="")SizedBox(width: 69.0,),
          if(path=="")FloatingActionButton.extended(
              label: Text("Gallery"),
              onPressed: ()async{
                final pick= await ImagePicker().pickImage(source:ImageSource.gallery);
                if(pick==null){
                  Navigator.pop(context);
                  return;
                }
                else{
                  setState((){
                    imgname=pick.name;
                    path=pick.path;
                  });
                }
                Navigator.pop(context);
              },
              icon: Icon(Icons.image),
              backgroundColor: Colors.black87
          ),
          if(path!="")FloatingActionButton.extended(
              label: Text("delete"),
              onPressed:(){
                setState((){
                  path="";
                });
                Navigator.pop(context);
              },
              icon: Icon(Icons.delete),
              backgroundColor: Colors.black87
          ),
          if(path!="")SizedBox(width: 69.0,),
          if(path!="")FloatingActionButton.extended(
              label: Text("Replace"),
              onPressed: ()async{
                final pick= await ImagePicker().pickImage(source:ImageSource.gallery);
                if(pick==null){
                  Navigator.pop(context);
                  return;
                }
                else{
                  setState((){
                    imgname=pick.name;
                    path=pick.path;
                  });
                }
                Navigator.pop(context);
              },
              icon: Icon(Icons.image_outlined),
              backgroundColor: Colors.black87
          ),



        ],
      ),
    );
  }
}
