import 'dart:async';
import 'package:sixam_mart/common/models/response_model.dart';
import 'package:sixam_mart/common/widgets/custom_asset_image_widget.dart';
import 'package:sixam_mart/features/auth/domain/enum/centralize_login_enum.dart';
import 'package:sixam_mart/features/auth/screens/new_user_setup_screen.dart';
import 'package:sixam_mart/features/auth/widgets/sign_in/existing_user_bottom_sheet.dart';
import 'package:sixam_mart/features/location/controllers/location_controller.dart';
import 'package:sixam_mart/features/profile/controllers/profile_controller.dart';
import 'package:sixam_mart/features/profile/domain/models/update_user_model.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/auth/controllers/auth_controller.dart';
import 'package:sixam_mart/features/verification/controllers/verification_controller.dart';
import 'package:sixam_mart/features/verification/domein/enum/verification_type_enum.dart';
import 'package:sixam_mart/features/verification/domein/models/verification_data_model.dart';
import 'package:sixam_mart/features/verification/screens/new_pass_screen.dart';
import 'package:sixam_mart/helper/auth_helper.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/common/widgets/custom_app_bar.dart';
import 'package:sixam_mart/common/widgets/custom_button.dart';
import 'package:sixam_mart/common/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationScreen extends StatefulWidget {
  final String? number;
  final String? email;
  final bool fromSignUp;
  final String? token;
  final String? password;
  final String loginType;
  final String? firebaseSession;
  final bool fromForgetPassword;
  final UpdateUserModel? userModel;
  const VerificationScreen({super.key, required this.number, required this.password, required this.fromSignUp,
    required this.token, this.email, required this.loginType, this.firebaseSession, required this.fromForgetPassword, this.userModel});

  @override
  VerificationScreenState createState() => VerificationScreenState();
}

class VerificationScreenState extends State<VerificationScreen> {
  String? _number;
  String? _email;
  Timer? _timer;
  int _seconds = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    Get.find<VerificationController>().updateVerificationCode('', canUpdate: false);
    if(widget.number != null) {
      _number = widget.number!.startsWith('+') ? widget.number : '+${widget.number!.substring(1, widget.number!.length)}';
    }
    _email = widget.email;
    _startTimer();
  }

  void _startTimer() {
    _seconds = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _seconds = _seconds - 1;
      if(_seconds == 0) {
        timer.cancel();
        _timer?.cancel();
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();

    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    bool isDesktop = ResponsiveHelper.isDesktop(context);
    double borderWidth = 1.3;
    return Scaffold(
      // appBar: isDesktop ? null : CustomAppBar(title: _email != null ? 'email_verification'.tr : 'phone_verification'.tr),
      appBar: AppBar(),
      backgroundColor: isDesktop ? Colors.transparent : null,
      body: SafeArea(child: SingleChildScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
        child: Container(
          width: context.width > 700 ? 500 : context.width,
          padding: context.width > 700 ? const EdgeInsets.all(Dimensions.paddingSizeDefault) : null,
          decoration: context.width > 700 ? BoxDecoration(
            color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
          ) : null,
          child: GetBuilder<VerificationController>(builder: (verificationController) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
              isDesktop ? Align(
                alignment: Alignment.topRight,
                child: IconButton(onPressed: ()=> Get.back(), icon: const Icon(Icons.clear)),
              ) : const SizedBox(),
        
              isDesktop ? Padding(
                padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeLarge),
                child: Text(
                  'otp_verification'.tr, style: robotoRegular,
                ),
              ) : const SizedBox(),
        
              // CustomAssetImageWidget(_email != null ? Images.emailVerifiedIcon : Images.otpVerification, height: 100),
              const SizedBox(height: Dimensions.paddingSizeExtremeLarge),
        
              Get.find<SplashController>().configModel!.demo! ? Text(
                'for_demo_purpose'.tr, style: robotoMedium,
              ) : SizedBox(
                width: 300,
                child: 
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Wrap(crossAxisAlignment: WrapCrossAlignment.start, children: [
                     Text("Verification Code",style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                     ),),
                     
                    RichText(text: TextSpan(children: [
                      TextSpan(text: 'We have sent verfication code to your number'.tr, style: robotoRegular.copyWith(color: Theme.of(context).disabledColor,fontSize: 14,fontWeight: FontWeight.w500)),
                      TextSpan(text: ' ${_email ?? _number}', style: robotoMedium.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color,fontWeight: FontWeight.w600 )),
                    ]), textAlign: TextAlign.start,),
                  ],
                  ),
                ),
             
             
              ),
        
              Padding(
                padding: EdgeInsets.only(left: 20,right: 70,top:30),
                child: PinCodeTextField(
                  length: 6,
                  appContext: context,
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.scale,
                  pinTheme: PinTheme(
        
                    shape: PinCodeFieldShape.box,
                    fieldHeight: 60,
                    fieldWidth: 45,
                    borderWidth: borderWidth ,
                    borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                    selectedColor: Theme.of(context).primaryColor,
                    selectedFillColor: Colors.white,
                    inactiveFillColor: Theme.of(context).cardColor,
                    inactiveColor: Theme.of(context).disabledColor.withOpacity(0.6),
                    activeColor: Theme.of(context).disabledColor,
                    activeFillColor: Theme.of(context).cardColor,
                    inactiveBorderWidth: borderWidth,
                    selectedBorderWidth: borderWidth,
                    disabledBorderWidth: borderWidth,
                    errorBorderWidth: borderWidth,
                    activeBorderWidth: borderWidth,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  onChanged: verificationController.updateVerificationCode,
                  beforeTextPaste: (text) => true,
                ),
              ),
              const SizedBox(height: Dimensions.paddingSizeExtraLarge),
        
              GetBuilder<ProfileController>(builder: (profileController) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: isDesktop ? 32 : 20),
                  child: CustomButton(
                    radius: Dimensions.radiusDefault,
                    buttonText: 'verify'.tr,
                    isLoading: verificationController.isLoading || profileController.isLoading,
                    onPressed: verificationController.verificationCode.length < 6 ? null : () {
                      if(widget.firebaseSession != null && widget.userModel == null) {
                        verificationController.verifyFirebaseOtp(
                          phoneNumber: _number!, session: widget.firebaseSession!, loginType: widget.loginType,
                          otp: verificationController.verificationCode, token: widget.token, isForgetPassPage: widget.fromForgetPassword,
                          isSignUpPage: widget.loginType == CentralizeLoginType.otp.name ? false : true,
                        ).then((value) {
                          if(value.isSuccess) {
                            _handleVerifyResponse(value, _number, _email);
                          }else {
                            showCustomSnackBar(value.message);
                          }
                        });
                      } else if(widget.userModel != null) {
                        widget.userModel!.otp = verificationController.verificationCode;
                        Get.find<ProfileController>().updateUserInfo(widget.userModel!, Get.find<AuthController>().getUserToken(), fromButton: true);
                      }
                      else if(widget.fromSignUp) {
                        verificationController.verifyPhone(data: VerificationDataModel(
                          phone: _number, email: _email, verificationType: _number != null
                            ? VerificationTypeEnum.phone.name : VerificationTypeEnum.email.name,
                          otp: verificationController.verificationCode, loginType: widget.loginType,
                          guestId: AuthHelper.getGuestId(),
                        )).then((value) {
                          if(value.isSuccess) {
                            _handleVerifyResponse(value, _number, _email);
                          } else {
                            showCustomSnackBar(value.message);
                          }
                        });
                      } else {
                        verificationController.verifyToken(_number).then((value) {
                          if(value.isSuccess) {
                            if(ResponsiveHelper.isDesktop(Get.context!)){
                              Get.dialog(Center(child: NewPassScreen(resetToken: verificationController.verificationCode, number : _number, fromPasswordChange: false, fromDialog: true )));
                            }else{
                              Get.toNamed(RouteHelper.getResetPasswordRoute(_number, verificationController.verificationCode, 'reset-password'));
                            }
                          }else {
                            showCustomSnackBar(value.message);
                          }
                        });
                      }
                    },
                  ),
                );
              }),
              const SizedBox(height: Dimensions.paddingSizeDefault),
        
              Padding(
                padding: EdgeInsets.symmetric(horizontal: isDesktop ? 29 : 20),
                child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Text(
                    'did_not_receive_the_code'.tr,
                    style: robotoRegular.copyWith(color: Theme.of(context).disabledColor),
                  ),
                  TextButton(
                    onPressed: _seconds < 1 ? () async {
                      if(widget.firebaseSession != null) {
                        await Get.find<AuthController>().firebaseVerifyPhoneNumber(_number!, widget.token, widget.loginType, fromSignUp: widget.fromSignUp, canRoute: false);
                        _startTimer();
                      } else {
                        _resendOtp();
                      }
                    } : null,
                    child: Text('${'resent_it'.tr}${_seconds > 0 ? ' (${_seconds}s)' : ''}', style: TextStyle(color: Theme.of(context).primaryColor),),
                  ),
                ]),
              ),
              const SizedBox(height: Dimensions.paddingSizeLarge),
        
            ]);
          }),
        ),
      )),
    );
  }

  void _handleVerifyResponse(ResponseModel response, String? number, String? email) {
    if(response.authResponseModel != null && response.authResponseModel!.isExistUser != null) {
      if(ResponsiveHelper.isDesktop(context)) {
        Get.back();
        Get.dialog(Center(
          child: ExistingUserBottomSheet(
            userModel: response.authResponseModel!.isExistUser!, number: _number, email: _email,
            loginType: widget.loginType, otp: Get.find<VerificationController>().verificationCode,
          ),
        ));
      } else {
        Get.bottomSheet(ExistingUserBottomSheet(
          userModel: response.authResponseModel!.isExistUser!, number: _number, email: _email,
          loginType: widget.loginType, otp: Get.find<VerificationController>().verificationCode,
        ));
      }
    } else if(response.authResponseModel != null && !response.authResponseModel!.isPersonalInfo!) {
      if(ResponsiveHelper.isDesktop(context)) {
        Get.back();
        Get.dialog(NewUserSetupScreen(name: '', loginType: widget.loginType, phone: number, email: email));
      } else {
        Get.toNamed(RouteHelper.getNewUserSetupScreen(name: '', loginType: widget.loginType, phone: number, email: email));
      }
    } else {

      if(widget.fromForgetPassword) {
        Get.toNamed(RouteHelper.getResetPasswordRoute(_number, Get.find<VerificationController>().verificationCode, 'reset-password'));
      } else {
        Get.find<LocationController>().navigateToLocationScreen('verification', offNamed: true);
      }
    }
  }

  void _resendOtp() {
    if(widget.userModel != null) {
      Get.find<ProfileController>().updateUserInfo(widget.userModel!, Get.find<AuthController>().getUserToken(), fromVerification: true);
    } else if(widget.fromSignUp) {
      if(widget.loginType == CentralizeLoginType.otp.name) {
        Get.find<AuthController>().otpLogin(phone: _number!, otp: '', loginType: widget.loginType, verified: '').then((response) {
          if (response.isSuccess) {
            _startTimer();
            showCustomSnackBar('resend_code_successful'.tr, isError: false);
          } else {
            showCustomSnackBar(response.message);
          }
        });
      } else {
        Get.find<AuthController>().login(
          emailOrPhone: _number != null ? _number! : _email ?? '', password: widget.password!, loginType: widget.loginType,
          fieldType: _number != null ? VerificationTypeEnum.phone.name : VerificationTypeEnum.email.name,
        ).then((value) {
          if (value.isSuccess) {
            _startTimer();
            showCustomSnackBar('resend_code_successful'.tr, isError: false);
          } else {
            showCustomSnackBar(value.message);
          }
        });
      }
    } else {
      Get.find<VerificationController>().forgetPassword(_number).then((value) {
        if (value.isSuccess) {
          _startTimer();
          showCustomSnackBar('resend_code_successful'.tr, isError: false);
        } else {
          showCustomSnackBar(value.message);
        }
      });
    }
  }
}
