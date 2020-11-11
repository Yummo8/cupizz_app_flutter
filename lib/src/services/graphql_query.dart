import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../models/index.dart';

class GraphqlQuery {
  static loginMutation({@required String email, @required String password}) =>
      MutationOptions(
        documentNode: gql('''
mutation login(\$email: String, \$password: String){
  login(email: \$email password: \$password) {
    token
  }
}
    '''),
        variables: {'email': email, 'password': password},
      );

  static meQuery() =>
      QueryOptions(documentNode: gql('{ me ${User.graphqlQuery} }'));

  static recommendableUsersQuery() => QueryOptions(
      documentNode: gql('{ recommendableUsers ${SimpleUser.graphqlQuery} }'));

  static updateMySetting({
    int minAgePrefer,
    int maxAgePrefer,
    int minHeightPrefer,
    int maxHeightPrefer,
    List<Gender> genderPrefer,
    int distancePrefer,
    List<String> mustHaveFields,
  }) =>
      QueryOptions(documentNode: gql('''
    mutation updateMySetting(
        minAgePrefer: Int
        maxAgePrefer: Int
        minHeightPrefer: Int
        maxHeightPrefer: Int
        genderPrefer: [Gender!]
        distancePrefer: Int
        mustHaveFields: [MustHaveEnum!]
      )  {
      updateMySetting(
        minAgePrefer: \$minAgePrefer
        maxAgePrefer: \$maxAgePrefer
        minHeightPrefer: \$minHeightPrefer
        maxHeightPrefer: \$maxHeightPrefer
        genderPrefer: \$genderPrefer
        distancePrefer: \$distancePrefer
        mustHaveFields: \$mustHaveFields
      ) {
        ${User.graphqlQuery}
      }
    }
  '''));
}
