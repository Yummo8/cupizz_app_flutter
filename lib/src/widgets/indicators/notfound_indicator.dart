import 'package:cupizz_app/src/base/base.dart';

class NotFoundIndicator extends StatelessWidget {
  final String? type;

  const NotFoundIndicator({Key? key, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('Không tìm thấy${type!.isExistAndNotEmpty ? ' $type' : ''}!');
  }
}
