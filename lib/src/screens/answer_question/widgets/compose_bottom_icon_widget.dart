part of '../answer_question_screen.dart';

class ComposeBottomIconWidget extends StatelessWidget {
  final Function(File) onImageIconSelected;
  final Function(ColorOfAnswer) onColorChanged; // TODO handle color change

  ComposeBottomIconWidget(
      {Key key, this.onImageIconSelected, this.onColorChanged})
      : super(key: key);

  Widget _bottomIconWidget(BuildContext context) {
    return Container(
      width: context.width,
      height: 50,
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Theme.of(context).dividerColor)),
        color: context.colorScheme.background.withOpacity(0.2),
      ),
      child: MomentumBuilder(
          controllers: [AnswerQuestionScreenController],
          builder: (context, snapshot) {
            final model = snapshot<AnswerQuestionScreenModel>();
            return Row(
              children: <Widget>[
                IconButton(
                  onPressed: () => _pickImage(context),
                  icon: Icon(
                    Icons.image,
                    color: context.colorScheme.primary,
                  ),
                ),
                if (model.colors.isExistAndNotEmpty)
                  ...model.colors
                      .map(
                        (e) => CupertinoButton(
                          padding: EdgeInsets.zero,
                          minSize: 0,
                          onPressed: () {
                            model.update(selectedColor: e);
                          },
                          child: Container(
                            width: 20,
                            height: 20,
                            margin: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: e.gradient != null ? null : e.color,
                              gradient: e.gradient != null
                                  ? AnswerGradient(e.gradient)
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
                        ),
                      )
                      .toList()
              ],
            );
          }),
    );
  }

  void _pickImage(BuildContext context) {
    pickImage(context, (images) {
      if (!images.isExistAndNotEmpty) return;

      onImageIconSelected?.call(images[0]);
    }, maxSelected: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _bottomIconWidget(context),
    );
  }
}
