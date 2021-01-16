import 'package:flutter/material.dart';
import 'package:todo/features/micubacel/data/datasources/datasources.dart';

class MiCubacelInfo extends StatelessWidget {
  const MiCubacelInfo({
    Key key,
    @required this.client,
  }) : super(key: key);

  final CubacelClient client;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
              ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.blue,
                  ),
                  height: 64,
                  width: 57,
                  child: Icon(
                    Icons.account_circle,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                title: Text(client.userName),
                subtitle: Text(client.phone),
                trailing: Text('\$ ${client.credit}'),
              )
            ] +
            client.buys
                .map(
                  (e) => ListTile(
                    leading: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.blue,
                      ),
                      height: 64,
                      width: 57,
                      child: Icon(
                        Icons.data_usage,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    title: Text(e.title),
                    subtitle: Text(e.expireDate),
                    trailing: Text('${e.restData} ${e.dataInfo}'),
                  ),
                )
                .toList(),
      ),
    );
  }
}