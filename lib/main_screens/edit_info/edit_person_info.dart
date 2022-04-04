import 'package:corner_ar_gp/components/edit_info/edit_email_form.dart';
import 'package:corner_ar_gp/components/edit_info/edit_info_card.dart';
import 'package:corner_ar_gp/components/edit_info/edit_password_form.dart';
import 'package:corner_ar_gp/components/edit_info/edit_userName_form.dart';
import 'package:corner_ar_gp/person/Person.dart';
import 'package:flutter/material.dart';

class EditPersonInformation extends StatefulWidget {
  static const String routeName = 'editUsersInfo';
  Person loggedUser;
  EditPersonInformation(this.loggedUser, {Key? key}) : super(key: key);
  @override
  State<EditPersonInformation> createState() => _EditPersonInformationState();
}

class _EditPersonInformationState extends State<EditPersonInformation> {
  List<int> formsIconsStats = [0,0,0];
  late bool _editingUserName, _editingPassword, _editingEmail;
  String? _newName, _currPass, _newPass, _newMail, _tempLastName;
  bool hidePassword = true, hideNewPassword = true;
  final _nameFormKey = GlobalKey<FormState>(), _passwordFormKey = GlobalKey<FormState>(),
  _currPassFormKey = GlobalKey<FormState>(), _emailFormKey = GlobalKey<FormState>();

  void initState(){
    _editingUserName = false;
    _editingEmail = false;
    _editingPassword = false;
  }

  @override
  Widget build(BuildContext context) {
    print('========================='+widget.loggedUser.id+'============================');


    return Container(
      child: Column(
        children :[
          Expanded(
            child: ListView(
            children: <Widget>[
             const SizedBox(height: 25,),
             TileEditCard(cardTitle: 'Edit Name', onTapFunction: _toggleEditNameOntTap, iconState: formsIconsStats[0]),
             _editingUserName?
                EditUserNameForm(
                    formKey: _nameFormKey,
                    nameReturner: _getNewNameFromTextField,
                    lastNameReturner: _setNameToFullName,
                    firstNameSavedValue: _newName,
                    lastNameSavedValue: _tempLastName
                )
                : const SizedBox(height: 10,),
             TileEditCard(cardTitle: 'Edit Password', onTapFunction: _toggleEditPasswordOntTap, iconState: formsIconsStats[1]),
             _editingPassword?
                  EditPasswordForm(
                      person: widget.loggedUser,
                      passwordGetter: _getCurrPassFromTextField,
                      newPasswordGetter: _getNewPassFromTextField,
                      currentPasswordValidator: widget.loggedUser.passwordValidator,
                      hideCurrentPassword: hidePassword,
                      hideNewPassword: hideNewPassword,
                      formCurrentKey: _currPassFormKey,
                      passwordFormKey: _passwordFormKey,
                      toggleCurrentPasswordVisibility: _toggleCurrentPasswordVisibility,
                      toggleNewPasswordVisibility: _toggleNewEnteredPasswordVisibility,
                  )
                  : const SizedBox(height: 10,),
             TileEditCard(cardTitle: 'Edit Email Address', onTapFunction: _toggleEditEmailOntTap, iconState: formsIconsStats[2]),
             _editingEmail?
                 EditEmailForm(
                     formKey: _emailFormKey,
                     emailReturner: _getNewEmailFromTextField,
                     passReturner: _getCurrPassFromTextField,
                     emailValidator: widget.loggedUser.mailValidator,
                     passwordValidator: widget.loggedUser.passwordValidator,
                     togglePasswordVisibility: _toggleCurrentPasswordVisibility,
                     hidePassword: hidePassword,
                     emailSavedValue: _newMail
                 ):const SizedBox(height: 0,),
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
                          onPressed: applyChanges,
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
    if(_newName!=null || _tempLastName!=null){
      formsIconsStats[0]=1;
    }
    _hideAllPassword();
    setState(() {
      _editingUserName = !_editingUserName;
      _editingEmail = false;
      _editingPassword = false;
    });
  }
  _toggleEditPasswordOntTap(){
    if(_newPass!=null && _currPass!=null){
      formsIconsStats[1]=1;
    }
    _hideAllPassword();
    setState(() {
      _editingUserName = false;
      _editingEmail = false;
      _editingPassword = !_editingPassword;
    });
  }
  _toggleEditEmailOntTap(){
    if(_newMail!=null || _currPass!=null){
      formsIconsStats[2]=1;
    }
    _hideAllPassword();
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
  void _getNewNameFromTextField(String value){
    _newName = value;
  }
  void _getNewEmailFromTextField(String value){
    _newMail = value;
  }
  void _getCurrPassFromTextField(String value){
    _currPass = value;
  }
  void _getNewPassFromTextField(String value){
    _newPass = value;
  }
  void _setNameToFullName(String value){
    _tempLastName = value;
  }
  void _hideAllPassword(){
    hidePassword = true;
    hideNewPassword = true;
  }

  applyChanges() {
    print(_newName??'//');
    if(_nameFormKey.currentState?.validate()==true) {
      widget.loggedUser.updateName(
          _nameFormKey, _newName ?? '',
          _tempLastName ?? '', context).then((value) {
        !value ? setState(() {
          formsIconsStats[0] = 2;
        }) :
        setState(() {
          _newName = null;    _tempLastName = null;
          formsIconsStats[0] = 3;
        });
      });
    }
    if(_passwordFormKey.currentState?.validate() == true) {
      widget.loggedUser.updatePassword(
          _currPassFormKey, _currPass ?? '', _newPass ?? '').then((value){
        !value? setState((){
          formsIconsStats[1]=2;
        }):
        setState((){
          formsIconsStats[1]=3;
        });
      });
    }else{
      setState(() {
        formsIconsStats[1]=2;
      });
      _currPass = null;   _newPass = null;
    }
    if(_emailFormKey.currentState?.validate() == true) {
      widget.loggedUser.updateEmail(
          _emailFormKey, _newMail ?? '',
          _currPass ?? '', context).then((value) {
        !value ? setState(() {
          formsIconsStats[2] = 2;
        }) :
        setState(() {
          _newMail = null;
          formsIconsStats[2] = 3;
        })
        ;
      });
      _currPass = null;
    }
  }

}

class PrimitiveWrapper {
  var value;
  PrimitiveWrapper(this.value);
}
