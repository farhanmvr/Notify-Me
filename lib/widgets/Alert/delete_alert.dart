import 'package:flutter/material.dart';

class DeleteAlert extends StatelessWidget {
  final Function onDelete;
  DeleteAlert(this.onDelete);
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
                        'DELETE SUBJECT',
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
                    'Are you sure want to delete this subject ?',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'NB : This won\'t be able to retrieve once you delete this subject',
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
                            Navigator.of(context).pop();
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
