## date_range_picker_flutter
This package originally from z_date_range_picker and also modified some widget and language.
Enjoy!.

Shows a full screen modal dialog containing a Material Design date range picker.

## how to use

```
void showCustomRangePicker() async {
    var res = await showTCRDateRangePicker(
      context: context,
      selectRange: CustomDateTimeRange(),
      validRange: CustomDateTimeRange(start: DateTime(2021, 1), end: DateTime(2022, 7)),
    );
    print('res = $res');
  }
```
## Images

<img src="https://raw.githubusercontent.com/rezins/date_range_picker_flutter/main/example/asset/example.png" alt="test receipt" height="484" width="863"/>


