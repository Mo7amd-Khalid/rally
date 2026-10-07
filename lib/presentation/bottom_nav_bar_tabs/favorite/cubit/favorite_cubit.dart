import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rally/core/base/base_cubit.dart';
import 'package:rally/core/utils/resources.dart';
import 'package:rally/data/models/event_dm.dart';
import 'package:rally/data/network/results.dart';
import 'package:rally/domain/use_case/use_case.dart';
import 'package:rally/presentation/bottom_nav_bar_tabs/favorite/cubit/favorite_contract.dart';
import 'package:injectable/injectable.dart';

@singleton
class FavoriteCubit extends BaseCubit<FavoriteState, FavoriteAction, void> {
  FavoriteCubit(this._eventlyUseCase) : super(FavoriteState());

  final RallyUseCase _eventlyUseCase;

  @override
  Future<void> doAction(FavoriteAction action) async {
    switch (action) {
      case UpdateFavUserList():
        _updateFavUserListOfEvent(action.userID, action.event);
      case SearchInFavList():
        _searchInFavAction(action.events, action.search);
    }
  }

  Stream<QuerySnapshot<EventDM>> getMyFavList(String userID) {
    var response = _eventlyUseCase.getMyFavList(userID);
    return switch (response) {
      Success<Stream<QuerySnapshot<EventDM>>>() => response.data!,
      Failure<Stream<QuerySnapshot<EventDM>>>() => throw UnimplementedError(),
    };
  }

  Future<void> _updateFavUserListOfEvent(String userId, EventDM event) async {
    var response = await _eventlyUseCase.updateFavUserList(userId, event);
    switch (response) {
      case Success<List<EventDM>>():
        emit(state.copyWith(favEvents: Resources.success(data: response.data)));
      case Failure<List<EventDM>>():
        emit(
          state.copyWith(
            favEvents: Resources.failure(
              exception: response.exception,
              message: response.message,
            ),
          ),
        );
    }
  }

  void _searchInFavAction(List<EventDM> events, String search) {
    List<EventDM>? searchedList;
    if(search.isEmpty)
      {
        searchedList = null;
      }
    else
      {
        searchedList = [];
        for (EventDM event in events) {
          if (event.title.toLowerCase().contains(search.toLowerCase()))
          {
            searchedList.add(event);
          }
        }
      }

    emit(state.copyWith(searchedList: Resources.success(data: searchedList)));
  }
}
