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
}
