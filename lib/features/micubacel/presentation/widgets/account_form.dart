import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:todo/features/micubacel/data/models/models.dart';
import 'package:todo/features/micubacel/presentation/bloc/bloc.dart';
import 'package:todo/features/micubacel/presentation/pages/pages.dart';

class CubacelAccountForm extends StatefulWidget {
  @override
  _CubacelAccountFormState createState() => _CubacelAccountFormState();
}

class _CubacelAccountFormState extends State<CubacelAccountForm> {
  final _formKey = GlobalKey<FormState>();
  bool obscure = true;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: nameController,
                maxLength: 12,
                autovalidateMode: AutovalidateMode.always,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nombre',
                  prefixIcon: Icon(
                    Icons.account_box,
                    color: Colors.blue,
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Asigne un nombre para esta cuenta';
                  }

                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: phoneNumberController,
                maxLength: 8,
                autovalidateMode: AutovalidateMode.always,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Número de teléfono',
                  prefixIcon: Icon(
                    Icons.phone,
                    color: Colors.blue,
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Número de teléfono de esta cuenta';
                  }

                  if (value.length < 8) {
                    return 'Este campo debe contener 8 digitos';
                  }

                  if (value[0] != '5') {
                    return 'Este campo debe comenzar con el dígito 5';
                  }

                  return null;
                },
                keyboardType: TextInputType.phone,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: passwordController,
                obscureText: obscure,
                autovalidateMode: AutovalidateMode.always,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Contraseña',
                  prefixIcon: Icon(
                    Icons.vpn_key,
                    color: Colors.blue,
                  ),
                  suffixIcon: FlatButton(
                    onPressed: () {
                      setState(() {
                        obscure = !obscure;
                      });
                    },
                    child: Icon(
                      Icons.remove_red_eye,
                      color: Colors.blue,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Debe especificar la contraseña';
                  }

                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: RaisedButton(
                elevation: 0,
                color: Colors.blue,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Icon(
                    Icons.add_box,
                    size: 48,
                    color: Colors.white,
                  ),
                ),
                onPressed: () async {
                  final form = _formKey.currentState;

                  if (form.validate()) {
                    await UserModel(
                      name: nameController.text,
                      phone: phoneNumberController.text,
                      password: passwordController.text,
                    ).save;

                    BlocProvider.of<AccountsBloc>(context).add(GetAccounts());

                    Get.back();
                    Get.back();
                    Get.to(CubacelAccountsPage());
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
