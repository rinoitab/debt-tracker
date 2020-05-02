class Logic {

  List<dynamic> getPayableDates(double term, int type, String startDate, String secondDate) {
    DateTime startCollectionDate = DateTime.parse(startDate);
    DateTime secondCollectionDate = secondDate.isEmpty ? DateTime.now() : DateTime.parse(secondDate);
    DateTime payable = DateTime(startCollectionDate.year, startCollectionDate.month, startCollectionDate.day);
    var payables = [];

    for (var i = 0; i < (term * type); i++) {
      switch (type) {
        case 1:
          payable = new DateTime(payable.year, i == 0 ? payable.month : payable.month + 1, payable.day);
          break;
        case 2: 
          payable = DateTime(payable.year, i % 2 == 0 ? payable.month : payable.month + 1, i % 2 == 0 ? startCollectionDate.day : secondCollectionDate.day);
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

  String generateReceipt(String reference, String name, String desc, String date, String amount) {
    var text = 'Payment Receipt:\nEllen Bation has received the amount of $amount from $name for $desc.\nReference no. $reference\nDate: $date';
    return text;
  }

  
}