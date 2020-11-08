import 'package:cupizz_app/src/base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'widgets/row_edit_info.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _bioController = TextEditingController();
  int bioLenght;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bioController.addListener(_onBioChanged);
  }

  @override
  void dispose() {
    _bioController.dispose();
    super.dispose();
  }

  void _onBioChanged() {
    print(_bioController.text.length.toString());
    if (!(_bioController.text.length == 0 && this.bioLenght == null)) {
      setState(() {
        this.bioLenght = _bioController.text.length;
      });
    }
  }

  Widget buildWrapperRowEditInfo(
      String title, List<Widget> listWidgetItems, SizeHelper sizeHelper) {
    List<Widget> children = new List<Widget>();
    children.add(Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: sizeHelper.rW(6),
      ),
    ));
    children.add(SizedBox(
      height: 10.0,
    ));
    for (var widget in listWidgetItems) {
      children.add(widget);
      children.add(SizedBox(
        height: sizeHelper.rW(4),
      ));
    }
    children.add(Divider(
      thickness: 1.0,
      indent: 0,
      endIndent: 0,
      height: 30.0,
      color: Colors.black12,
    ));
    children.add(SizedBox(
      height: 10.0,
    ));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  Widget buildBasicInfo(SizeHelper sizeHelper) {
    List<Widget> listWidgetItems = new List<Widget>();

    listWidgetItems.add(RowEditInfo(
      iconData: Icons.account_circle_outlined,
      title: "Tên",
      value: "Thăng",
    ));

    listWidgetItems.add(RowEditInfo(
      iconData: Icons.account_circle_outlined,
      title: "Độ tuổi",
      value: "22",
    ));

    listWidgetItems.add(RowEditInfo(
      iconData: Icons.account_circle_outlined,
      title: "Vị trí hẹn hò",
      value: "22",
    ));

    listWidgetItems.add(RowEditInfo(
      iconData: Icons.account_circle_outlined,
      title: "Giới tính",
      value: "Nam",
    ));

    listWidgetItems.add(RowEditInfo(
      iconData: Icons.account_circle_outlined,
      title: "Đang tìm kiếm",
      value: "-",
    ));

    listWidgetItems.add(RowEditInfo(
      iconData: Icons.account_circle_outlined,
      title: "Chiều cao",
      value: "-",
    ));

    listWidgetItems.add(RowEditInfo(
      iconData: Icons.account_circle_outlined,
      title: "Quê quán",
      value: "Bến Cát, Bình Dương, Viet Nam",
    ));

    return buildWrapperRowEditInfo(
        "Thông tin cơ bản của bạn", listWidgetItems, sizeHelper);
  }

  Widget buildJobAndEducation(SizeHelper sizeHelper) {
    List<Widget> listWidgetItems = new List<Widget>();

    listWidgetItems.add(RowEditInfo(
      iconData: Icons.account_circle_outlined,
      title: "Chức danh",
      value: "-",
    ));

    listWidgetItems.add(RowEditInfo(
      iconData: Icons.account_circle_outlined,
      title: "Công ty",
      value: "-",
    ));

    listWidgetItems.add(RowEditInfo(
      iconData: Icons.account_circle_outlined,
      title: "Trường trung học",
      value: "-",
    ));

    listWidgetItems.add(RowEditInfo(
      iconData: Icons.account_circle_outlined,
      title: "Trường đại học cao/cao đẳng",
      value: "-",
    ));

    listWidgetItems.add(RowEditInfo(
      iconData: Icons.account_circle_outlined,
      title: "Trường cao học",
      value: "-",
    ));

    listWidgetItems.add(RowEditInfo(
      iconData: Icons.account_circle_outlined,
      title: "Trình độ học vấn",
      value: "-",
    ));
    return buildWrapperRowEditInfo(
        "Công việc và học vấn của bạn", listWidgetItems, sizeHelper);
  }

  Widget buildLifeStyle(SizeHelper sizeHelper) {
    List<Widget> listWidgetItems = new List<Widget>();
    listWidgetItems.add(RowEditInfo(
      iconData: Icons.account_circle_outlined,
      title: "Con bạn",
      value: "Chưa có con",
    ));

    listWidgetItems.add(RowEditInfo(
      iconData: Icons.account_circle_outlined,
      title: "Hút thuốc",
      value: "Thỉnh thoảng",
    ));

    listWidgetItems.add(RowEditInfo(
      iconData: Icons.account_circle_outlined,
      title: "Uống rượu",
      value: "Thỉnh thoảng",
    ));
    return buildWrapperRowEditInfo(
        "Lối sống của bạn", listWidgetItems, sizeHelper);
  }

  Widget buildReligion(SizeHelper sizeHelper) {
    List<Widget> listWidgetItems = new List<Widget>();
    listWidgetItems.add(RowEditInfo(
      iconData: Icons.account_circle_outlined,
      title: "Quan điểm tôn giáo",
      value: "khác",
    ));

    return buildWrapperRowEditInfo(
        "Lối sống của bạn", listWidgetItems, sizeHelper);
  }

  Widget buildFavorites(SizeHelper sizeHelper) {
    List<Widget> listWidgetItems = new List<Widget>();
    listWidgetItems.add(InkWell(
      onTap: () {},
      child: Container(
        width: sizeHelper.rW(45),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          color: Colors.grey[300],
        ),
        child: Padding(
          padding: EdgeInsets.all(sizeHelper.rW(2)),
          child: Row(
            children: [
              Icon(
                Icons.search,
                size: sizeHelper.rW(6.0),
              ),
              SizedBox(
                height: sizeHelper.rW(3),
              ),
              Text(
                "Thêm sở thích",
                style: TextStyle(
                  fontSize: sizeHelper.rW(5.0),
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
      ),
    ));

    return buildWrapperRowEditInfo(
        "Sở thích của bạn", listWidgetItems, sizeHelper);
  }

  @override
  Widget build(BuildContext context) {
    SizeHelper sizeHelper = new SizeHelper(context);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chỉnh sửa hồ sơ hẹn hò",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {/* Write listener code here */},
          child: Icon(
            Icons.arrow_back,
            color: Colors.black, // add custom icons also
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Giới thiệu bản thân",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: sizeHelper.rW(6),
                    ),
                  ),
                  SizedBox(
                    height: sizeHelper.rW(2),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: sizeHelper.rW(0.5)),
                    child: TextFormField(
                      controller: _bioController,
                      // autovalidate: true,
                      autocorrect: false,
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 5,
                      style: TextStyle(
                        fontSize: sizeHelper.rW(5),
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText:
                              "Hãy mô tả bản thân bạn bằng vài từ hoặc câu...",
                          hintStyle: TextStyle(
                              color: Colors.black45,
                              fontSize: sizeHelper.rW(5))),
                    ),
                  ),
                  if (this.bioLenght != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("$bioLenght/500",
                            style: TextStyle(
                                fontSize: sizeHelper.rW(5),
                                color: Colors.black54)),
                        InkWell(
                          onTap: () => {},
                          child: Text(
                            "Lưu",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.purpleAccent,
                              fontSize: sizeHelper.rW(5),
                            ),
                          ),
                        )
                      ],
                    ),
                ],
              ),
              Divider(
                thickness: 1.0,
                indent: 0,
                endIndent: 0,
                height: 10.0,
                color: Colors.black12,
              ),
              SizedBox(
                height: 10.0,
              ),
              buildBasicInfo(sizeHelper),
              buildJobAndEducation(sizeHelper),
              buildLifeStyle(sizeHelper),
              buildReligion(sizeHelper),
              buildFavorites(sizeHelper)
            ],
          ),
        ),
      ),
    );
  }
}
