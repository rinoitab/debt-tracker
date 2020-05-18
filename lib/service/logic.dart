import 'dart:math';
import 'package:debttracker/model/debt-model.dart';
import 'package:debttracker/model/payables-model.dart';
import 'package:debttracker/model/payment-model.dart';
import 'package:debttracker/view-model/debt-viewmodel.dart';
import 'package:debttracker/view-model/payables-viewmodel.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';

class Logic {

  List<double> getEarningsChart(List<Payment> _payment) {
    DateTime now = DateTime.now();
    double prev = 0.0;
    double current = 0.0;

    for(int i = 0; i < _payment.length; i++) {
      if(_payment[i].date.month == now.month) {
        prev = prev + _payment[i].amount;
      }
      if(_payment[i].date.month == now.month - 1) {
        current = current + _payment[i].amount;
      }
    }

    return [prev, current];
  }

  double getDifference(List<double> _difference) {
    var result = _difference[1] - _difference[0];

    return result;
  }

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
    reference = reference.toUpperCase();
    var text = 'Payment Receipt:\nEllen Bation has received the amount of $amount from $name for $desc.\nReference no. $reference\nDate: $date';
    return text;
  }

  void markPaidPayables(List<Payables> _payables, double _amount, Debt debt) {
    Payables _doc;
    PayablesVM _payablesModel = PayablesVM();
    DebtVM _debtModel = DebtVM();
    double _newAmount = _amount;
    double _newDebt;
    double _newBalance;

    _payables.sort((a, b) {
      var adate = a.date;
      var bdate = b.date;
      return -bdate.compareTo(adate);
    });
    
    _newDebt = max(debt.balance - _newAmount, 0);

    for (int i = 0; i < _payables.length; i++) {
      _doc = _payables[i];
      _newBalance = _doc.balance;
      if(_doc.isPaid == false) {
        switch (_newAmount > 0) {
          case true:
            _newBalance = max(_newBalance - _newAmount, 0);
            _newAmount = max(_newAmount - _doc.balance, 0);
            

            print(_doc.date);
            print('Balance: $_newBalance');
            print('Debt: $_newDebt');
            print('Amount: $_newAmount');

            if(_newBalance == 0) {
              _payablesModel.updatePayable(
                id: _doc.id,
                debtorId: _doc.debtorId, 
                debtId: _doc.debtId,
                amount: _doc.amount,
                balance: _newBalance,
                date: _doc.date,
                isPaid: true);
            } else {
              _payablesModel.updatePayable(
                id: _doc.id,
                debtorId: _doc.debtorId, 
                debtId: _doc.debtId,
                amount: _doc.amount,
                balance: _newBalance,
                date: _doc.date,
                isPaid: false);
            }
            break;
          case false:
            break;
          }
        }
      }

      

      if(_newDebt == 0) {
              _debtModel.updateDebt(
                id: debt.id,
                debtorId: debt.debtorId, 
                date: debt.date,
                desc: debt.desc,
                amount: debt.amount,
                markup: debt.markup,
                adjustedAmount: debt.adjustedAmount,
                term: debt.term,
                type: debt.type,
                installmentAmount: debt.installmentAmount,
                balance: _newDebt,
                isCompleted: true);
            } else {
              _debtModel.updateDebt(
                id: debt.id,
                debtorId: debt.debtorId, 
                date: debt.date,
                desc: debt.desc,
                amount: debt.amount,
                markup: debt.markup,
                adjustedAmount: debt.adjustedAmount,
                term: debt.term,
                type: debt.type,
                installmentAmount: debt.installmentAmount,
                balance: _newDebt,
                isCompleted: false);
            }
  }

  String formatCurrency(double _amount) {
    final cur = new NumberFormat.simpleCurrency(name: 'PHP');

    return cur.format(_amount);
  }

  String formatDate(DateTime _date) {
    return DateFormat("MMM d, yyyy").format(_date);
  }

  int getDaysLate(DateTime _date) {
    return DateTime.now().difference(_date).inDays;
  }

  int getPercentInDecimal(double _adjustedAmount, double _balance) {
     return (((_adjustedAmount - _balance) / _adjustedAmount) * 100).round();
  }

  double getPercentage(double _adjustedAmount, double _balance) {
     return ((_adjustedAmount - _balance) / _adjustedAmount);
  }

  String formatContact(int _number) {
    final _phone = MaskedTextController(mask: '(63) 000 000 0000');
    final _landline = MaskedTextController(mask: '000-0000');
    String _contact;

    if(_number < 9) {
      _landline.updateText(_number.toString());
      _contact = _landline.text;
    } else {
      _phone.updateText(_number.toString());
      _contact = _phone.text;
    }

    return _contact;
  }

}