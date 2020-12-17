part of '../index.dart';

class HiddenText extends StatefulWidget {
  final String text;
  final int maxLength;
  final TextOverflow overflow;
  final TextStyle style;
  final TextAlign textAlign;
  final String readmoreText;
  final Color readmoreColor;
  final int duration;

  const HiddenText(
    this.text, {
    Key key,
    this.maxLength = 200,
    this.overflow,
    this.style,
    this.textAlign,
    this.readmoreText = '[Xem thêm]',
    this.readmoreColor,
    this.duration = 100,
  }) : super(key: key);

  @override
  _HiddenTextState createState() => _HiddenTextState();
}

class _HiddenTextState extends State<HiddenText> with TickerProviderStateMixin {
  bool isShow = false;
  TextStyle textStyle;

  bool get isCollapsing => !(widget.maxLength >= widget.text.length || isShow);

  @override
  Widget build(BuildContext context) {
    textStyle = widget.style ?? context.textTheme.bodyText2;
    return AnimatedSize(
      vsync: this,
      duration: Duration(milliseconds: widget.duration),
      reverseDuration: Duration(microseconds: widget.duration),
      curve: Curves.ease,
      alignment: AlignmentDirectional.topCenter,
      child: GestureDetector(
        onTap: () {
          setState(() {
            isShow = !isShow;
          });
        },
        child: RichText(
          textAlign: widget.textAlign ?? TextAlign.left,
          text: TextSpan(style: textStyle, children: [
            TextSpan(
              text: widget.text
                      .substring(0, !isCollapsing ? null : widget.maxLength) +
                  (isCollapsing ? '...' : ''),
            ),
            if (isCollapsing)
              TextSpan(
                text: widget.readmoreText,
                style: TextStyle(color: widget.readmoreColor),
              ),
          ]),
        ),
      ),
    );
  }
}
