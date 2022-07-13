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
  bool hidePassword = true, hideNewPassword = true;
  final _nameFormKey = GlobalKey<FormState>(), _passwordFormKey = GlobalKey<FormState>(),
  _currPassFormKey = GlobalKey<FormState>(), _emailFormKey = GlobalKey<FormState>();

  final PersonParamToEdit _infoParameter = PersonParamToEdit();

  void initState(){
    _editingUserName = false;
    _editingEmail = false;
    _editingPassword = false;
  }

  @override
  Widget build(BuildContext context) {
    print('========================='+widget.loggedUser.id+'============================');


    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Account"),
          backgroundColor: Color(0xFFF87217),
        ),
      body: Stack(
        children: [
          Container(
            child: Image.asset(
              'assets/backgroundTop.png',
              fit: BoxFit.fill,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          Column(
            children :[
              Expanded(
                child: ListView(
                children: <Widget>[
                 const SizedBox(height: 25,),
                 TileEditCard(cardTitle: 'Edit Name', onTapFunction: _toggleEditNameOntTap, iconState: formsIconsStats[0]),
                 _editingUserName?
                    EditUserNameForm(
                        formKey: _nameFormKey,
                        nameReturner: _infoParameter.setNewName,
                        lastNameReturner: _infoParameter.setNameToFullName,
                        firstNameSavedValue: _infoParameter.getNewName(),
                        lastNameSavedValue: _infoParameter.getLastNameTemp()
                    )
                    : const SizedBox(height: 10,),
                 TileEditCard(cardTitle: 'Edit Password', onTapFunction: _toggleEditPasswordOntTap, iconState: formsIconsStats[1]),
                 _editingPassword?
                      EditPasswordForm(
                          person: widget.loggedUser,
                          passwordGetter: _infoParameter.setCurrPass,
                          newPasswordGetter: _infoParameter.setNewPass,
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
                         emailReturner: _infoParameter.setNewEmail,
                         passReturner: _infoParameter.setCurrPass,
                         emailValidator: widget.loggedUser.mailValidator,
                         passwordValidator: widget.loggedUser.passwordValidator,
                         togglePasswordVisibility: _toggleCurrentPasswordVisibility,
                         hidePassword: hidePassword,
                         emailSavedValue: _infoParameter.getNewMail()
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
                              onPressed: ()=> _infoParameter.applyChanges(widget.loggedUser, _nameFormKey,
                                  _passwordFormKey, _emailFormKey, _iconResponseToApplyChanges, context),
                              child: const Text(
                                'Save Changes',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                onPrimary: const Color(0xFFF87217),
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
          ),
        ],
      )
    );
  }

  _toggleEditNameOntTap(){
    if(_infoParameter.getNewName()!=null || _infoParameter.getLastNameTemp()!=null){
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
    if(!_infoParameter.doseCurrPassIsNull() && !_infoParameter.doseNewPassIsNull()){
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
    if(_infoParameter.getNewMail()!=null || !_infoParameter.doseCurrPassIsNull()){
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

  void _hideAllPassword(){
    hidePassword = true;
    hideNewPassword = true;
  }

  _iconResponseToApplyChanges(int index, int value){
    setState(() {
      formsIconsStats[index] = value;
    });
  }
}

class PersonParamToEdit {
  String? _newName, _currPass, _newPass, _newToConfirmedPass, _newMail, _tempLastName;

  void setNewName(String? value){
    _newName = value;
  }
  void setNewEmail(String? value){
    _newMail = value;
  }
  void setCurrPass(String? value){
    _currPass = value;
  }
  void setNewPass(String? value){
    _newPass = value;
  }
  void setToConfirmPass(String? value){
    _newPass = value;
  }
  void setNameToFullName(String? value){
    _tempLastName = value;
  }

  String? getNewName() => _newName;
  String? getNewMail() => _newMail;
  String? getLastNameTemp() => _tempLastName;

  bool doseCurrPassIsNull() => _currPass == null;
  bool doseNewPassIsNull() => _currPass == null;
  bool doseConfirmedPassIsNull() => _currPass == null;

  applyChanges(Person loggedUser, GlobalKey<FormState> nameFormKey, GlobalKey<FormState> passwordFormKey,
      GlobalKey<FormState> emailFormKey, Function onUpdate, BuildContext context) {
    print(_newName??'//');
    if(nameFormKey.currentState?.validate()==true) {
      loggedUser.updateName(
          nameFormKey, _newName ?? '',
          _tempLastName ?? '', context).then((value) {
        !value ? onUpdate(0, 2) :
        () =>(){
          _newName = null;    _tempLastName = null;
          onUpdate(0, 3);
        };
      });
    }
    if(passwordFormKey.currentState?.validate() == true) {
      loggedUser.updatePassword(
          passwordFormKey, _currPass ?? '', _newPass ?? '').then((value){
        !value? onUpdate(1, 2) : onUpdate(1, 3);
      });
    }else{
      onUpdate(1, 2);
      _currPass = null;
      _newPass = null;
      _newToConfirmedPass = null;
    }
    if(emailFormKey.currentState?.validate() == true) {
      loggedUser.updateEmail(
          emailFormKey, _newMail ?? '',
          _currPass ?? '', context).then((value) {
        !value ? onUpdate(2, 2) :
        ()=> (){
          _newMail = null;
          onUpdate(2, 3);
        };
      });
      _currPass = null;
    }
  }

}
