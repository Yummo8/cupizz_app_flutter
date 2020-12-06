import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

abstract class BadgeDelegate {
  const BadgeDelegate();

  Widget buildBadge(BuildContext context, AssetType type, Duration duration);
}

class DefaultBadgeDelegate extends BadgeDelegate {
  const DefaultBadgeDelegate({
    this.alignment = Alignment.topLeft,
  });

  final AlignmentGeometry alignment;

  @override
  Widget buildBadge(BuildContext context, AssetType type, Duration duration) {
    if (type == AssetType.video) {
      return Padding(
        padding: const EdgeInsets.all(2.0),
        child: Align(
          alignment: alignment,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(3.0),
            ),
            child: const Text(
              'video',
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.white,
              ),
            ),
            padding: const EdgeInsets.all(4.0),
          ),
        ),
      );
    }

    return Container();
  }
}

class DurationBadgeDelegate extends BadgeDelegate {
  const DurationBadgeDelegate({this.alignment = Alignment.bottomRight});

  final AlignmentGeometry alignment;

  @override
  Widget buildBadge(BuildContext context, AssetType type, Duration duration) {
    if (type == AssetType.video) {
      final s = duration.inSeconds % 60;
      final m = duration.inMinutes % 60;
      final h = duration.inHours;

      final text =
          '$h:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';

      return Padding(
        padding: const EdgeInsets.all(2.0),
        child: Align(
          alignment: alignment,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.65),
            ),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 12.0,
                color: Colors.white,
              ),
            ),
            padding: const EdgeInsets.all(4.0),
          ),
        ),
      );
    }

    return Container();
  }
}
