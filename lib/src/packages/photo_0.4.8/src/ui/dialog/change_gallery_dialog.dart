import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import '../../entity/options.dart';
import '../../provider/i18n_provider.dart';

class ChangeGalleryDialog extends StatefulWidget {
  const ChangeGalleryDialog({
    Key key,
    this.galleryList,
    this.i18n,
    this.options,
  }) : super(key: key);

  final List<AssetPathEntity> galleryList;
  final I18nProvider i18n;

  final Options options;

  @override
  _ChangeGalleryDialogState createState() => _ChangeGalleryDialogState();
}

class _ChangeGalleryDialogState extends State<ChangeGalleryDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: _buildItem,
        itemCount: widget.galleryList.length,
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    final entity = widget.galleryList[index];
    String text;

    if (entity.isAll) {
      text = widget.i18n?.getAllGalleryText(widget.options);
    }

    text = text ?? entity.name;

    return TextButton(
      onPressed: () {
        Navigator.pop(context, entity);
      },
      child: ListTile(
        title: Text('$text (${entity.assetCount})'),
      ),
    );
  }
}
