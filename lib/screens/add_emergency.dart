import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:safe_home/constants.dart';
import 'package:safe_home/models/contactAdded_dialog.dart';
import '../models/DialogWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:contact_picker/contact_picker.dart';
import 'package:flutter/services.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class AddEmergency extends StatefulWidget {
  final String room_id;
  AddEmergency(this.room_id);

  @override
  _AddEmergencyState createState() => _AddEmergencyState();
}

class _AddEmergencyState extends State<AddEmergency> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String number, name;

  final ContactPicker contactPicker = new ContactPicker();
  String value1;

  String contact1;

  String contact2;
  String address;
  TextEditingController con1 = TextEditingController();
  TextEditingController con2 = TextEditingController();
  TextEditingController con3= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: kThemeColor,
        //automaticallyImplyLeading: false,
        backgroundColor: Colors.white38,
        elevation: 0,
        title: Text('Add Contacts',
        style: TextStyle(
          color: kThemeColor
        ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                //crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: con1,
                      validator: MultiValidator([
                        MinLengthValidator(13,
                            errorText:
                                'Contact must be in +92********** format '),
                        RequiredValidator(errorText: 'Field empty')
                      ]),
                      //controller: messageTextController,
                      onChanged: (value1) {
                        contact1 = value1;
                      },
                      //keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Enter Contact 1',
                        hintStyle: TextStyle(color: Colors.black26),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: kThemeColor, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: kThemeColor, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: TextButton(
                        onPressed: () async {
                          Contact contact = await contactPicker.selectContact();

                          if (contact != null) {
                            number = contact.phoneNumber.number;
                            name = contact.fullName;
                            setState(() {
                              con1.text = number;
                              print(number);
                              contact1= number;
                            });
                          }
                        },
                        child: Icon(Icons.contact_page_outlined,color: kThemeColor,)),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: con2,
                      validator: MultiValidator([
                        MinLengthValidator(13,
                            errorText:
                                'Contact must be in +92********** format '),
                        RequiredValidator(errorText: 'Field empty')
                      ]),
                      //controller: messageTextController,
                      onChanged: (value2) {
                        contact2 = value2;
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter Contact 2',
                        hintStyle: TextStyle(color: Colors.black26),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: kThemeColor, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: kThemeColor, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: TextButton(
                        onPressed: () async{
                          Contact contact = await contactPicker.selectContact();

                          if (contact != null) {
                            number = contact.phoneNumber.number;
                            name = contact.fullName;
                            setState(() {
                              con2.text = number;
                              print(number);
                              contact2=number;
                            });
                          }

                        },
                        child: Icon(Icons.contact_page_outlined,color: kThemeColor,)),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 350,
                child: TextFormField(
                  controller: con3,
                  validator: MultiValidator([

                    RequiredValidator(errorText: 'Field empty')
                  ]),
                  //controller: messageTextController,
                  onChanged: (value3) {
                    address = value3;
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter Address',
                    hintStyle: TextStyle(color: Colors.black26),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: kThemeColor, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: kThemeColor, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Material(
                    color: kThemeColor,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    elevation: 5.0,
                    child: MaterialButton(
                      onPressed: () {
                        //FocusScope.of(context).requestFocus(FocusNode());
                       //SystemChannels.textInput.invokeMethod('TextInput.hide');
                        FocusManager.instance.primaryFocus.unfocus();


                        if (formKey.currentState.validate()) {

                          print('satisfied');
                          print(widget.room_id);

                          FirebaseFirestore.instance
                              .collection("Emergency")
                              .doc(widget.room_id)
                              .set({
                            "device_id": widget.room_id,
                            "contact1": contact1,
                            "contact2": contact2,
                            "address": address
                          }).then((value) {
                            return "success updated";
                          }).catchError((onError) {

                            print('contact added');
                            return "error";
                          });
                          setState(() {
                            con1.text='';
                            con2.text='';
                            con3.text='';
                          });

                          showDialog(

                            context: context,
                            builder: (_) => DialogWidget('Contacts Added !'),



                          );


                        } else {
                          showDialog(
                            // Todo: Dialog box with button navigation
                            context: context,
                            builder: (_) => Flexible(child: DialogWidget('Wrong Entry')),
                          );
                        }
                      },
                      // onPressed: () async {
                      //   Contact contact = await contactPicker.selectContact();
                      //
                      //   if (contact != null) {
                      //     number = contact.phoneNumber.number;
                      //     name = contact.fullName;
                      //   }
                      // },
                      minWidth: 200.0,
                      height: 42.0,
                      child: Text(
                        'Add Contacts',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
