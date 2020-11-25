import 'package:cupizz_app/src/base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditPicturesScreen extends StatefulWidget {
  @override
  _EditPicturesScreenState createState() => _EditPicturesScreenState();
}

class _EditPicturesScreenState extends State<EditPicturesScreen> {
  bool isEdit;
  List<String> _list = new List<String>();
  List<String> alphabetList = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J'
  ];
  @override
  void initState() {
    super.initState();
    isEdit = false;
    for (var i = 0; i < 5; i++) {
      _list.add(
          "https://64.media.tumblr.com/1a818212c49bc873a5cb8a687382122e/tumblr_pwnyyjtQ6M1w89qpgo1_1280.jpg");
    }
  }

  Widget _buildListTile(BuildContext context, int key, String imageUrl) {
    SizeHelper sizeHelper = SizeHelper(context);
    return Row(
      key: Key(key.toString()),
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(Icons.menu),
        Container(
          width: sizeHelper.rW(70),
          margin: EdgeInsets.only(top: 4.0, bottom: 10.0),
          height: 300.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
        ),
        Icon(Icons.delete)
      ],
    );
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(
      () {
        if (newIndex > oldIndex) {
          newIndex -= 1;
        }
        final String item = alphabetList.removeAt(oldIndex);
        alphabetList.insert(newIndex, item);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeHelper sizeHelper = SizeHelper(context);
    final ThemeData _theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Ảnh',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => {Navigator.pop(context)},
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: Center(
              child: Text(
                "Lưu",
                style: TextStyle(
                    color: isEdit ? _theme.primaryColor : Colors.black87,
                    fontSize: 18.0),
              ),
            ),
          ),
          SizedBox(
            width: sizeHelper.rW(8),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(sizeHelper.rW(3)),
        child: Column(
          children: [
            SizedBox(
              height: sizeHelper.rW(5),
            ),
            Text(
              "Kéo rồi thả ảnh để thay đổi thứ tự trên hồ sơ của bạn",
              style: TextStyle(color: Colors.black54, fontSize: 18.0),
            ),
            SizedBox(
              height: sizeHelper.rW(5),
            ),
            // Expanded(
            //   child: ReorderableListView(
            //     children: _list
            //         .mapIndexed((String item, int index) =>
            //             _buildListTile(context, index, item))
            //         .toList(),
            //     onReorder: (int draggingIndex, int newPositionIndex) {
            //       //GUARD HERE
            //       if (newPositionIndex == -1 || draggingIndex == -1)
            //         return false;

            //       final item = _list[draggingIndex];
            //       setState(() {
            //         _list.removeAt(draggingIndex);
            //         _list.insert(newPositionIndex, item);
            //       });
            //       return true;
            //     },
            //   ),
            // ),
            Expanded(
              child: ReorderableListView(
                onReorder: _onReorder,
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                children: List.generate(
                  _list.length,
                  (index) {
                    return _buildListTile(context, index, _list[index]);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
