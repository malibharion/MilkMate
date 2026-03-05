import 'package:get/get.dart';

class CustomerDetailController extends GetxController {
  // ── Passed from list via Get.arguments ──
  final customerName = ''.obs;
  final customerPhone = ''.obs;
  final litersPerDay = ''.obs;
  final balanceRaw = ''.obs; // e.g. '+5000' or '-1500'
  final customerId = ''.obs;

  final isLoading = false.obs;

  // ── Outstanding balance display ──
  String get balanceDisplay {
    final b = balanceRaw.value;
    final isPos = b.startsWith('+');
    final num = b.replaceAll(RegExp(r'[+\-]'), '');
    return '\$${_fmt(num)}';
  }

  String get balanceLabel =>
      balanceRaw.value.startsWith('+') ? 'We Owe' : 'Customer Owes';
  bool get isPositive => balanceRaw.value.startsWith('+');

  String _fmt(String n) {
    final v = int.tryParse(n) ?? 0;
    if (v >= 1000)
      return '${v ~/ 1000},${(v % 1000).toString().padLeft(3, '0')}';
    return n;
  }

  // ── Milk supply chart data (last 30 days sample) ──
  // Each map: day (1-30), liters
  final milkChartData = <Map<String, double>>[].obs;
  final totalMilkWeek = 0.0.obs;
  final avgDaily = 0.0.obs;
  final totalMilkMonth = 0.0.obs;

  // ── Payment history ──
  // Keys: amount, timeLabel
  final payments = <Map<String, String>>[].obs;

  // ── Milk records list ──
  // Keys: date, liters, ratePerLiter, total
  final milkRecords = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadFromArguments();
    loadDetailData();
  }

  void _loadFromArguments() {
    final args = Get.arguments as Map<String, String>? ?? {};
    customerName.value = args['name'] ?? 'Customer';
    customerPhone.value = args['phone'] ?? '';
    litersPerDay.value = args['litersPerDay'] ?? '0';
    balanceRaw.value = args['balance'] ?? '+0';
    customerId.value =
        'MM${(args['name'] ?? 'X').hashCode.abs() % 9000 + 1000}';
  }

  void loadDetailData() {
    isLoading.value = true;

    Future.delayed(const Duration(milliseconds: 500), () {
      // Chart: 30 days of simulated supply
      final base = double.tryParse(litersPerDay.value) ?? 10.0;
      final data = List.generate(30, (i) {
        final variation = (i % 7 == 0 ? -2.0 : (i % 3 == 0 ? 1.5 : 0.5));
        return <String, double>{
          'day': (i + 1).toDouble(),
          'liters': (base + variation).clamp(0.0, 99.0),
        };
      });
      milkChartData.assignAll(data);
      milkChartData.assignAll(data as Iterable<Map<String, double>>);
      totalMilkWeek.value = data
          .sublist(23)
          .fold(0.0, (s, e) => s + e['liters']!);
      avgDaily.value = data.fold(0.0, (s, e) => s + e['liters']!) / 30;
      totalMilkMonth.value = data.fold(0.0, (s, e) => s + e['liters']!);

      // Payments
      payments.assignAll([
        {'amount': 'Rs 2,500', 'timeLabel': 'Today'},
        {'amount': 'Rs 1,800', 'timeLabel': 'Yesterday'},
        {'amount': 'Rs 3,000', 'timeLabel': '1 week ago'},
        {'amount': 'Rs 1,200', 'timeLabel': '2 weeks ago'},
      ]);

      // Milk records
      milkRecords.assignAll([
        {'date': '12 Aug', 'liters': '10', 'rate': '120', 'total': '1,200'},
        {'date': '11 Aug', 'liters': '9', 'rate': '120', 'total': '1,080'},
        {'date': '10 Aug', 'liters': '11', 'rate': '120', 'total': '1,320'},
        {'date': '09 Aug', 'liters': '10', 'rate': '120', 'total': '1,200'},
        {'date': '08 Aug', 'liters': '8', 'rate': '120', 'total': '960'},
      ]);

      isLoading.value = false;
    });
  }

  void onCall() {
    // launch phone dialer
    // launchUrl(Uri.parse('tel:${customerPhone.value}'));
  }

  void onEdit() {
    // Get.toNamed(AppRoutes.editCustomer, arguments: {...});
  }

  void onAddMilkEntry() {
    // Get.toNamed(AppRoutes.addMilkEntry, arguments: {'customerName': customerName.value});
  }

  void onAddPayment() {
    // Get.toNamed(AppRoutes.addPayment, arguments: {'customerName': customerName.value});
  }
}
