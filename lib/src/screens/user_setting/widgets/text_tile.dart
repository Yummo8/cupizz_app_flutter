part of '../user_setting_screen.dart';

class _TextTile extends StatelessWidget {
  const _TextTile({
    this.title = '',
    this.isEnabled = true,
    required this.text,
    this.onTap,
    this.titleColor,
    this.children,
  });

  final String title;
  final String text;
  final bool isEnabled;
  final VoidCallback? onTap;
  final Color? titleColor;
  final List<Widget>? children;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 12,
      children: <Widget>[
        if (title.isNotEmpty)
          Text(
            title,
            style: TextStyle(
              color: titleColor ?? context.colorScheme.onBackground,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.left,
          ),
        InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 9,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                if (children != null)
                  Expanded(
                    child: Wrap(
                      spacing: 10,
                      children: children!,
                    ),
                  )
                else
                  Expanded(
                    child: Text(
                      text,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                if (isEnabled)
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                  ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
