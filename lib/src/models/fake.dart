part of 'index.dart';

class Fake {
  static User currentUser = User(
    id: '0000',
    age: 22,
    avatar: FileModel(
        id: '0000',
        url:
            'https://avatars2.githubusercontent.com/u/36977998?s=460&u=2620376cf57c02a2a9bb3fe00c45ebfa75aff511&v=4'),
    bio: 'I am a Good boy',
    hobbies: [...getRandomSubarray<Hobby>(hobbies, Random().nextInt(5))],
  );

  static List<User> users = List.generate(
    20,
    (index) => User(
      id: (index + 1).toString(),
      name: 'Hien ' + (index + 1).toString(),
      age: 22 + index,
      avatar: FileModel(
        id: (index + 1).toString(),
        url: 'https://loremflickr.com/888/851/girl?lock=$index',
      ),
      bio:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
      hobbies: [
        ...getRandomSubarray<Hobby>(hobbies, Random().nextInt(hobbies.length))
      ],
    ),
  );

  static List<Hobby> hobbies = List.generate(
      20,
      (index) =>
          Hobby(id: (index + 1).toString(), value: 'Hobby ${index + 1}'));
}

List<T> getRandomSubarray<T>(List<T> array, int size) {
  var shuffled = array.take(size).toList();
  shuffled.shuffle();
  return shuffled;
}
