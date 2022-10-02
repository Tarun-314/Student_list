import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:studentform/screens/login._page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studentform/screens/view_page.dart';
import 'package:studentform/screens/edit.dart';
import 'dart:io';
class home extends StatefulWidget {
  home({Key? key}) : super(key: key);
  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  String srch="";
  final img='assets/prof.jpg';
  final bak='assets/load1.png';
  TextEditingController search=TextEditingController();
  ScrollController bar=ScrollController();
  List<String> list=["Edit","Delete"];
  @override
  Widget build(BuildContext context) {

    return  Scaffold(

      appBar: AppBar(
        centerTitle: true,
        shadowColor: Colors.black,
        backgroundColor: Colors.black87,
        leading: const Padding(
          padding: EdgeInsets.fromLTRB(80, 0, 0, 0),
         child:Icon(Icons.person),
        ),
        title: const Text("Student Profile List"),
        titleTextStyle: const TextStyle(fontWeight: FontWeight.w900,fontSize: 20.0),
      ),
      body:Container(
        decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.cover,image: AssetImage(bak))),
      child:RawScrollbar(

         thickness: 40,
        thumbVisibility: true,
        timeToFade: Duration(seconds: 6),
        interactive: true,
        fadeDuration: Duration(seconds: 6),
        radius: Radius.circular(30),


        child:SingleChildScrollView(
          child:Padding(
           padding: const EdgeInsets.only(right: 20,left: 10),
           child: Column(
            children: [
              SizedBox(height: 20,),
              Container(
                height: 50,
              decoration: BoxDecoration(color: Colors.white,borderRadius:BorderRadius.circular(20.0) ),
              child:TextField(
                controller: search,
                onChanged: (val) => {
                      setState((){
                        srch=val;
                      })
                },
                cursorColor: Colors.black87,
                decoration:InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical:10.0 ,horizontal:10.0 ),
                  hintText: "Search",


                  suffixIcon: Icon(Icons.search_sharp),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
              ),
              SizedBox(height: 35,),

              StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection("Login").snapshots(),
                  builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const Center(child: CircularProgressIndicator(),
                      );
                    }
                    if(snapshot.hasData){
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var data=snapshot.data!.docs[index].data() as Map<String,dynamic>;
                          if(srch.isEmpty){
                            return studentCard(data,(){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> viewpage(data)));});
                          }
                          if(data['name'].toString().toLowerCase().contains(srch.toLowerCase())||
                              data['roll_no'].toString().toLowerCase().contains(srch.toLowerCase())){
                            return studentCard(data,(){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> viewpage(data)));});
                          }
                          return ColoredBox(color: Colors.white);

                        },
                        // shrinkWrap: true,
                        // children: snapshot.data!.docs.map((stid) => studentCard(stid,(){
                        //   Navigator.push(context, MaterialPageRoute(builder: (context)=> viewpage(stid)));
                        //   })).toList(),

                      );
                    }
                    return Text("No Details to View", style: GoogleFonts.nunito(fontSize: 17,color:Colors.black ),);
                  },
                ),

                SizedBox(height: 1000,)
            ],
          ),

      ),
      ),
      ),
      ),

     //backgroundColor: Colors.black,

      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Add Profile"),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder:(context) => login(),));
        },
        icon: Icon(Icons.person_add),
        backgroundColor: Colors.black,

      ),
    );
  }

 Widget studentCard(Map<String,dynamic> doct,Function()? onDoubleTap) {

        return GestureDetector(
          onLongPress: (){},
          onDoubleTap: onDoubleTap,
          child:Column(
          children:[
            Container(

            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10.0)),
            child:
             ListTile(

                 // decoration: BoxDecoration(
             //   color: Colors.black87,
             //
             //   borderRadius: BorderRadius.circular(8.0),
             // ) ,
              tileColor: Colors.teal,
              onTap: (){},
              selected: true,

              title: Text(
                doct['roll_no'],
                style:GoogleFonts.notoSansHanunoo(color: Colors.black,fontWeight:FontWeight.bold),
                overflow: TextOverflow.fade,
              ),
              subtitle: Text(
                doct['name'],
                style:GoogleFonts.notoSansHanunoo(color: Colors.black),
                overflow: TextOverflow.fade,
              ),
          // decoration: UnderlineTabIndicator( insets: EdgeInsets.all(2.0)),
             leading:Container(
               width: 90,
               height: 90,
               child:Row(
                children: [
                  if(doct['ipath']=="")CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(img),
                  ),
                  if(doct['ipath']!="")CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(doct['ipath']),

                  ),
              ],
             ),
             ),

                trailing:PopupMenuButton(itemBuilder: (context) {
                    return list.map((e) => PopupMenuItem(
                      value: e,
                      child: Row(
                        children: [
                          if(e=="Edit")Icon(Icons.edit,size: 30,color: Colors.black,),

                       if(e=="Delete")Icon(Icons.delete,size: 30,color: Colors.black,),
                          SizedBox(width: 20,),
                          Text(e,style: GoogleFonts.archivoBlack(fontWeight: FontWeight.w400,color: Colors.black),)
                        ],
                      ),
                    )).toList();

                  },
                    onSelected: (value){
                      if(value=="Edit"){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>editer(doct)));
                      }
                      else{
                        if(doct['ipath']!=""){

                            FirebaseStorage.instance.refFromURL(doct['ipath']).delete();

                        }
                        FirebaseFirestore.instance.collection("Login").doc(doct['docid']).delete();

                      }
                    },
                    icon: Icon(Icons.more_vert_sharp),
                    color: Colors.white,
                  ),
                )
               ),

             SizedBox(height: 13,)
            ],
          ),
        );

  }

}

