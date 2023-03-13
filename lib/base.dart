import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BaseViewModel<T extends BaseNavigetor> extends ChangeNotifier {
  late T navigetor;
}

abstract class BaseNavigetor {
  void showMassage(String masssage);

  void showLoading({bool IsDissmassable});

  void hidMassage();
}

abstract class BaseState<T extends StatefulWidget, VM extends BaseViewModel>
    extends State<T> implements BaseNavigetor {
  late VM viewModel;

  VM initViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel = initViewModel();
  }

  @override
  void hidMassage() {
    Navigator.pop(context);
  }

  @override
  void showLoading({bool IsDissmassable = true}) {
    showDialog(
        barrierDismissible: IsDissmassable,
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
  }

  @override
  void showMassage(s, {String? actionName, VoidCallback? voidCallback}) {
    List<Widget> actions = [];
    if (actionName != null) {
      actions.add(TextButton(
        onPressed: voidCallback,
        child: Text(actionName),
      ));
    }

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: actions,
            content: Text(s),
          );
        });
  }
}
