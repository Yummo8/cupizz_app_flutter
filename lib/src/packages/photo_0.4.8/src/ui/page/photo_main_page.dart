import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../delegate/badge_delegate.dart';
import '../../delegate/loading_delegate.dart';
import '../../engine/lru_cache.dart';
import '../../engine/throttle.dart';
import '../../entity/options.dart';
import '../../provider/asset_provider.dart';
import '../../provider/config_provider.dart';
import '../../provider/gallery_list_provider.dart';
import '../../provider/i18n_provider.dart';
import '../../provider/selected_provider.dart';
import '../../ui/dialog/change_gallery_dialog.dart';
import '../../ui/page/photo_preview_page.dart';

part './main/bottom_widget.dart';

part './main/image_item.dart';

class PhotoMainPage extends StatefulWidget {
  const PhotoMainPage({
    Key key,
    this.onClose,
    this.options,
    this.photoList,
    this.isCrop = false,
  }) : super(key: key);

  final ValueChanged<List<AssetEntity>> onClose;
  final Options options;
  final List<AssetPathEntity> photoList;
  final bool isCrop;

  @override
  _PhotoMainPageState createState() => _PhotoMainPageState();
}

class _PhotoMainPageState extends State<PhotoMainPage>
    with SelectedProvider, GalleryListProvider {
  Options get options => widget.options;

  I18nProvider get i18nProvider => PhotoPickerProvider.of(context).provider;

  AssetProvider get assetProvider =>
      PhotoPickerProvider.of(context).assetProvider;

  List<AssetEntity> get list => assetProvider.data;

  Color get themeColor => options.themeColor;

  AssetPathEntity _currentPath;

  bool _isInit = false;

  AssetPathEntity get currentPath {
    if (_currentPath == null) {
      return null;
    }
    return _currentPath;
  }

  set currentPath(AssetPathEntity value) {
    _currentPath = value;
  }

  String get currentGalleryName {
    if (currentPath?.isAll == true) {
      return i18nProvider.getAllGalleryText(options);
    }
    return currentPath?.name ?? 'Chọn một thư mục';
  }

  GlobalKey scaffoldKey;
  ScrollController scrollController;

  bool isPushed = false;

  bool get useAlbum => widget.photoList == null || widget.photoList.isEmpty;

  Throttle _changeThrottle;

  @override
  void initState() {
    super.initState();
    scaffoldKey = GlobalKey();
    scrollController = ScrollController();
    _changeThrottle = Throttle(onCall: _onAssetChange);
    PhotoManager.addChangeCallback(_changeThrottle.call);
    PhotoManager.startChangeNotify();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit) {
      final pickedList = PhotoPickerProvider.of(context).pickedAssetList ?? [];
      addPickedAsset(pickedList.toList());
      _refreshList();
    }
  }

  @override
  void dispose() {
    PhotoManager.removeChangeCallback(_changeThrottle.call);
    PhotoManager.stopChangeNotify();
    _changeThrottle.dispose();
    scaffoldKey = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: options.textColor,
      fontSize: 14.0,
    );
    return Theme(
      data: Theme.of(context).copyWith(primaryColor: options.themeColor),
      child: DefaultTextStyle(
        style: textStyle,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.close,
                color: options.textColor,
              ),
              onPressed: _cancel,
            ),
            title: Text(
              i18nProvider.getTitleText(options),
              style: TextStyle(
                color: options.textColor,
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  i18nProvider.getSureText(options, selectedCount),
                  style: selectedCount == 0
                      ? textStyle.copyWith(color: options.disableColor)
                      : textStyle,
                ),
                onPressed: selectedCount == 0 ? null : sure,
              ),
            ],
          ),
          body: _buildBody(),
          bottomNavigationBar: _BottomWidget(
            key: scaffoldKey,
            provider: i18nProvider,
            options: options,
            galleryName: currentGalleryName,
            onGalleryChange: _onGalleryChange,
            onTapPreview: selectedList.isEmpty ? null : _onTapPreview,
            selectedProvider: this,
            galleryListProvider: this,
          ),
        ),
      ),
    );
  }

  void _cancel() {
    selectedList.clear();
//    widget.onClose(selectedList);
    Navigator.pop(context);
  }

  @override
  bool isUpperLimit() {
    final result = selectedCount == options.maxSelected;
    if (result) {
      _showTip(i18nProvider.getMaxTipText(options));
    }
    return result;
  }

  @override
  void sure() {
    widget.onClose?.call(selectedList);
//    if (widget.isCrop) {
//      Navigator.pushNamed(context, Routes.cropImages, arguments: selectedList);
//    }
  }

  void _showTip(String msg) {
    if (isPushed) {
      return;
    }
    ScaffoldMessenger.of(scaffoldKey.currentContext).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: TextStyle(
            color: options.textColor,
            fontSize: 14.0,
          ),
        ),
        duration: const Duration(milliseconds: 1500),
        backgroundColor: themeColor.withOpacity(0.7),
      ),
    );
  }

  Future<void> _refreshList() async {
    await Future.delayed(Duration.zero);
    if (!useAlbum) {
      await _refreshListFromWidget();
      return;
    }

    await _refreshListFromGallery();
  }

  Future<void> _refreshListFromWidget() async {
    await _onRefreshAssetPathList(widget.photoList);
  }

  Future<void> _refreshListFromGallery() async {
    List<AssetPathEntity> pathList;
    switch (options.pickType) {
      case PickType.onlyImage:
        pathList = await PhotoManager.getAssetPathList(type: RequestType.image);
        break;
      case PickType.onlyVideo:
        pathList = await PhotoManager.getAssetPathList(type: RequestType.video);
        break;
      default:
        pathList = await PhotoManager.getAssetPathList();
    }

    await _onRefreshAssetPathList(pathList);
  }

  Future<void> _onRefreshAssetPathList(List<AssetPathEntity> pathList) async {
    if (pathList == null) {
      return;
    }

    options.sortDelegate.sort(pathList);

    galleryPathList.clear();
    galleryPathList.addAll(pathList);

    if (pathList.isNotEmpty) {
      assetProvider.current = pathList[0];
      await assetProvider.loadMore();
    }

    for (var path in pathList) {
      if (path.isAll) {
        path.name = i18nProvider.getAllGalleryText(options);
      }
    }

    setState(() {
      _isInit = true;
    });
  }

  Widget _buildBody() {
    final noMore = assetProvider.noMore;
    final count = assetProvider.count + (noMore ? 0 : 1);

    if (!_isInit) {
      return Center(child: _buildLoading());
    }

    if (assetProvider.count < 1) {
      return const Center(child: Text('Không có ảnh. Hãy chụp ảnh!'));
    }

    return Container(
      color: options.dividerColor,
      child: GridView.builder(
        controller: scrollController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: options.rowCount,
          childAspectRatio: options.itemRadio,
          crossAxisSpacing: options.padding,
          mainAxisSpacing: options.padding,
        ),
        itemBuilder: _buildItem,
        itemCount: count,
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    final noMore = assetProvider.noMore;
    if (!noMore && index == assetProvider.count) {
      _loadMore();
      return _buildLoading();
    }

    final data = list[index];
    return RepaintBoundary(
      child: GestureDetector(
        onTap: () => changeCheck(!containsEntity(data), data),
        child: Stack(
          children: <Widget>[
            ImageItem(
              entity: data,
              themeColor: themeColor,
              size: options.thumbSize,
              loadingDelegate: options.loadingDelegate,
              badgeDelegate: options.badgeDelegate,
            ),
            _buildMask(containsEntity(data)),
            _buildSelected(data),
          ],
        ),
      ),
    );
  }

  Future<void> _loadMore() async {
    await assetProvider.loadMore();
    setState(() {});
  }

  Widget _buildMask(bool showMask) {
    return IgnorePointer(
      child: AnimatedContainer(
        color: showMask ? Colors.black.withOpacity(0.5) : Colors.transparent,
        duration: const Duration(milliseconds: 300),
      ),
    );
  }

  Widget _buildSelected(AssetEntity entity) {
    final currentSelected = containsEntity(entity);
    return Positioned(
      right: 0.0,
      width: 36.0,
      height: 36.0,
      child: GestureDetector(
        onTap: () {
          changeCheck(!currentSelected, entity);
        },
        behavior: HitTestBehavior.translucent,
        child: _buildText(entity),
      ),
    );
  }

  Widget _buildText(AssetEntity entity) {
    final isSelected = containsEntity(entity);
    Widget child;
    BoxDecoration decoration;
    if (isSelected) {
      child = Text(
        (indexOfSelected(entity) + 1).toString(),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12.0,
          color: options.textColor,
        ),
      );
      decoration = BoxDecoration(color: themeColor);
    } else {
      decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(1.0),
        border: Border.all(
          color: themeColor,
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: decoration,
        alignment: Alignment.center,
        child: child,
      ),
    );
  }

  void changeCheck(bool value, AssetEntity entity) {
    if (value) {
      addSelectEntity(entity);
      if (isUpperLimit() && options.autoCloseOnSelectionLimit) {
        sure();
      }
    } else {
      removeSelectEntity(entity);
    }
    setState(() {});
  }

  Future<void> _onGalleryChange(AssetPathEntity assetPathEntity) async {
    // _currentPath = assetPathEntity;

    // _currentPath.assetList.then((v) async {
    //   _sortAssetList(v);
    //   list.clear();
    //   list.addAll(v);
    //   scrollController.jumpTo(0.0);
    //   await checkPickImageEntity();
    //   setState(() {});
    // });
    if (assetPathEntity != assetProvider.current) {
      assetProvider.current = assetPathEntity;
      await assetProvider.loadMore();
      setState(() {});
    }
  }

  Future<void> _onTapPreview() async {
    final result = PhotoPreviewResult();
    isPushed = true;
    final value = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => PhotoPickerProvider(
          provider: PhotoPickerProvider.of(context).provider,
          options: options,
          child: PhotoPreviewPage(
            selectedProvider: this,
            list: List.of(selectedList),
            changeProviderOnCheckChange: false,
            result: result,
            isPreview: true,
            assetProvider: assetProvider,
          ),
        ),
      ),
    );
    if (handlePreviewResult(value)) {
      // print(v);
//      Navigator.pop(context, value);
      return;
    }
    isPushed = false;
    compareAndRemoveEntities(result.previewSelectedList);
  }

  bool handlePreviewResult(List<AssetEntity> v) {
    if (v == null) {
      return false;
    }
    if (v is List<AssetEntity>) {
      return true;
    }
    return false;
  }

  Widget _buildLoading() {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            width: 40.0,
            height: 40.0,
            padding: const EdgeInsets.all(5.0),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(themeColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              i18nProvider.loadingText(),
              style: const TextStyle(
                fontSize: 12.0,
              ),
            ),
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }

  void _onAssetChange() {
    if (useAlbum) {
      _onPhotoRefresh();
    }
  }

  Future<void> _onPhotoRefresh() async {
    List<AssetPathEntity> pathList;
    switch (options.pickType) {
      case PickType.onlyImage:
        pathList = await PhotoManager.getAssetPathList(type: RequestType.image);
        break;
      case PickType.onlyVideo:
        pathList = await PhotoManager.getAssetPathList(type: RequestType.video);
        break;
      default:
        pathList = await PhotoManager.getAssetPathList();
    }

    if (pathList == null) {
      return;
    }

    galleryPathList.clear();
    galleryPathList.addAll(pathList);

    if (!galleryPathList.contains(currentPath)) {
      // current path is deleted , 当前的相册被删除, 应该提示刷新
      if (galleryPathList.isNotEmpty) {
        await _onGalleryChange(galleryPathList[0]);
      }
      return;
    }
    // Not deleted
    await _onGalleryChange(currentPath);
  }
}
