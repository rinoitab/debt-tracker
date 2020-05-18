import 'package:debttracker/model/combine-stream.dart';
import 'package:debttracker/service/service.dart';

class CombineStreamVM extends CombineStream {

  final FirestoreService _service = FirestoreService();

  Stream<List<CombineStream>> streamDueToday() {
    return _service.streamDueToday();
  }

  Stream<List<CombineStream>> streamOverdue() {
    return _service.streamOverdue();
  }

  Stream<List<CombineStream>> streamPendingDebts() {
    return _service.streamPendingDebts();
  }

  Stream<List<CombineStream>> streamAllDebts() {
    return _service.streamAllDebts();
  }

}