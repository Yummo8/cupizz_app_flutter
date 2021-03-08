import '../entity/options.dart';
import 'selected_provider.dart';

abstract class I18nProvider {
  const I18nProvider._();

  String getTitleText(Options? options);

  String getSureText(Options? options, int currentCount);

  String getPreviewText(Options? options, SelectedProvider? selectedProvider);

  String getSelectedOptionsText(Options? options);

  String getMaxTipText(Options? options);

  String getAllGalleryText(Options? options);

  String loadingText() {
    return 'Loading...';
  }

  I18NPermissionProvider getNotPermissionText(Options options);

  static const I18nProvider japanese = JAProvider();

  static const I18nProvider vietnamese = VNProvider();

  static const I18nProvider chinese = CNProvider();

  static const I18nProvider english = ENProvider();
}

class VNProvider extends I18nProvider {
  const VNProvider() : super._();

  @override
  String getTitleText(Options? options) {
    return 'Chọn hình ảnh';
  }

  @override
  String getPreviewText(Options? options, SelectedProvider? selectedProvider) {
    return 'Xem trước (${selectedProvider!.selectedCount})';
  }

  @override
  String getSureText(Options? options, int currentCount) {
    return 'Đã chọn ($currentCount/${options!.maxSelected})';
  }

  @override
  String getSelectedOptionsText(Options? options) {
    return 'Chọn';
  }

  @override
  String getMaxTipText(Options? options) {
    return 'Bạn đã lựa chọn ${options!.maxSelected} hình';
  }

  @override
  String getAllGalleryText(Options? options) {
    return 'Tất cả';
  }

  @override
  String loadingText() {
    return 'Đang tải...';
  }

  @override
  I18NPermissionProvider getNotPermissionText(Options options) {
    return const I18NPermissionProvider(
        cancelText: 'Hủy',
        sureText: 'Đồng ý',
        titleText: 'Không có quyền truy cập album');
  }
}

class CNProvider extends I18nProvider {
  const CNProvider() : super._();

  @override
  String getTitleText(Options? options) {
    return '图片选择';
  }

  @override
  String getPreviewText(Options? options, SelectedProvider? selectedProvider) {
    return '预览(${selectedProvider!.selectedCount})';
  }

  @override
  String getSureText(Options? options, int currentCount) {
    return '确定($currentCount/${options!.maxSelected})';
  }

  @override
  String getSelectedOptionsText(Options? options) {
    return '选择';
  }

  @override
  String getMaxTipText(Options? options) {
    return '您已经选择了${options!.maxSelected}张图片';
  }

  @override
  String getAllGalleryText(Options? options) {
    return '全部图片';
  }

  @override
  String loadingText() {
    return '加载中...';
  }

  @override
  I18NPermissionProvider getNotPermissionText(Options options) {
    return const I18NPermissionProvider(
        cancelText: '取消', sureText: '去开启', titleText: '没有访问相册的权限');
  }
}

class ENProvider extends I18nProvider {
  const ENProvider() : super._();

  @override
  String getTitleText(Options? options) {
    return 'Image Picker';
  }

  @override
  String getPreviewText(Options? options, SelectedProvider? selectedProvider) {
    return 'Preview (${selectedProvider!.selectedCount})';
  }

  @override
  String getSureText(Options? options, int currentCount) {
    return 'Save ($currentCount/${options!.maxSelected})';
  }

  @override
  String getSelectedOptionsText(Options? options) {
    return 'Selected';
  }

  @override
  String getMaxTipText(Options? options) {
    return 'Select ${options!.maxSelected} pictures at most';
  }

  @override
  String getAllGalleryText(Options? options) {
    return 'Recent';
  }

  @override
  I18NPermissionProvider getNotPermissionText(Options options) {
    return const I18NPermissionProvider(
        cancelText: 'Cancel',
        sureText: 'Allow',
        titleText: 'No permission to access gallery');
  }
}

class JAProvider extends I18nProvider {
  const JAProvider() : super._();

  @override
  String getTitleText(Options? options) {
    return '';
  }

  @override
  String getPreviewText(Options? options, SelectedProvider? selectedProvider) {
    return 'プレビュー (${selectedProvider!.selectedCount})';
  }

  @override
  String getSureText(Options? options, int currentCount) {
    return options!.isCropImage!
        ? '次へ ($currentCount/${options.maxSelected})'
        : '送信 ($currentCount/${options.maxSelected})';
  }

  @override
  String getSelectedOptionsText(Options? options) {
    return '選択済み';
  }

  @override
  String getMaxTipText(Options? options) {
    return '最大${options!.maxSelected}枚の写真を選択してください';
  }

  @override
  String getAllGalleryText(Options? options) {
    return '最近の項目';
  }

  @override
  I18NPermissionProvider getNotPermissionText(Options options) {
    return const I18NPermissionProvider(
        cancelText: 'キャンセル', sureText: '完了', titleText: 'ギャラリーにアクセスする権限がありません');
  }
}

abstract class I18NCustomProvider implements I18nProvider {
  I18NCustomProvider(
    this.maxTipText,
    this.previewText,
    this.selectedOptionsText,
    this.sureText,
    this.titleText,
    this.notPermissionText,
  );

  final String maxTipText;
  final String previewText;
  final String selectedOptionsText;
  final String sureText;
  final String titleText;

  final I18NPermissionProvider notPermissionText;

  @override
  String getMaxTipText(Options? options) {
    return maxTipText;
  }

  @override
  String getSelectedOptionsText(Options? options) {
    return selectedOptionsText;
  }

  @override
  String getTitleText(Options? options) {
    return titleText;
  }

  @override
  I18NPermissionProvider getNotPermissionText(Options options) {
    return notPermissionText;
  }
}

class I18NPermissionProvider {
  const I18NPermissionProvider({
    this.titleText,
    this.sureText,
    this.cancelText,
  });

  final String? titleText;
  final String? sureText;

  final String? cancelText;
}
