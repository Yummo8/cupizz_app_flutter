import 'package:equatable/equatable.dart';

class AuthModel extends Equatable  {
	final String token;

	AuthModel({this.token});

	factory AuthModel.fromJson(Map<String, dynamic> json) {
		return AuthModel(
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
