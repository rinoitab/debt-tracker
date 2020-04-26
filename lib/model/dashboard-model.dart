class Dashboard {
  int dueToday;
  double monthlyEarnings;
  List<double> yearlyEarnings;
  int completed;
  int pending;
  int overdue;
  int overall;

  Dashboard({
    this.dueToday, 
    this.monthlyEarnings, 
    this.yearlyEarnings, 
    this.completed, 
    this.pending, 
    this.overdue, 
    this.overall}){
    dueToday = 32;
    monthlyEarnings = 43000.00;
    yearlyEarnings = [2500, 3000, 5000, 10000, 40000, 2900, 40500, 32000, 60000, 10000, 5000, 12000];
    completed = 56;
    pending = 34;
    overdue = 12;
    overall = 90;
  }
}
