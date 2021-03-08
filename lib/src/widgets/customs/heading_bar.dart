import 'package:cupizz_app/src/base/base.dart';

class HeadingBar extends StatelessWidget {
  final String title;
  final int? badge;

  const HeadingBar({Key? key, required this.title, this.badge})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65.0,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 15.0, bottom: 20.0, top: 10),
      color: context.colorScheme.background,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: context.textTheme.headline4!.copyWith(
              color: context.colorScheme.onBackground,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (badge != null) _buildBadge(context, badge)
        ],
      ),
    );
  }

  Widget _buildBadge(BuildContext context, int? length) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      width: 20,
      height: 20,
      child: Center(
        child: Text(
          length.toString(),
          style: TextStyle(color: context.colorScheme.onPrimary, fontSize: 11),
        ),
      ),
    );
  }
}
