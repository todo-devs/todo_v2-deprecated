import 'package:flutter/material.dart';

class FutureDecision extends StatefulWidget {
  final Future<bool> future;
  final Widget ifTrue;
  final Widget ifFalse;

  const FutureDecision({
    Key key,
    @required this.future,
    @required this.ifTrue,
    @required this.ifFalse,
  }) : super(key: key);

  @override
  _FutureDecisionState createState() => _FutureDecisionState();
}

class _FutureDecisionState extends State<FutureDecision> {
  var loading = true;
  var decision = false;

  @override
  void initState() {
    super.initState();
    runFuture();
  }

  Future<void> runFuture() async {
    var result = await widget.future;
    setState(() {
      loading = false;
      decision = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(child: CircularProgressIndicator())
        : decision
            ? widget.ifTrue
            : widget.ifFalse;
  }
}
