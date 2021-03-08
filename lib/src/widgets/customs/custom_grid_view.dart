import 'package:cupizz_app/src/base/base.dart';

class CustomGridView extends StatelessWidget {
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final int crossAxisCount;
  final List<Widget> children;

  const CustomGridView(
      {Key key,
      this.crossAxisSpacing = 0,
      this.mainAxisSpacing = 0,
      this.crossAxisCount,
      this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];

    for (var i = 0; i < children.length / crossAxisCount; i++) {
      final endIndex = i * crossAxisCount + crossAxisCount;
      final items = children.sublist(
          i * crossAxisCount, endIndex > children.length ? null : endIndex);

      if (items.length < crossAxisCount) {
        items.addAll(
          List.generate(
            crossAxisCount - items.length,
            (i) => const SizedBox.shrink(),
          ),
        );
      }

      rows.add(IntrinsicHeight(
        child: Row(
          children: items
              .asMap()
              .map((i, e) => MapEntry<int, Widget>(
                  i,
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: i == 0 ? 0 : crossAxisSpacing),
                      child: e,
                    ),
                  )))
              .values
              .toList(),
        ),
      ));
    }

    return Column(
      children: rows
          .asMap()
          .map((i, e) => MapEntry(
              i,
              Padding(
                padding: EdgeInsets.only(top: i == 0 ? 0 : mainAxisSpacing),
                child: e,
              )))
          .values
          .toList(),
    );
  }
}
