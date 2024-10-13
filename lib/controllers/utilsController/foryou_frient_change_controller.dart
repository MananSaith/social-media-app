import 'package:get/get.dart';

class StateChangeController extends GetxController{

  RxBool change=true.obs;

  void ChangeFun(int x){
    if(x==1){
      change.value=true;
    }
    else{
      change.value=false;
    }
  }

}