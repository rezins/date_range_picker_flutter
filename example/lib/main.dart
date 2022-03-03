import 'package:flutter/material.dart';
import 'package:z_date_range_picker/date_range_picker_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      restorationScopeId: 'app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page', restorationId: 'main'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title, this.restorationId}) : super(key: key);

  final String? title;
  final String? restorationId;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

/// https://api.flutter.dev/flutter/material/showDateRangePicker.html
class _MyHomePageState extends State<MyHomePage> {
  // with RestorationMixin
  @override
  String? get restorationId => widget.restorationId;
  // final RestorableDateTimeN _startDate = RestorableDateTimeN(DateTime(2021, 1, 1));
  // final RestorableDateTimeN _endDate = RestorableDateTimeN(DateTime(2021, 1, 5));
  // late final RestorableRouteFuture<DateTimeRange?> _restorableDateRangePickerRouteFuture = RestorableRouteFuture<DateTimeRange?>(
  //   onComplete: _selectDateRange,
  //   onPresent: (NavigatorState navigator, Object? arguments) {
  //     return navigator.restorablePush(_dateRangePickerRoute, arguments: <String, dynamic>{
  //       'initialStartDate': _startDate.value?.millisecondsSinceEpoch,
  //       'initialEndDate': _endDate.value?.millisecondsSinceEpoch,
  //     });
  //   },
  // );
  //
  // void _selectDateRange(DateTimeRange? newSelectedDate) {
  //   if (newSelectedDate != null) {
  //     setState(() {
  //       _startDate.value = newSelectedDate.start;
  //       _endDate.value = newSelectedDate.end;
  //     });
  //   }
  // }
  //
  // @override
  // void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
  //   registerForRestoration(_startDate, 'start_date');
  //   registerForRestoration(_endDate, 'end_date');
  //   registerForRestoration(_restorableDateRangePickerRouteFuture, 'date_picker_route_future');
  // }
  //
  // static Route<DateTimeRange?> _dateRangePickerRoute(
  //   BuildContext context,
  //   Object? arguments,
  // ) {
  //   return DialogRoute<DateTimeRange?>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return DateRangePickerDialog(
  //         restorationId: 'date_picker_dialog',
  //         initialDateRange: _initialDateTimeRange(arguments! as Map<dynamic, dynamic>),
  //         firstDate: DateTime(2021, 1, 1),
  //         currentDate: DateTime(2021, 1, 25),
  //         lastDate: DateTime(2022, 1, 1),
  //       );
  //     },
  //   );
  // }
  //
  // static DateTimeRange? _initialDateTimeRange(Map<dynamic, dynamic> arguments) {
  //   if (arguments['initialStartDate'] != null && arguments['initialEndDate'] != null) {
  //     return DateTimeRange(
  //       start: DateTime.fromMillisecondsSinceEpoch(arguments['initialStartDate'] as int),
  //       end: DateTime.fromMillisecondsSinceEpoch(arguments['initialEndDate'] as int),
  //     );
  //   }
  //
  //   return null;
  // }

  void showCustomRangePicker() async {
    var res = await showTCRDateRangePicker(
      context: context,
      selectRange: CustomDateTimeRange(),
      validRange:
          CustomDateTimeRange(start: DateTime(2022, 1), end: DateTime(2023, 7)),
    );
    if(res != null){
      print('res = ${res.start} => ${res.end}');
    }

  }

  void showSystemRangePicker() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? 'X'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
                onPressed: showCustomRangePicker,
                child: Text('show date range picker')),
            TextButton(
                onPressed: showCustomRangePicker,
                child: Text('show system date range picker')),
          ],
        ),
      ),
    );
  }
}
