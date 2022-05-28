import 'package:flutter_bloc/flutter_bloc.dart';

//class for all events
class ListItemEvent {}

//class for event - added item
class ListItemAdded extends ListItemEvent {
  int count;
  ListItemAdded({required this.count});
}

//class for event - removed item
class ListItemRemoved extends ListItemEvent {
  int count;
  ListItemRemoved({required this.count});
}

//class for state
class ListItemState {
  //list of all items
  final List<bool> itemList;
  //massage to SnackBar
  final String snackBarMessage;
  //cointer for items
  final int itemCounter;
  //permission for massage to SnackBar
  final bool message;

  ListItemState(
      {required this.itemCounter,
      this.snackBarMessage = '',
      this.message = false,
      itemList})
      : itemList = itemList ?? List<bool>.filled(10, false);
}

class ListItemBloc extends Bloc<ListItemEvent, ListItemState> {
  ListItemBloc() : super(ListItemState(itemCounter: 0)) {
    //state for every tap on icon busket
    on<ListItemAdded>((ListItemAdded event, Emitter<ListItemState> emitter) {
      List<bool> list = state.itemList;
      list[event.count] = true;
      return emitter(ListItemState(
          itemCounter: state.itemCounter + 1,
          message: true,
          snackBarMessage: 'Added to cart',
          itemList: list));
    });
    //state for every untap on icon busket
    on<ListItemRemoved>(
        (ListItemRemoved event, Emitter<ListItemState> emitter) {
      List<bool> list = state.itemList;
      list[event.count] = false;
      return emitter(ListItemState(
          itemCounter: state.itemCounter - 1,
          message: true,
          snackBarMessage: 'Removed from cart',
          itemList: list));
    });
  }
}
