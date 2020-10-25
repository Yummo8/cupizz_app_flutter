import 'package:equatable/equatable.dart';

class AuthModel2 extends Equatable  {
	final String token;

	AuthModel2({this.token});

	factory AuthModel2.fromJson(Map<String, dynamic> json) {
		return AuthModel2(
			token: json['token'],
		);
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['token'] = this.token;
		return data;
	}

	@override
	List<Object> get props => [
		this.token
	];
}
