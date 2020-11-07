part of '../index.dart';

class UserCard extends StatelessWidget {
  final Function onPressed;
  final SimpleUser simpleUser;

  const UserCard({Key key, this.onPressed, @required this.simpleUser})
      : assert(simpleUser != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              color: context.colorScheme.background,
            ),
            padding: const EdgeInsets.all(20),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colorScheme.background,
              ),
            ),
          ),
          Positioned.fill(
              child: NetwordImage(simpleUser.avatar.url, isAvatar: true)),
          Positioned(
            bottom: 0,
            child: Container(
              height: 200,
              width: context.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    context.colorScheme.background.withOpacity(0),
                    context.colorScheme.background.withOpacity(0),
                    context.colorScheme.background.withOpacity(0.03),
                    context.colorScheme.background.withOpacity(0.07),
                    context.colorScheme.background.withOpacity(0.1),
                    context.colorScheme.background.withOpacity(0.3),
                    context.colorScheme.background.withOpacity(0.5),
                    context.colorScheme.background.withOpacity(0.7),
                    context.colorScheme.background.withOpacity(0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 5,
                  crossAxisAlignment: WrapCrossAlignment.end,
                  children: [
                    Text(
                      simpleUser.displayName,
                      style: context.textTheme.subtitle1.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.colorScheme.primary,
                      ),
                    ),
                    if (simpleUser.age != null)
                      Text(
                        simpleUser.age.toString(),
                        style: context.textTheme.caption,
                      ),
                  ],
                ),
                if (simpleUser.introduction.isExistAndNotEmpty)
                  Text(
                    simpleUser.introduction,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.caption.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ..._buildHobbyList(context)
              ],
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildHobbyList(BuildContext context) {
    final currentUserPreferHobbies = Fake.currentUser.hobbies ?? [];
    debugPrint(
        currentUserPreferHobbies.map((e) => e.value).toList().toString());

    List<_HobbyWithIsSelect> hobbiesToShow = [];
    List<Hobby> userHobbies = [...simpleUser.hobbies] ?? [];

    for (var hobby in userHobbies) {
      if (hobbiesToShow.length >= 5) break;
      if (currentUserPreferHobbies.contains(hobby)) {
        hobbiesToShow.add(_HobbyWithIsSelect(hobby, true));
      }
    }

    if (hobbiesToShow.length < 5) {
      hobbiesToShow.addAll(userHobbies
          .takeWhile((e) => !currentUserPreferHobbies.contains(e))
          .take(5 - hobbiesToShow.length)
          .map((e) => _HobbyWithIsSelect(e, false))
          .toList());
    }
    hobbiesToShow.shuffle();

    return hobbiesToShow.isEmpty
        ? []
        : [
            Divider(color: Colors.grey[300]),
            RichText(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                    style: context.textTheme.bodyText1,
                    children: hobbiesToShow
                        .asMap()
                        .map(
                          (i, e) => MapEntry(
                              i,
                              TextSpan(
                                text: e?.hobby?.value != null
                                    ? '${e.hobby.value}${i < hobbiesToShow.length - 1 ? ', ' : ''}'
                                    : '',
                                style: TextStyle(
                                  color: e.isSelected
                                      ? context.colorScheme.primary
                                      : context.colorScheme.onBackground,
                                ),
                              )),
                        )
                        .values
                        .toList()))
          ];
  }
}

class _HobbyWithIsSelect implements Comparable<_HobbyWithIsSelect> {
  final bool isSelected;
  final Hobby hobby;

  _HobbyWithIsSelect(this.hobby, this.isSelected);

  compareTo(_HobbyWithIsSelect other) => this.hobby.compareTo(other.hobby);
}
