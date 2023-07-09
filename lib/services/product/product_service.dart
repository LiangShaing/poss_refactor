import 'package:mobile_poss_gp01/extension/string_extension.dart';

class ProductService {

  String getProductSizeAndLength(String usage, String length, String ringSize, String earringsType) {
    Map<String, String> map = {
      "E": earringsType,
      "R": "${"product.widgets.factory.circleNumber".tr} $ringSize",
      "F": "${"product.widgets.factory.circleNumber".tr} $ringSize",
      "K": "${"product.widgets.factory.size".tr} $length",
      "M": "${"product.widgets.factory.length".tr} $length",
      "N": "${"product.widgets.factory.length".tr} $length",
      "B": "${"product.widgets.factory.length".tr} $length",
      "U": "${"product.widgets.factory.length".tr} $length"
    };

    return map.containsKey(usage) ? map[usage]! : "";
  }
}
