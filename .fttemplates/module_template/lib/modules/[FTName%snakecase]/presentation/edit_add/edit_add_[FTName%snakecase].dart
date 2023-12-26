import 'package:easy_localization/easy_localization.dart';
import 'package:appbase/modules/<FTName | snakecase>/cubit/cubit.dart';
import 'package:appbase/modules/<FTName | snakecase>/domain/model/<FTName | snakecase>_model.dart';
import 'package:appbase/shared/models/translations.dart';
import 'package:appbase/shared/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/utils/Utils.dart';
import '../../../../core/utils/validations.dart';
import '../../../../shared/widgets/buttons.dart';

class EditAdd<FTName | pascalcase> extends StatefulWidget {
  const EditAdd<FTName | pascalcase>({super.key, this.<FTName | camelcase>});
  final <FTName | pascalcase>? <FTName | camelcase>;
  @override
  State<EditAdd<FTName | pascalcase>> createState() => _EditAdd<FTName | pascalcase>State();
}

class _EditAdd<FTName | pascalcase>State extends State<EditAdd<FTName | pascalcase>> {
  late <FTName | pascalcase> <FTName | camelcase>;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    <FTName | camelcase> = widget.<FTName | camelcase> ?? <FTName | pascalcase>(translation: TranslationModel());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.<FTName | camelcase> != null ? "edit<FTName | pascalcase>".tr() : "add<FTName | pascalcase>".tr()),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 28),
              DefaultTextField(
                initValue: <FTName | camelcase>.translation?.ar,
                keyboardType: TextInputType.name,
                showLabel: true,
                inputFormatter: [
                  FilteringTextInputFormatter.allow(Utils.arabicRegEx),
                ],
                hintText: "<FTName | camelcase>Name".tr(),
                label: "<FTName | camelcase>Name".tr(),
                validate: Validation.defaultValidation,
                onSave: (p0) {
                  <FTName | camelcase>.translation?.ar = p0;
                },
              ),
              DefaultTextField(
                initValue: <FTName | camelcase>.translation?.en,
                keyboardType: TextInputType.name,
                showLabel: true,
                inputFormatter: [
                  FilteringTextInputFormatter.allow(Utils.englishRegEx),
                ],
                hintText: "<FTName | camelcase>NameEn".tr(),
                label: "<FTName | camelcase>NameEn".tr(),
                onSave: (p0) {
                  <FTName | camelcase>.translation?.en = p0;
                },
              ),
              DefaultTextField(
                initValue: <FTName | camelcase>.phone,
                keyboardType: TextInputType.number,
                showLabel: true,
                hintText: "phone".tr(),
                label: "phone".tr(),
                onSave: (p0) {
                  <FTName | camelcase>.phone = p0;
                },
              ),
              DefaultTextField(
                initValue: <FTName | camelcase>.address,
                keyboardType: TextInputType.streetAddress,
                showLabel: true,
                hintText: "address".tr(),
                label: "address".tr(),
                onSave: (p0) {
                  <FTName | camelcase>.address = p0;
                },
              ),
              DefaultTextField(
                initValue: <FTName | camelcase>.taxNumber,
                keyboardType: TextInputType.number,
                showLabel: true,
                inputFormatter: [
                  LengthLimitingTextInputFormatter(15),
                ],
                hintText: "taxNumber".tr(),
                label: "taxNumber".tr(),
                onSave: (p0) {
                  <FTName | camelcase>.taxNumber = p0;
                },
              ),

              Column(
                children: [
                    const SizedBox(height: 24),
              DefaultButton(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final cubit = <FTName | pascalcase>Cubit();
                    widget.<FTName | camelcase> != null ? cubit.update(<FTName | camelcase>: <FTName | camelcase>) : cubit.store(<FTName | camelcase>: <FTName | camelcase>);
                  }
                },
                icon: const Icon(Icons.add),
                text: "save".tr(),
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: MediaQuery.of(context).viewInsets.bottom,
              )
                ],
              )
            
            ],
          ),
        ),
      ),
    );
  }
}
