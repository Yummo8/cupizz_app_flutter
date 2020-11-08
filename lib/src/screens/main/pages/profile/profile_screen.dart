import 'package:flutter/material.dart';

import 'widgets/cart_image.dart';
import 'widgets/row_info.dart';
import 'widgets/stack_container.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StackContainer(),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Alexander Daddario,",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          "34 tuổi",
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    RowInfo(
                      iconData: Icons.add_location,
                      semanticLabel: "",
                      title: "Đang ở Thành phố Hồ Chí Minh",
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    RowInfo(
                      iconData: Icons.local_atm,
                      semanticLabel: "",
                      title:
                          "Đang ở tìm mối quan hệ lâu dài, kiểu hẹn hò không ràng buộc",
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    RowInfo(
                      iconData: Icons.local_atm,
                      semanticLabel: "",
                      title: "160 cm",
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    RowInfo(
                      iconData: Icons.local_atm,
                      semanticLabel: "",
                      title: "LÀM VIỆC TẠI CTY TNHH Freetrend",
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    RowInfo(
                      iconData: Icons.local_atm,
                      semanticLabel: "",
                      title: "Quê quán Long Xuyên",
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    RowInfo(
                      iconData: Icons.local_atm,
                      semanticLabel: "",
                      title: "Chưa có con",
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    RowInfo(
                      iconData: Icons.local_atm,
                      semanticLabel: "",
                      title: "Phật giáo",
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    RowInfo(
                      iconData: Icons.public,
                      semanticLabel: "",
                      title: "Tiếng việt",
                    ),
                    Divider(
                      color: Colors.pink[300],
                      height: 20,
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => CartImage(
                        imageUrl:
                            "https://64.media.tumblr.com/1a818212c49bc873a5cb8a687382122e/tumblr_pwnyyjtQ6M1w89qpgo1_1280.jpg",
                      ),
                      shrinkWrap: true,
                      itemCount: 6,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
