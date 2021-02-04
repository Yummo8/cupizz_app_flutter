library post_page;

import 'package:cupizz_app/src/base/base.dart';
import 'package:cupizz_app/src/constants/values.dart';
import 'package:cupizz_app/src/screens/main/pages/post/widgets/action_icon.dart';
import 'package:cupizz_app/src/screens/main/pages/post/widgets/spaces.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';

part 'widgets/post_cart.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar(
            title: _SearchBox(),
            floating: true,
            backgroundColor: context.colorScheme.background,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: ListCategories(),
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, index) => PostCard(),
            childCount: 6,
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.pink50,
        onPressed: () {},
        child: Icon(
          Icons.add,
          color: AppColors.white,
        ),
      ),
    );
  }
}

class _SearchBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        elevation: 5,
        color: context.colorScheme.background,
        child: InkWell(
          onTap: () {},
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: null,
              ),
              const SizedBox(width: 4),
              Text(
                'Tìm kiếm bài viết',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ));
  }
}

class ListCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          physics: BouncingScrollPhysics(),
          child: Row(
            children: List.generate(
              6,
              (index) => _buildItem(
                  context,
                  PostCategory(id: index.toString(), value: 'Category $index'),
                  index),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, PostCategory data, int index,
      [bool isSelected = false]) {
    final color = data.color != context.colorScheme.background
        ? data.color
        : context.colorScheme.onBackground;
    return data.value.isExistAndNotEmpty
        ? Container(
            margin: EdgeInsets.only(left: index != 0 ? 10 : 0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(90),
                border: Border.all(color: context.colorScheme.onBackground),
                color: color.withOpacity(isSelected ? 0.5 : 0.1)),
            child: InkWell(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text(
                  data.value,
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
