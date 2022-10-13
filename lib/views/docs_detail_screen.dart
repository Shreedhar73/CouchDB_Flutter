// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:couchdb_test/utils/styles.dart';
import 'package:couchdb_test/widgets/custom_button.dart';
import 'package:couchdb_test/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/home_bloc.dart';

class DocsDetailPage extends StatefulWidget {
  const DocsDetailPage({ Key? key,this.data }) : super(key: key);
  final data;
  // final bloc;

  @override
  State<DocsDetailPage> createState() => _DocsDetailPageState();
}

class _DocsDetailPageState extends State<DocsDetailPage> {
  final nameCon = TextEditingController();
  final emailCon = TextEditingController();
  final countryCon = TextEditingController();

  @override
  void initState() {
    nameCon.text = widget.data['doc']['name'];
    emailCon.text = widget.data['doc']['email'];
    countryCon.text = widget.data['doc']['country'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var data = widget.data['doc'];
    final HomeBloc _homeBloc = BlocProvider.of<HomeBloc>(context);
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.black,
        title: Text(widget.data['doc']['name'] ?? ''),
      ),

      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customTextFormField( nameCon, 'Name'),
              customTextFormField(emailCon, 'Email'),
              customTextFormField(countryCon, 'Country'),
              const SizedBox(height: 20,),
              SubmitButton(text: 'Update', onPressed: (){
                _homeBloc.add(UpdateDocumentEvent(docID: data['_id'],rev: data['_rev'],name: nameCon.text,email: emailCon.text,country: countryCon.text,city: data['address']['city']??''));

              }, bgColor: black, fontColor: white)

            ],
          ),
        ),
      ),
    );
  }
}