import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_with_mvvm/presentation/register/register_viewmodel.dart';

import '../../app/di.dart';
import '../../data/mapper/mapper.dart';
import '../common/state_renderer/state_render_impl.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/values_manager.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  RegisterViewModel _viewModel = instance<RegisterViewModel>();
  final _formKey = GlobalKey<FormState>();

  TextEditingController _userNameTextEditingController =
      TextEditingController();
  TextEditingController _mobileNumberTextEditingController =
      TextEditingController();
  TextEditingController _emailEditingController = TextEditingController();
  TextEditingController _passwordEditingController = TextEditingController();

  @override
  void initState() {
    _bind();
    super.initState();
  }

  _bind() {
    _viewModel.start();
    _userNameTextEditingController.addListener(() {
      _viewModel.setUserName(_userNameTextEditingController.text);
    });

    _passwordEditingController.addListener(() {
      _viewModel.setPassword(_passwordEditingController.text);
    });

    _emailEditingController.addListener(() {
      _viewModel.setEmail(_emailEditingController.text);
    });

    _mobileNumberTextEditingController.addListener(() {
      _viewModel.setMobileNumber(_mobileNumberTextEditingController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        elevation: AppSize.s0,
        iconTheme: IconThemeData(color: ColorManager.primary),
        backgroundColor: ColorManager.white,
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return Center(
            child: snapshot.data?.getScreenWidget(context, _getContentWidget(),
                    () {
                  _viewModel.register();
                }) ??
                _getContentWidget(),
          );
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return Container(
        padding: EdgeInsets.only(top: AppPadding.p60),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image(image: AssetImage(ImageAssets.splashLogo)),
                SizedBox(height: AppSize.s28),
                Padding(
                  padding: EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder<String?>(
                    stream: _viewModel.outputErrorUserName,
                    builder: (context, snapshot) {
                      return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _userNameTextEditingController,
                          decoration: InputDecoration(
                              hintText: AppStrings.username,
                              labelText: AppStrings.username,
                              errorText: snapshot.data));
                    },
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: AppPadding.p28,
                        right: AppPadding.p28,
                        bottom: AppPadding.p28),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: CountryCodePicker(
                              onChanged: (country) {
                                // update view model with the selected code
                                _viewModel
                                    .setCountryCode(country.dialCode ?? EMPTY);
                              },
                              initialSelection: "+11",
                              showCountryOnly: true,
                              showOnlyCountryWhenClosed: true,
                              favorite: ["+91", "+92", "+90"],
                            )),
                        Expanded(
                            flex: 3,
                            child: StreamBuilder<String?>(
                              stream: _viewModel.outputErrorMobileNumber,
                              builder: (context, snapshot) {
                                return TextFormField(
                                    keyboardType: TextInputType.phone,
                                    controller:
                                        _mobileNumberTextEditingController,
                                    decoration: InputDecoration(
                                        hintText: AppStrings.mobileNumber,
                                        labelText: AppStrings.mobileNumber,
                                        errorText: snapshot.data));
                              },
                            ))
                      ],
                    ),
                  ),
                ),
                SizedBox(height: AppSize.s28),
                Padding(
                  padding: EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder<String?>(
                    stream: _viewModel.outputErrorEmail,
                    builder: (context, snapshot) {
                      return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailEditingController,
                          decoration: InputDecoration(
                              hintText: AppStrings.emailHint,
                              labelText: AppStrings.emailHint,
                              errorText: snapshot.data));
                    },
                  ),
                ),
                SizedBox(height: AppSize.s28),
                Padding(
                  padding: EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder<String?>(
                    stream: _viewModel.outputErrorPassword,
                    builder: (context, snapshot) {
                      return TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: _passwordEditingController,
                          decoration: InputDecoration(
                              hintText: AppStrings.password,
                              labelText: AppStrings.password,
                              errorText: snapshot.data));
                    },
                  ),
                ),
                SizedBox(height: AppSize.s28),
                Padding(
                    padding: EdgeInsets.only(
                        left: AppPadding.p28, right: AppPadding.p28),
                    child: StreamBuilder<bool>(
                      stream: _viewModel.outputIsAllInputsValid,
                      builder: (context, snapshot) {
                        return SizedBox(
                          width: double.infinity,
                          height: AppSize.s40,
                          child: ElevatedButton(
                              onPressed: (snapshot.data ?? false)
                                  ? () {
                                      _viewModel.register();
                                    }
                                  : null,
                              child: Text(AppStrings.login)),
                        );
                      },
                    )),
                Padding(
                  padding: EdgeInsets.only(
                    top: AppPadding.p8,
                    left: AppPadding.p28,
                    right: AppPadding.p28,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, Routes.forgotPasswordRoute);
                        },
                        child: Text(AppStrings.forgetPassword,
                            style: Theme.of(context).textTheme.subtitle2),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.registerRoute);
                        },
                        child: Text(AppStrings.registerText,
                            style: Theme.of(context).textTheme.subtitle2),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
