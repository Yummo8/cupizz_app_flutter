import 'package:cupizz_app/src/helpers/index.dart';
import 'package:cupizz_app/src/screens/main/pages/profile/edit_profile_screen.dart';
import 'package:flutter/material.dart';

import 'widgets/cart_image.dart';
import 'widgets/row_info.dart';
import 'widgets/stack_container.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ScrollController scrollController = ScrollController();

  bool _isCollapse = false;

  bool get _isAppBarCollapsed {
    return scrollController.hasClients &&
        scrollController.offset > new SizeHelper(this.context).rH(45) - 100;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      if (_isAppBarCollapsed) {
        setState(() {
          _isCollapse = true;
        });
      } else {
        setState(() {
          _isCollapse = false;
        });
      }
    });
  }

  @override
  Widget build1(BuildContext context) {
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
                          "Alexandra Daddario,",
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
                      iconData: Icons.location_on_rounded,
                      semanticLabel: "",
                      title: "Đang ở Thành phố Hồ Chí Minh",
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    RowInfo(
                      iconData: Icons.favorite,
                      semanticLabel: "",
                      title:
                          "Đang ở tìm mối quan hệ lâu dài, kiểu hẹn hò không ràng buộc",
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    RowInfo(
                      iconData: Icons.height,
                      semanticLabel: "",
                      title: "160 cm",
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    RowInfo(
                      iconData: Icons.work,
                      semanticLabel: "",
                      title: "LÀM VIỆC TẠI CTY TNHH Freetrend",
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    RowInfo(
                      iconData: Icons.school,
                      semanticLabel: "",
                      title:
                          "Trường đại học Công nghệ Thông tin - Đại học Quốc gia TP.HCM, THPT Bến Cát, Bến Cát, Bình Dương",
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    RowInfo(
                      iconData: Icons.school,
                      semanticLabel: "",
                      title: "Bằng đại cao đẳng/đại học",
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    RowInfo(
                      iconData: Icons.house,
                      semanticLabel: "",
                      title: "Quê quán Long Xuyên",
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    RowInfo(
                      iconData: Icons.family_restroom,
                      semanticLabel: "",
                      title: "Chưa có con",
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    RowInfo(
                      iconData: Icons.smoking_rooms,
                      semanticLabel: "",
                      title: "Thỉnh thoảng",
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    RowInfo(
                      iconData: Icons.local_bar,
                      semanticLabel: "",
                      title: "Thỉnh thoảng",
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    RowInfo(
                      iconData: Icons.self_improvement,
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

  Widget build(BuildContext context) {
    SizeHelper sizeHelper = new SizeHelper(context);
    return Scaffold(
      body: NestedScrollView(
        controller: scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              expandedHeight: sizeHelper.rH(45),
              floating: false,
              pinned: true,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: _isCollapse
                    ? Text("Alexandra Daddario",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                        ))
                    : null,
                background: Container(
                  color: Colors.white,
                  child: StackContainer(),
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.black),
                  onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProfileScreen()))
                  },
                ),
              ],
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Alexandra Daddario,",
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
                  iconData: Icons.location_on_rounded,
                  semanticLabel: "",
                  title: "Đang ở Thành phố Hồ Chí Minh",
                ),
                SizedBox(
                  height: 16.0,
                ),
                RowInfo(
                  iconData: Icons.favorite,
                  semanticLabel: "",
                  title:
                      "Đang ở tìm mối quan hệ lâu dài, kiểu hẹn hò không ràng buộc",
                ),
                SizedBox(
                  height: 16.0,
                ),
                RowInfo(
                  iconData: Icons.height,
                  semanticLabel: "",
                  title: "160 cm",
                ),
                SizedBox(
                  height: 16.0,
                ),
                RowInfo(
                  iconData: Icons.work,
                  semanticLabel: "",
                  title: "LÀM VIỆC TẠI CTY TNHH Freetrend",
                ),
                SizedBox(
                  height: 16.0,
                ),
                RowInfo(
                  iconData: Icons.school,
                  semanticLabel: "",
                  title:
                      "Trường đại học Công nghệ Thông tin - Đại học Quốc gia TP.HCM, THPT Bến Cát, Bến Cát, Bình Dương",
                ),
                SizedBox(
                  height: 16.0,
                ),
                RowInfo(
                  iconData: Icons.school,
                  semanticLabel: "",
                  title: "Bằng đại cao đẳng/đại học",
                ),
                SizedBox(
                  height: 16.0,
                ),
                RowInfo(
                  iconData: Icons.house,
                  semanticLabel: "",
                  title: "Quê quán Long Xuyên",
                ),
                SizedBox(
                  height: 16.0,
                ),
                RowInfo(
                  iconData: Icons.family_restroom,
                  semanticLabel: "",
                  title: "Chưa có con",
                ),
                SizedBox(
                  height: 16.0,
                ),
                RowInfo(
                  iconData: Icons.smoking_rooms,
                  semanticLabel: "",
                  title: "Thỉnh thoảng",
                ),
                SizedBox(
                  height: 16.0,
                ),
                RowInfo(
                  iconData: Icons.local_bar,
                  semanticLabel: "",
                  title: "Thỉnh thoảng",
                ),
                SizedBox(
                  height: 16.0,
                ),
                RowInfo(
                  iconData: Icons.self_improvement,
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
