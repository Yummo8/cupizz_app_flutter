import 'package:cupizz_app/src/base/base.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CustomAnimatedList extends StatefulWidget {
  const CustomAnimatedList(
      {Key? key,
      required this.items,
      this.physics,
      this.shrinkWrap = false,
      this.onHided,
      this.onDeleted,
      this.confirmHide,
      this.confirmDelete,
      this.enableSlidable = true})
      : super(key: key);

  final List<Widget> items;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final bool enableSlidable;

  final Function(int index)? onHided;
  final Function(int index)? onDeleted;
  final Future<bool> Function(int index)? confirmHide;
  final Future<bool> Function(int index)? confirmDelete;

  @override
  CustomAnimatedListState createState() => CustomAnimatedListState();
}

class CustomAnimatedListState extends State<CustomAnimatedList> {
  List<Widget> _items = [];
  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();
  final SlidableController _slidableController = SlidableController();

  @override
  void initState() {
    super.initState();
    _items = widget.items;
  }

  void onHided(int index) {
    _slidableController.activeState!.close();
    removeItem(index).then((value) => widget.onHided?.call(index));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _items = widget.items;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _key,
      physics: widget.physics,
      shrinkWrap: widget.shrinkWrap,
      initialItemCount: _items.length,
      itemBuilder: (context, index, animation) =>
          _buildItem(_items[index], index, animation),
    );
  }

  Widget _buildItem(e, index, animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: Slidable(
        enabled: widget.enableSlidable,
        key: Key(index.toString()),
        controller: _slidableController,
        direction: Axis.horizontal,
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.3,
        closeOnScroll: true,
        secondaryActions: <Widget>[
          SlideAction(
            onTap: () {
              if (widget.confirmHide != null) {
                widget.confirmHide!(index).then((value) {
                  if (value) {
                    onHided(index);
                  }
                });
              } else {
                onHided(index);
              }
            },
            color: context.colorScheme.error,
            closeOnTap: false,
            child: Text(
              Strings.button.hideConversation,
              textAlign: TextAlign.center,
              style: context.textTheme.button!.copyWith(
                color: context.colorScheme.onError,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
        child: e,
      ),
    );
  }

  void changeItem() {
    setState(() {
      _items = widget.items;
    });
  }

  Future removeItem(int index, {int num = 0}) async {
    final e = _items.removeAt(index);
    final duration = Duration(milliseconds: 500);
    _key.currentState!.removeItem(index, (context, animation) {
      return _buildItem(e, index + num, animation);
    }, duration: duration);

    await Future.delayed(duration);
  }
}
