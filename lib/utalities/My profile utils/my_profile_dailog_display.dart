import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:social_media_app/constant/colorclass.dart';
import 'package:social_media_app/constant/string_constant.dart';
import 'package:social_media_app/utalities/PostUtiles/Text_post_display.dart';
import 'package:social_media_app/utalities/PostUtiles/image_post_display.dart';
 MyProfileDailogDisplay({required Map<String,dynamic>List}){

  return Get.defaultDialog(
    backgroundColor: MyColors.bgPallet,
    title: MyText.appName,
    content: List["type"]=="text"
              ?TextPostDisplay(post: List,delete: true,)
              : ImagePostDisplay(post: List,delete: true,)
            
  );

 }