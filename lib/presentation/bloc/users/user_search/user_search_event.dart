part of 'user_search_bloc.dart';

@freezed
abstract class UserSearchEvent implements _$UserSearchEvent {
  const UserSearchEvent._();
  const factory UserSearchEvent.changeQuery({String newQuery}) = _ChangeQuery;

  const factory UserSearchEvent.clearQuery() = _ClearQuery;

  @override
  bool operator ==(Object other) => false;

  @override
  int get hashCode => Uuid().v1().hashCode;
}
