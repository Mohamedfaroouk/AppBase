import 'package:easy_localization/easy_localization.dart';
import 'package:efatorh/modules/client/cubit/cubit.dart';
import 'package:efatorh/modules/client/domain/model/client_model.dart';
import 'package:efatorh/shared/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/utils/Utils.dart';
import '../../../../core/utils/validations.dart';
import '../../../../shared/widgets/buttons.dart';

class EditAddClient extends StatefulWidget {
  const EditAddClient({super.key, this.client});
  final Client? client;
  @override
  State<EditAddClient> createState() => _EditAddClientState();
}

class _EditAddClientState extends State<EditAddClient> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title:
            Text(widget.client != null ? "editClient".tr() : "addClient".tr()),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: EditAddClientForm(
          client: widget.client ?? Client(),
          isEdit: widget.client != null,
        ),
      ),
    );
  }
}

class EditAddClientForm extends StatefulWidget {
  const EditAddClientForm({
    super.key,
    required this.client,
    required this.isEdit,
  });

  final Client client;
  final bool isEdit;

  @override
  State<EditAddClientForm> createState() => _EditAddClientFormState();
}

class _EditAddClientFormState extends State<EditAddClientForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Client client = Client();
  @override
  void initState() {
    client = widget.client;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Wrap(
          children: [
            const SizedBox(height: 28),
            DefaultTextField(
              initValue: client.translation?.ar,
              keyboardType: TextInputType.name,
              showLabel: true,
              inputFormatter: [
                FilteringTextInputFormatter.allow(Utils.arabicRegEx),
              ],
              hintText: "clientName".tr(),
              label: "clientName".tr(),
              validate: Validation.defaultValidation,
              onSave: (p0) {
                client.translation?.ar = p0;
              },
            ),
            DefaultTextField(
              initValue: client.translation?.en,
              keyboardType: TextInputType.name,
              showLabel: true,
              inputFormatter: [
                FilteringTextInputFormatter.allow(Utils.englishRegEx),
              ],
              hintText: "clientNameEn".tr(),
              label: "clientNameEn".tr(),
              onSave: (p0) {
                client.translation?.en = p0;
              },
            ),
            DefaultTextField(
              initValue: client.phone,
              keyboardType: TextInputType.number,
              showLabel: true,
              hintText: "phone".tr(),
              label: "phone".tr(),
              onSave: (p0) {
                client.phone = p0;
              },
            ),
            DefaultTextField(
              initValue: client.address,
              keyboardType: TextInputType.streetAddress,
              showLabel: true,
              hintText: "address".tr(),
              label: "address".tr(),
              onSave: (p0) {
                client.address = p0;
              },
            ),
            DefaultTextField(
              initValue: client.taxNumber,
              keyboardType: TextInputType.number,
              showLabel: true,
              inputFormatter: [
                LengthLimitingTextInputFormatter(15),
              ],
              hintText: "taxNumber".tr(),
              label: "taxNumber".tr(),
              onSave: (p0) {
                client.taxNumber = p0;
              },
            ),
            Column(
              children: [
                const SizedBox(height: 24),
                DefaultButton(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      final cubit = ClientCubit();
                      widget.isEdit
                          ? cubit.update(client: client)
                          : cubit.store(client: client);
                    }
                  },
                  icon: const Icon(Icons.add),
                  text: "save".tr(),
                ),
                const SizedBox(height: 24),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).viewInsets.bottom,
            )
          ],
        ),
      ),
    );
  }
}
