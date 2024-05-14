class LoginRequest {
  String email;
  String password;
  String imei;
  String deviceType;

  LoginRequest(this.email, this.password, this.imei, this.deviceType);
}

class RegisterRequest {
  String countryMobileCode;
  String username;
  String email;
  String password;

  String profilePicture;
  String mobileNumber;

  RegisterRequest(this.countryMobileCode, this.username, this.email,
      this.password, this.profilePicture, this.mobileNumber);
}
