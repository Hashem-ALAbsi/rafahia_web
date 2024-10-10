import 'package:flutter/material.dart';

import '../../uitles/colors.dart';
import '../../widget/flutter_toast.dart';

class ApiError {
  static void massegerror(int? statuscode, String? statusmessage) {
    if (statuscode == 400) {
      ShowMasseg.ShowToastMassegError("$statusmessage", LigthColor.delete);
    } else if (statuscode == 401) {
      ShowMasseg.ShowToastMassegError("$statusmessage", LigthColor.favorColor);
    } else if (statuscode == 403) {
      ShowMasseg.ShowToastMassegError("$statusmessage", LigthColor.favorColor);
    } else if (statuscode == 404) {
      ShowMasseg.ShowToastMassegError("$statusmessage", LigthColor.favorColor);
    } else if (statuscode == 500) {
      ShowMasseg.ShowToastMassegError(
          "لايوجد اتصال بالانترنت", LigthColor.favorColor);
    } else {
      ShowMasseg.ShowToastMassegError(
          "لايوجد اتصال بالانترنت", LigthColor.favorColor);
      //print(_stutes);
    }
  }
}
