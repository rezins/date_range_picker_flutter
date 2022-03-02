/// 需要先调用： XFlexible.registerWidth(MediaQuery.of(context).size.width);
/// 然后使用 20.w设置
import 'flexible.dart';

class PickerFlexible {
  static registerBaseWidth(double width) {
    XFlexible.registerBaseWidth(width);
  }
}
