import 'package:intl/intl.dart';

final numberFormat = NumberFormat('###,###');

String priceFormat(int? price) {
  if (price.toString().length <= 4) {
    return "${numberFormat.format(price)}원";
  } else if (price.toString().length <= 8) {
    return "${numberFormat.format(int.parse(price.toString().substring(0, price.toString().length - 4)))}만원";
  } else {
    if (price.toString().substring(
            price.toString().length - 8, price.toString().length - 4) ==
        "0000") {
      return "${numberFormat.format(int.parse(price.toString().substring(0, price.toString().length - 8)))}억원";
    }
    return "${numberFormat.format(int.parse(price.toString().substring(0, price.toString().length - 8)))}억 ${numberFormat.format(int.parse(price.toString().substring(price.toString().length - 8, price.toString().length - 4)))}만원";
  }
}

String serialFormat(String number) {
  if (number.length < 3) return number;
  String frontNumber = number.substring(0, 3);
  String backNumber = "";
  int i = 0;
  while (i < number.length - 3) {
    backNumber += "*";
    i++;
  }
  String newNumber = frontNumber + backNumber;
  return newNumber;
}
