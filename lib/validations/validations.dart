
class Validations {
   emailvalidation(String value) {
    if (!RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return 'invalid email';
    }
    return null;
  }

/*String? validateEmail(String value) {
  var pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  return (!regex.hasMatch(value)) ? 'invalida Email' : null;
}*/
  String? validateEmail(String? value) {
    bool emailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value!);
    if (!emailValid) {
      return 'Enter a valid email address';
    }
  }

  String? mobilevalidation(String value) {
    if (value.isEmpty || !RegExp(r"^[0-9]{10}$").hasMatch(value)) {
      return 'invalid mobile';
    }
  }



 String? namevalidation(String value) {
    if (value.length < 3) {
      return 'enter proper Name';
    }
  }
   passwordValidation(String value){
    if(value.isEmpty){
      return 'Enter Password';
    }
    if(value.length<6){
      return 'Please Enter BiggerPassword';
    }
   }
}
class NewValidations{
  emailValidations(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    if (value.length == 0) {
      return 'Email is required';
    }
    if (!regex.hasMatch(value))
      return 'Enter Valide Email';
    else {
      return null;
    }
  }

  String? nameValidation(String value) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Please enter your name";
    } else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z";
    }
    return null;
  }

  String? pincodevalidation(String value) {
    if (value.isEmpty || !RegExp(r"^[0-9]{6}$").hasMatch(value)) {
      return 'invalid PinCode';
    }
  }

  String? passwordValidation(String value) {
    bool hasUppercase = value.contains(new RegExp(r'[A-Z]'));
    bool hasDigits = value.contains(new RegExp(r'[0-9]'));
    bool hasLowercase = value.contains(new RegExp(r'[a-z]'));
    bool hasSpecialCharacters =
    value.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    var minLength = 8;
    bool hasMinLength = value.length >= minLength;
    print(value);
    if (value.isEmpty) {
      return 'Please enter password';
    }
    if (!hasLowercase) {
      return 'Please enter valid password';
    } else if (!hasDigits) {
      return 'Please enter valid password';
    } else if (!hasUppercase) {
      return 'Please enter valid password';
    } else if (!hasSpecialCharacters) {
      return 'Please enter valid password';
    } else if (!hasMinLength) {
      return 'Please enter valid password';
    } else {
      return '';
    }
  }

  String? confirmPasswordValidation(conformPasswordValue, newPasswordValue) {
    if (newPasswordValue.isEmpty || newPasswordValue == null) {
      return 'Please enter confirm password';
    }
    if (conformPasswordValue.isEmpty) {
      return "Please conform your password";
    } else if (conformPasswordValue != newPasswordValue) {
      return "Field is not matched with password";
    } else {
      return '';
    }
  }
  String? isnotEmptyValidation(String value){
    if(value.isEmpty){
      return "Please Enter User";
    }
  }
}