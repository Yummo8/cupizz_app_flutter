library post_page;

import 'package:cupizz_app/src/base/base.dart';
import 'package:cupizz_app/src/constants/values.dart';
import 'package:cupizz_app/src/screens/main/pages/post/components/post_page.controller.dart';
import 'package:cupizz_app/src/screens/main/pages/post/widgets/action_icon.dart';
import 'package:cupizz_app/src/screens/main/pages/post/widgets/spaces.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'components/post_page.model.dart';

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
      body: MomentumBuilder(
          controllers: [PostPageController],
          builder: (context, snapshot) {
            final model = snapshot<PostPageModel>();
            return RefreshIndicator(
              onRefresh: model.controller.refresh,
              child: CustomScrollView(
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
                  if (model.isLoading)
                    SliverList(
                        delegate: SliverChildBuilderDelegate(
                      (context, index) => PostCard(),
                      childCount: 3,
                    ))
                  else
                    SliverList(
                        delegate: SliverChildBuilderDelegate(
                      (context, index) => FadeIn(
                        delay: (100 * (index + 1)).milliseconds,
                        child: PostCard(
                          post: model.posts.getAt(index),
                        ),
                      ),
                      childCount: model.posts?.length ?? 0,
                    ))
                ],
              ),
            );
          }),
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
        shadowColor: context.colorScheme.onBackground,
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
                  color: context.colorScheme.onSurface,
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
      child: MomentumBuilder(
          controllers: [SystemController, PostPageController],
          builder: (context, snapshot) {
            final systemModel = snapshot<SystemModel>();
            final model = snapshot<PostPageModel>();
            if (!systemModel.postCategories.isExistAndNotEmpty) {
              systemModel.controller.getPostCategories();
            }
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              physics: BouncingScrollPhysics(),
              child: Row(
                children: [
                  PostCategory(value: 'Tất cả'),
                  ...(systemModel.postCategories ?? [])
                ]
                    ?.mapIndexed((e, i) => _buildItem(
                        context, e, i, model.selectedCategory?.id == e?.id))
                    ?.toList(),
              ),
            );
          }),
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
                border: Border.all(color: color),
                color: color.withOpacity(isSelected ? 0.2 : 0.0)),
            child: InkWell(
              onTap: () {
                Momentum.controller<PostPageController>(context)
                    .selectCategory(data);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text(
                  data.value,
                  style: context.textTheme.bodyText1.copyWith(color: color),
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
