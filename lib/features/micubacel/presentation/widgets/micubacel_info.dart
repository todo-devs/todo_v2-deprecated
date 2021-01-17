import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/micubacel/data/datasources/datasources.dart';
import 'package:todo/features/micubacel/presentation/bloc/bloc.dart';

class MiCubacelInfo extends StatelessWidget {
  const MiCubacelInfo({
    Key key,
    @required this.client,
  }) : super(key: key);

  final CubacelClient client;

  String totalData(double restData, int percent) {
    final data = restData * 10 / (100 - percent);

    return data.toInt().toString();
  }

  String consumedData(double restData, int percent) {
    final data = restData * 100 / (100 - percent);

    return (data - restData).round().toString();
  }

  String consumedNational(double restData) {
    return (300 - restData).round().toString();
  }

  double percentNational(restData) {
    return (1 - (restData / 300));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.monetization_on,
                              size: 32,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.blue,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              client.credit,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 32,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.phone,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.blue,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              client.phoneNumber,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.blue,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today_outlined,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.blue,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              client.expire,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.update,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.blue,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              client.updated,
                              style: TextStyle(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.blue,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        FlatButton(
                          onPressed: () {
                            BlocProvider.of<MicubacelBloc>(context).add(
                              UpdateMicubacelData(),
                            );
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.refresh,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.blue,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                'Actualizar',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.blue,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ] +
              client.buys.map((e) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        e.restData.toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 32,
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.white
                                              : Colors.blue,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        e.title.contains('Nacional')
                                            ? '- ${consumedNational(e.restData)}'
                                            : '- ${consumedData(e.restData, e.percent)}',
                                        style: TextStyle(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.white
                                              : Colors.blue,
                                        ),
                                      ),
                                      Text(
                                        e.dataInfo,
                                        style: TextStyle(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.white
                                              : Colors.blue,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                e.title
                                    .replaceAll('Navegación', '')
                                    .replaceAll('Paquete de', 'Internet')
                                    .trim(),
                                style: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.blue,
                                ),
                              ),
                              e.title.contains('Nacional')
                                  ? Text(
                                      '300 MB',
                                      style: TextStyle(
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : Colors.blue,
                                      ),
                                    )
                                  : Text(
                                      '~ ${totalData(e.restData, e.percent)}0 MB',
                                      style: TextStyle(
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : Colors.blue,
                                      ),
                                    ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: LinearProgressIndicator(
                          value: e.title.contains('Nacional')
                              ? percentNational(e.restData)
                              : e.percent / 100,
                        ),
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.watch_later_outlined,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.blue,
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    '${e.expireInDate} días',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.blue,
                                    ),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }
}

class Percent {
  final int total = 100;
  final int percent;

  Percent(this.percent);
}
