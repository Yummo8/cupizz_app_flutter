import 'package:cupizz_app/src/base/base.dart';
import 'package:flutter/foundation.dart';

import 'widgets/create_post_widgets.dart';

class CreatePostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: HeroKeys.createPost,
      child: PrimaryScaffold(
        appBar: BackAppBar(
          titleWidget: _CategoriesDropDown(),
          actions: [_SubmitButton()],
          elevation: 0,
          centerTitle: false,
          backIcon: Icons.close,
        ),
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    _CreatePostBody(textFieldPlaceholder: 'Nhập nội dung'),
                    const SizedBox(height: 20),
                    Flexible(
                      child: MomentumBuilder(
                          controllers: [CreatePostController],
                          builder: (context, snapshot) {
                            final model = snapshot<CreatePostModel>()!;
                            return CreatePostImageList(
                              images: model.images,
                              onRemovedImage: (image) {
                                model.controller.deleteImage(image);
                              },
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ComposeBottomIconWidget(
                onImageIconSelected: (images) {
                  if (images != null) {
                    Momentum.controller<CreatePostController>(context)
                        .pickImages(images
                            .filter((e) => e != null)
                            .map((e) => e!)
                            .toList());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
        controllers: [CreatePostController],
        builder: (context, snapshot) {
          final model = snapshot<CreatePostModel>()!;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            child: ArgonButton(
              height: 20,
              width: 80,
              loader: LoadingIndicator(size: 20),
              onTap: (startLoading, stopLoading, btnState) async {
                startLoading();
                try {
                  await model.controller.createPost();
                  Get.back();
                } finally {
                  stopLoading();
                }
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: model.selected != null &&
                          model.content!.isExistAndNotEmpty
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColor.withAlpha(150),
                  borderRadius: BorderRadius.circular(90),
                ),
                child: Text(
                  'Đăng',
                  style: context.textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary),
                ),
              ),
            ),
          );
        });
  }
}

class _CategoriesDropDown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
        controllers: [CreatePostController, SystemController],
        builder: (context, snapshot) {
          final categories = snapshot<SystemModel>()!.postCategories ?? [];
          final model = snapshot<CreatePostModel>()!;

          return DropdownButton<PostCategory>(
            value: model.selected,
            icon: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Icon(CupertinoIcons.chevron_down),
            ),
            iconSize: 12,
            elevation: 16,
            underline: const SizedBox.shrink(),
            style: TextStyle(color: Colors.deepPurple),
            hint: Text('Chọn danh mục',
                style: context.textTheme.bodyText1!.copyWith(
                  color: context.colorScheme.onSurface,
                )),
            onChanged: (category) {
              model.controller.selectCategory(category);
            },
            items: categories
                .map<DropdownMenuItem<PostCategory>>((PostCategory value) {
              return DropdownMenuItem<PostCategory>(
                value: value,
                child: Text(
                  value.value,
                  style: context.textTheme.bodyText1!
                      .copyWith(color: value.color, shadows: [
                    Shadow(
                      blurRadius: 2,
                      color: Colors.black,
                    ),
                  ]),
                ),
              );
            }).toList(),
          );
        });
  }
}

class _CreatePostBody extends StatelessWidget {
  const _CreatePostBody({
    Key? key,
    this.textFieldPlaceholder = '',
  }) : super(key: key);

  final String textFieldPlaceholder;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Padding(
        //   padding: const EdgeInsets.only(top: 5),
        //   child: UserAvatar(size: 40),
        // ),
        const SizedBox(width: 10),
        Expanded(
          child: _TextField(
            placeholder: textFieldPlaceholder,
          ),
        )
      ],
    );
  }
}

class _TextField extends StatelessWidget {
  const _TextField({
    Key? key,
    this.textEditingController,
    this.placeholder = '',
  }) : super(key: key);

  final TextEditingController? textEditingController;
  final String placeholder;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MomentumBuilder(
            controllers: [CreatePostController],
            builder: (context, snapshot) {
              final model = snapshot<CreatePostModel>()!;
              return TextFormField(
                initialValue: model.content,
                maxLines: null,
                onChanged: (v) {
                  model.controller.onChangedContent(v);
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: placeholder,
                  hintStyle: TextStyle(fontSize: 18),
                ),
              );
            }),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('placeholder', placeholder));
  }
}
