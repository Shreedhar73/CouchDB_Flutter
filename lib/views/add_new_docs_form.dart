import 'package:couchdb_test/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../blocs/home_bloc.dart';
import '../utils/styles.dart';
import '../widgets/custom_textformfield.dart';

class AddnewDocsForm extends StatefulWidget {
  const AddnewDocsForm({ Key? key ,this.bloc}) : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  final bloc;
  @override
  State<AddnewDocsForm> createState() => _AddnewDocsFormState();
}

class _AddnewDocsFormState extends State<AddnewDocsForm> {
  final _formKey = GlobalKey<FormState>();
  var name = TextEditingController();
  var email = TextEditingController();
  var country = TextEditingController();
  var zone = TextEditingController();
  var city = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey.withOpacity(0.3),
      body:  SingleChildScrollView(
        child: Container(
          color: lightgrey,
          padding: const EdgeInsets.all(20),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  customTextFormField(name,'Name',true),
                  customTextFormField(email, 'Email',true),
                  customTextFormField(country, 'Country'),
                  customTextFormField(zone, 'Zone'),
                  customTextFormField(city, 'City'),
                  SubmitButton(text: "Add", 
                  onPressed: (){ 
                    if(_formKey.currentState!.validate()){
                        widget.bloc.add(AddDataEvent(name: name.text,email: email.text,country: country.text,city: city.text));
                        Navigator.pop(context);
                        name.clear();
                        email.clear();
                        country.clear();
                        city.clear();
                        zone.clear();
                      }
                    }, 
                    bgColor: black, 
                    fontColor: white
                  )
                ],
              ),
          ),
        ),
      )
      
    );
  }
}