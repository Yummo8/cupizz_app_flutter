part of 'screen_widget.dart';

class ComposeBottomIconWidget extends StatelessWidget {
  final Function(File? file)? onImageIconSelected;
  final Function(ColorOfAnswer color)? onColorChanged;
  final Function? onDeletePressed;

  ComposeBottomIconWidget(
      {Key? key,
      this.onImageIconSelected,
      this.onColorChanged,
      this.onDeletePressed})
      : super(key: key);

  Widget _bottomIconWidget(BuildContext context) {
    return Container(
      width: context.width,
      height: 50,
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Theme.of(context).dividerColor)),
        color: context.colorScheme.background.withOpacity(0.2),
      ),
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed: () => _pickImage(context),
            icon: Icon(
              CupertinoIcons.photo_on_rectangle,
              color: context.colorScheme.primary,
            ),
          ),
          MomentumBuilder(
              controllers: [SystemController],
              builder: (context, snapshot) {
                final model = snapshot<SystemModel>()!;
                return Row(
                  children: (model.colorsOfAnswer ?? [])
                      .map<Widget>((e) => CupertinoButton(
                            padding: EdgeInsets.zero,
                            minSize: 0,
                            onPressed: () {
                              onColorChanged?.call(e);
                            },
                            child: Container(
                              width: 20,
                              height: 20,
                              margin: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: e.gradient != null ? null : e.color,
                                gradient: e.gradient != null
                                    ? AnswerGradient(e.gradient!)
                                    : null,
                              ),
                              child: Center(
                                child: Container(
                                  width: 7,
                                  height: 7,
                                  decoration: BoxDecoration(
                                    color: e.textColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                );
              }),
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: onDeletePressed as void Function()?,
            icon: Icon(
              Icons.close,
              color: context.colorScheme.onBackground,
            ),
          ),
        ],
      ),
    );
  }

  void _pickImage(BuildContext context) {
    pickImage(context, (images) {
      if (!images.isExistAndNotEmpty) return;

      onImageIconSelected?.call(images![0]);
    }, maxSelected: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _bottomIconWidget(context),
    );
  }
}
