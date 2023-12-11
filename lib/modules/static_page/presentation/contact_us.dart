import 'package:easy_localization/easy_localization.dart';
import 'package:efatorh/core/theme/dynamic_theme/colors.dart';
import 'package:efatorh/modules/static_page/cubit/cubit.dart';
import 'package:efatorh/modules/static_page/cubit/states.dart';
import 'package:efatorh/shared/widgets/buttons.dart';
import 'package:efatorh/shared/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/alerts.dart';
import '../../../core/utils/validations.dart';
import '../domain/request/static_page_request.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  ContactUsRequest contactUsRequest = ContactUsRequest();
  final TextEditingController imageController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StaticPageCubit(),
      child: BlocConsumer<StaticPageCubit, StaticPageStates>(
          listener: (context, state) {
        if (state is ContactUsSendSuccess) {
          Alerts.snack(text: state.message, state: SnackState.success).then(
            (value) => Navigator.pop(context),
          );
        }
      }, builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              "contuctUs".tr(),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.primary,
                      child: const Icon(
                        Icons.email,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    DefaultTextField(
                      showLabel: true,
                      flex: 1,
                      label: "name".tr(),
                      onChange: (s) {
                        contactUsRequest.name = s;
                        return null;
                      },
                      validate: Validation.defaultValidation,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    DefaultTextField(
                      showLabel: true,
                      flex: 1,
                      label: "emailHint".tr(),
                      onChange: (s) {
                        contactUsRequest.email = s;
                        return null;
                      },
                      validate: Validation.emailValidation,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    DefaultTextField(
                      showLabel: true,
                      flex: 1,
                      label: "phone".tr(),
                      inputFormatter: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      keyboardType: TextInputType.phone,
                      validate: (s) =>
                          Validation.phoneValidation(s, required: true),
                      onChange: (s) {
                        contactUsRequest.phone = s;
                        return null;
                      },
                    ),
                    // DefaultDropDown(
                    //   items: ["1", "2", "3"],
                    //   lable: "سبب الرساله",
                    //   onChanged: (s) {
                    //     contactUsRequest.reason = s;
                    //   },
                    //   validate: Validation.defaultValidation,
                    // ),
                    const SizedBox(
                      height: 15,
                    ),

                    DefaultTextField(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      showLabel: true,
                      flex: 1,
                      label: "message".tr(),
                      maxlines: 5,
                      onChange: (s) {
                        contactUsRequest.message = s;
                        return null;
                      },
                      validate: Validation.defaultValidation,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DefaultButton(
                      text: "send".tr(),
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          BlocProvider.of<StaticPageCubit>(context)
                              .contactUs(contactUsRequest: contactUsRequest);
                          print(contactUsRequest.toJson());
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
