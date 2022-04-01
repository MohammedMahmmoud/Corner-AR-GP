import 'package:corner_ar_gp/components/buttons_components.dart';
import 'package:corner_ar_gp/components/edit_info/edit_info_card.dart';
import 'package:corner_ar_gp/components/edit_info/edit_password_form.dart';
import 'package:corner_ar_gp/components/edit_info/edit_userName_form.dart';
import 'package:corner_ar_gp/components/textField_components.dart';
import 'package:corner_ar_gp/person/Person.dart';
import 'package:corner_ar_gp/provider_manager/AppProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditPersonInformation extends StatefulWidget {
  static const String routeName = 'editUsersInfo';
  Person loggedUser;
  EditPersonInformation(this.loggedUser);
  @override
  State<EditPersonInformation> createState() => _EditPersonInformationState(loggedUser);
}

class _EditPersonInformationState extends State<EditPersonInformation> {
  late bool _editingUserName, _editingPassword, _editingEmail;
  final PrimitiveWrapper _name = PrimitiveWrapper(''),
      _password = PrimitiveWrapper(''),
      _newPassword = PrimitiveWrapper(''),
      _email = PrimitiveWrapper('');
  bool hidePassword = true, hideNewPassword = true;
  Person loggedUser;
  final _formKey = GlobalKey<FormState>();
  _EditPersonInformationState(this.loggedUser);

  void initState(){
    _editingUserName = false;
    _editingEmail = false;
    _editingPassword = false;
  }

  @override
  Widget build(BuildContext context) {
    print('========================='+loggedUser.id+'============================');


    return Container(
      child: Column(
        children :[
          Expanded(
            child: ListView(
            children: <Widget>[
             const SizedBox(height: 25,),
             TileEditCard(cardTitle: 'Edit Name', onTapFunction: _toggleEditNameOntTap),
             _editingUserName?
                EditUserNameForm(person: loggedUser, formKey: _formKey)
                : const SizedBox(height: 10,),
             TileEditCard(cardTitle: 'Edit Password', onTapFunction: _toggleEditPasswordOntTap),
             _editingPassword?
                  EditPasswordForm(
                      person: loggedUser,
                      password: _password,
                      newPassword: _newPassword,
                      currentPasswordValidator: loggedUser.passwordValidator,
                      hideCurrentPassword: hidePassword,
                      hideNewPassword: hideNewPassword,
                      formCurrentKey: _formKey,
                      toggleCurrentPasswordVisibility: _toggleCurrentPasswordVisibility,
                      toggleNewPasswordVisibility: _toggleNewEnteredPasswordVisibility
                  )
                  : const SizedBox(height: 10,),
             TileEditCard(cardTitle: 'Edit Email Address', onTapFunction: _toggleEditEmailOntTap),
             _editingEmail?
                 textFormFieldComponent(
                     hintText: 'New Email Address',
                     onChangedText: loggedUser.setEmail,
                     validator: loggedUser.mailValidator,
                     isPasswordTextForm: false
                 ):
                 const SizedBox(height: 0,),
            ],
        ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                Row(
                  children: [
                    const SizedBox(width: 10,),
                    Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            print(_password.value );
                            loggedUser.updateName(_formKey);
                            loggedUser.updatePassword(_formKey, _password.value, _newPassword.value);
                          },
                          child: const Text(
                            'Save Changes',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: const Color(0xFF71A2B5),
                            fixedSize: const Size(200, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                        )
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                        child: ElevatedButton(
                          onPressed: (){},
                          child: const Text(
                            'Delete Account',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.redAccent,
                            onPrimary: const Color(0xFFFCFCFC),
                            fixedSize: const Size(200, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                        )
                    ),
                    const SizedBox(width: 10,),

                  ],
                ),
                const SizedBox(height: 30,),
              ],
            ),
          ),

        ],
      )
    );
  }

  _toggleEditNameOntTap(){
    setState(() {
      _editingUserName = !_editingUserName;
      _editingEmail = false;
      _editingPassword = false;
    });
  }
  _toggleEditPasswordOntTap(){
    setState(() {
      _editingUserName = false;
      _editingEmail = false;
      _editingPassword = !_editingPassword;
    });
  }
  _toggleEditEmailOntTap(){
    setState(() {
      _editingUserName = false;
      _editingEmail = !_editingEmail;
      _editingPassword = false;
    });
  }

  _toggleCurrentPasswordVisibility()
  {
    setState(() {
      hidePassword = !hidePassword;
    });
  }
  _toggleNewEnteredPasswordVisibility()
  {
    setState(() {
      hideNewPassword = !hideNewPassword;
    });
  }

}

class PrimitiveWrapper {
  var value;
  PrimitiveWrapper(this.value);
}
