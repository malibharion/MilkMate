import 'package:get/get.dart';

class TransactionsController extends GetxController {
  final isLoading = false.obs;

  // ── Summary stats ──
  final paymentsReceived = 0.0.obs;
  final paymentsReceivedDelta = 0.0.obs;
  final expensesAdded = 0.0.obs;
  final expensesAddedDelta = 0.0.obs;
  final expensesAdded2 = 0.0.obs;
  final expensesAdded2Delta = 0.0.obs;
  final pendingApprovals = 0.obs;

  // ── Chart: last 7 days ──
  // Keys: day (String), payments (double), expenses (double)
  final chartData = <Map<String, dynamic>>[].obs;

  // ── Recent transactions ──
  // Keys: title, amount, status ('pending'|'approved'), type ('expense'|'payment')
  final transactions = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() {
    isLoading.value = true;

    Future.delayed(const Duration(milliseconds: 600), () {
      paymentsReceived.value = 750;
      paymentsReceivedDelta.value = 53.07;
      expensesAdded.value = 700;
      expensesAddedDelta.value = 13.00;
      expensesAdded2.value = 700;
      expensesAdded2Delta.value = 12.00;
      pendingApprovals.value = 1;

      chartData.assignAll([
        {'day': 'Mon', 'payments': 300.0, 'expenses': 150.0},
        {'day': 'Tue', 'payments': 450.0, 'expenses': 200.0},
        {'day': 'Wed', 'payments': 280.0, 'expenses': 320.0},
        {'day': 'Thu', 'payments': 520.0, 'expenses': 180.0},
        {'day': 'Fri', 'payments': 680.0, 'expenses': 400.0},
        {'day': 'Sat', 'payments': 390.0, 'expenses': 260.0},
        {'day': 'Sun', 'payments': 510.0, 'expenses': 220.0},
      ]);

      transactions.assignAll([
        {
          'title': 'Expense Added — Feed',
          'amount': 'Rs 2,500',
          'status': 'pending',
          'type': 'expense',
        },
        {
          'title': 'Payment Received — Ahmed',
          'amount': 'Rs 3,000',
          'status': 'pending',
          'type': 'payment',
        },
        {
          'title': 'Expense Added — Medicine',
          'amount': 'Rs 800',
          'status': 'approved',
          'type': 'expense',
        },
        {
          'title': 'Payment Received — Nadia',
          'amount': 'Rs 1,200',
          'status': 'approved',
          'type': 'payment',
        },
        {
          'title': 'Expense Added — Fuel',
          'amount': 'Rs 500',
          'status': 'approved',
          'type': 'expense',
        },
        {
          'title': 'Payment Received — Bilal',
          'amount': 'Rs 2,000',
          'status': 'approved',
          'type': 'payment',
        },
      ]);

      isLoading.value = false;
    });
  }

  void onAddExpense() {
    Get.toNamed('/add-expense');
  }

  void onAddPayment() {
    Get.toNamed('/add-payment');
  }

  void onAddTransaction() {
    // Get.toNamed('/add-transaction');
  }

  void onFilter() {
    // show filter bottom sheet
  }
}
