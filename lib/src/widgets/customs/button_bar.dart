import 'package:cupizz_app/src/base/base.dart';

class ButtonBar extends StatelessWidget {
  final int selectedIndex;
  final List<String> items;

  const ButtonBar({Key key, this.selectedIndex = 0, @required this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !items.isExistAndNotEmpty
        ? const SizedBox.shrink()
        : Container(
            color: context.colorScheme.background,
            height: 45.0,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 15.0, bottom: 0.0),
            child: Row(
              children: items
                  .asMap()
                  .map((key, value) {
                    final child = Text(
                      value,
                      style: TextStyle(
                          color: key == selectedIndex
                              ? context.colorScheme.onPrimary
                              : Colors.grey),
                    );
                    if (key == selectedIndex) {
                      return MapEntry(
                          key,
                          Container(
                            width: 80.0,
                            height: 32.0,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: context.colorScheme.secondary
                                          .withOpacity(0.7),
                                      blurRadius: 4.0)
                                ],
                                color: context.colorScheme.secondary,
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Center(
                              child: child,
                            ),
                          ));
                    } else {
                      return MapEntry(key, child);
                    }
                  })
                  .values
                  .toList(),
            ),
          );
  }
}
