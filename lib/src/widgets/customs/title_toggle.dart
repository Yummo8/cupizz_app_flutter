import 'package:cupizz_app/src/base/base.dart';

class TitleToggle extends StatelessWidget {
  TitleToggle({
    @required this.title,
    this.description,
    this.divider = false,
    this.value = false,
    this.valueChanged,
    this.paddingAbove,
    this.paddingBelow,
    this.hasColorTitle = false,
  });

  final String title;
  final String description;
  final bool divider;
  final bool hasColorTitle;
  final ValueChanged valueChanged;
  final EdgeInsets paddingAbove;
  final EdgeInsets paddingBelow;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            Padding(
              padding: paddingAbove ?? EdgeInsets.zero,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      title,
                      style: context.textTheme.subtitle1.copyWith(
                        color: hasColorTitle
                            ? context.colorScheme.primary
                            : context.colorScheme.onBackground,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(10, 0),
                    child: Transform.scale(
                      scale: 0.55,
                      child: CupertinoSwitch(
                        value: value,
                        onChanged: (value) {
                          valueChanged(value);
                        },
                        activeColor: context.colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (description != null)
              Padding(
                padding: paddingBelow ?? EdgeInsets.zero,
                child: Text(
                  description,
                  style: context.textTheme.caption
                      .copyWith(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.left,
                ),
              ),
          ],
        ),
        if (divider) Divider()
      ],
    );
  }
}
