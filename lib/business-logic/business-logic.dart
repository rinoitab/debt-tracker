

class BusinessLogic {

  List<dynamic> getPayableDates(double term, int type, String date, String second) {
    DateTime startDate = DateTime.parse(date);
    DateTime secondDate = second.isEmpty ? DateTime.now() : DateTime.parse(second);
    DateTime payable = DateTime(startDate.year, startDate.month, startDate.day);
    var payables = [];

    for (var i = 0; i < (term * type); i++) {
      switch (type) {
        case 1:
          payable = new DateTime(payable.year, i == 0 ? payable.month : payable.month + 1, payable.day);
          break;
        case 2: 
          payable = DateTime(payable.year, i % 2 == 0 ? payable.month : payable.month + 1, i % 2 == 0 ? startDate.day : secondDate.day);
          break;
        case 4:
          payable = new DateTime(payable.year, payable.month, payable.day + 7);
          break; 
      }
      payables.add(payable);
    }
    return payables;
  }

  double getAdjustedAmount(double amount, int markup) {
    return amount + amount * (markup / 100);
  }

  double getInstallmentAmount(double adjustedAmount, double term, int type) {
    return adjustedAmount / (term * type);
  }
}