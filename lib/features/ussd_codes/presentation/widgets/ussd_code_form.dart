import 'package:flutter/material.dart';
import 'package:todo/core/platform_channels/platform_channels.dart';
import 'package:todo/core/services/contacts.dart';
import 'package:todo/features/ussd_codes/domain/entities/entities.dart';

class UssdCodeForm extends StatefulWidget {
  final List<UssdCodeField> fields;
  final String code;
  final String type;
  final Icon icon;

  UssdCodeForm({this.code, this.fields, this.type, this.icon});

  _UssdCodeFormState createState() => _UssdCodeFormState();
}

class _UssdCodeFormState extends State<UssdCodeForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController phoneNumberController = TextEditingController();

  String code;

  @override
  void initState() {
    super.initState();

    setState(() {
      code = widget.code;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
                widget.icon,
                SizedBox(
                  height: 30,
                ),
              ] +
              widget.fields.map((field) {
                switch (field.type) {
                  // INPUT PHONE_NUMBER
                  case 'phone_number':
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: phoneNumberController,
                        maxLength: 8,
                        autovalidateMode: AutovalidateMode.always,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: field.name.toUpperCase(),
                          suffixIcon: FlatButton(
                            onPressed: () async {
                              String number = await getContactPhoneNumber();
                              number = number.replaceAll('-', '');

                              phoneNumberController.text = number;
                              phoneNumberController.addListener(() {
                                phoneNumberController.selection = TextSelection(
                                    baseOffset: 8, extentOffset: 8);
                              });
                            },
                            child: Icon(
                              Icons.contacts,
                              color: Colors.blue,
                              semanticLabel: "Seleccionar contacto",
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Colors.blue,
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Este campo no debe estar vacío';
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
                        onSaved: (val) {
                          String rem = '{${field.name}}';

                          String newCode = code.replaceAll(rem, val);

                          setState(() {
                            code = newCode;
                          });
                        },
                      ),
                    );

                  // INPUT MONEY
                  case 'money':
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                          autovalidateMode: AutovalidateMode.always,
                          maxLength: 4,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: field.name.toUpperCase(),
                            prefixIcon: Icon(
                              Icons.attach_money,
                              color: Colors.blue,
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Este campo no debe estar vacío';
                            }

                            try {
                              final cant = double.parse(value);

                              if (cant.isNegative) {
                                return 'Debe poner una cantidad mayor que cero';
                              }
                              if (value.split('.')[1].length > 2) {
                                return 'Solo se admiten valores de tipo monetario';
                              }
                            } on RangeError {
                              return null;
                            } catch (e) {
                              return 'Solo se admiten valores de tipo monetario';
                            }

                            return null;
                          },
                          keyboardType: TextInputType.number,
                          onSaved: (val) {
                            String rem = '{${field.name}}';

                            String newCode;

                            if (val.contains('.'))
                              newCode = code.replaceAll('*$rem', '');
                            else
                              newCode = code.replaceAll(rem, val);

                            setState(() {
                              code = newCode;
                            });
                          }),
                    );

                  // INPUT KEY
                  case 'key_number':
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        obscureText: true,
                        maxLength: 4,
                        autovalidateMode: AutovalidateMode.always,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: field.name.toUpperCase(),
                          prefixIcon: Icon(
                            Icons.vpn_key,
                            color: Colors.blue,
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Este campo no debe estar vacío';
                          }

                          if (value.length != 4) {
                            return 'La clave debe contener 4 dígitos';
                          }

                          try {
                            if (int.parse(value) < 0) {
                              return 'La clave no debe contener símbolos';
                            }
                          } catch (e) {
                            return 'La clave no debe contener símbolos';
                          }

                          return null;
                        },
                        keyboardType: TextInputType.number,
                        onSaved: (val) {
                          String rem = '{${field.name}}';

                          String newCode = code.replaceAll(rem, val);

                          setState(() {
                            code = newCode;
                          });
                        },
                      ),
                    );

                  // INPUT CARD NUMBER
                  case 'card_number':
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        maxLength: 16,
                        autovalidateMode: AutovalidateMode.always,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: field.name.toUpperCase(),
                          prefixIcon: Icon(
                            Icons.credit_card,
                            color: Colors.blue,
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Este campo no debe estar vacío';
                          }

                          if (value.length != 16) {
                            return 'El número de la tarjeta debe contener 16 dígitos';
                          }

                          return null;
                        },
                        keyboardType: TextInputType.number,
                        onSaved: (val) {
                          String rem = '{${field.name}}';

                          String newCode = code.replaceAll(rem, val);

                          setState(() {
                            code = newCode;
                          });
                        },
                      ),
                    );

                  // DEFAULT ONLY FOR DEBUG
                  default:
                    return Text('Type of field ${field.type} unknown');
                }
              }).toList() +
              [
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: RaisedButton(
                    elevation: 0,
                    color: Colors.blue,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.call,
                        size: 48,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      final form = _formKey.currentState;

                      if (form.validate()) {
                        form.save();
                        callTo(code);
                        setState(() {
                          code = widget.code;
                        });
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
