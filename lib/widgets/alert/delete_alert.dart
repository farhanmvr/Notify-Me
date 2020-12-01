import 'package:flutter/material.dart';

class DeleteAlert extends StatelessWidget {
  final Function onDelete;
  String title;
  String body;
  String nb;
  DeleteAlert({this.onDelete, this.body, this.nb, this.title});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 2),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.delete,
                        color: Theme.of(context).errorColor,
                      ),
                      SizedBox(width: 8),
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    body,
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'NB : ${nb}',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: 45,
                        child: FlatButton(
                          child: Text('No'),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15)),
                          ),
                          color: Colors.black,
                          textColor: Colors.white,
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 45,
                        child: FlatButton(
                          child: Text('Yes'),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(15)),
                          ),
                          color: Theme.of(context).errorColor,
                          textColor: Colors.white,
                          onPressed: () {
                            Navigator.of(context).pop(true);
                            onDelete(context);
                          },
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
