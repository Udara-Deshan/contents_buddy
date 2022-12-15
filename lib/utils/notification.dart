import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter/material.dart';


 onToastSave(String msg, BuildContext context) async {
  showToast(msg,
    context: context,
    textStyle: TextStyle(fontSize: 20.0, color: Colors.white),
    backgroundColor: Colors.greenAccent,
    position: StyledToastPosition.center,
  );
}

  onToastDelete(String msg, BuildContext context) {
    showToast(msg,
      context: context,
      textStyle: TextStyle(fontSize: 20.0, color: Colors.white),
      backgroundColor: Colors.redAccent,
      position: StyledToastPosition.center,
    );
  }

onToastUpdate(String msg, BuildContext context){
  showToast(msg,
    context: context,
    textStyle: TextStyle(fontSize: 20.0, color: Colors.white),
    backgroundColor: Colors.grey,
    position: StyledToastPosition.center,
  );
}
