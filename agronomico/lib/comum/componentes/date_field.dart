import 'package:flutter/material.dart';
import 'package:simple_moment/simple_moment.dart';

class DateField extends StatefulWidget {
  final Function callback;
  final DateTime selectedDate;
  final String label;

  DateField({
    @required this.callback,
    @required this.selectedDate,
    @required this.label,
  });

  @override
  _DateFieldState createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: widget.selectedDate ?? DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));
    if (picked != null && picked != widget.selectedDate)
      widget.callback(picked);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey))),
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 8.0,
                      top: 14,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          widget.selectedDate == null
                              ? 'Selecione uma data'
                              : Moment.fromDate(widget.selectedDate)
                                  .format('dd/MM/yyyy'),
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.today, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 8,
              left: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  widget.label ?? '',
                  style: TextStyle(
                      fontSize: 12, color: Theme.of(context).primaryColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
