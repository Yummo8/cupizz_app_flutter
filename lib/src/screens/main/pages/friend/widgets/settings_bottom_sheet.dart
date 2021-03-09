part of '../friend_page.dart';

class SettingsBottomSheet {
  final BuildContext context;

  SettingsBottomSheet(this.context);

  void show() async {
    return await showSlidingBottomSheet(context, builder: (context) {
      return SlidingSheetDialog(
        elevation: 8,
        cornerRadius: 16,
        snapSpec: const SnapSpec(
          snap: true,
          snappings: [1.0],
          positioning: SnapPositioning.relativeToAvailableSpace,
        ),
        builder: (context, state) {
          return MomentumBuilder(
              controllers: [FriendPageController],
              builder: (context, snapshot) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      _buildFilter(),
                      _buildSort(),
                    ],
                  ),
                );
              });
        },
      );
    });
  }

  Widget _buildFilter() {
    final controller = Momentum.controller<FriendPageController>(context);
    final model = controller.model!;
    return _buildItem(
      title: Strings.friendPage.filterTitle,
      body: CustomGridView(
        crossAxisSpacing: 10,
        crossAxisCount: 2,
        children: FriendQueryType.getAll()
            .asMap()
            .map((i, e) => MapEntry<int, Widget>(
                i,
                OptionButton(
                  title: e.displayValue,
                  isSelected: model.filter.rawValue == e.rawValue,
                  onPressed: () {
                    controller.updateSettings(filter: e);
                  },
                )))
            .values
            .toList(),
      ),
    );
  }

  Widget _buildSort() {
    final controller = Momentum.controller<FriendPageController>(context);
    final model = controller.model!;
    return _buildItem(
      title: Strings.friendPage.sortTitle,
      body: Row(
        children: FriendQueryOrderBy.getAll()
            .asMap()
            .map((i, e) => MapEntry(
                i,
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: i == 0 ? 0 : 10),
                    child: OptionButton(
                      title: e.displayValue,
                      isSelected: model.sort.rawValue == e.rawValue,
                      onPressed: () {
                        controller.updateSettings(sort: e);
                      },
                    ),
                  ),
                )))
            .values
            .toList(),
      ),
    );
  }

  Widget _buildItem({
    required String title,
    Widget? actions,
    Widget? body,
    bool showBottomSeparator = true,
  }) {
    return Column(
      children: [
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: context.textTheme.subtitle1!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            if (actions != null) actions
          ],
        ),
        if (body != null) ...[const SizedBox(height: 10), body],
        const SizedBox(height: 15),
        if (showBottomSeparator) Divider(color: Colors.grey[500])
      ],
    );
  }
}
