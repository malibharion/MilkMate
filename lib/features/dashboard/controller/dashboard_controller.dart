// lib/features/dashboard/controller/dashboard_controller.dart
import 'package:dairy_farm_app/core/services/storage_services.dart'
    show StorageService;
import 'package:dairy_farm_app/core/services/supabase_services.dart';
import 'package:get/get.dart';
import '../../../app/routes.dart';

class DashboardController extends GetxController {
  final staffName = ''.obs;
  final farmName = ''.obs;
  final isLoading = false.obs;

  final milkCollected = 0.0.obs;
  final milkCollectedDelta = 0.0.obs;
  final milkSold = 0.0.obs;
  final milkSoldDelta = 0.0.obs;
  final paymentsReceived = 0.0.obs;
  final paymentsReceivedDelta = 0.0.obs;
  final expensesAdded = 0.0.obs;
  final expensesAddedDelta = 0.0.obs;

  final activities = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    staffName.value = StorageService.fullName ?? 'Staff';
    farmName.value = StorageService.farmName ?? 'MilkMate Farm';
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    isLoading.value = true;
    try {
      final farmId = StorageService.farmId;
      print('🔍 [Dashboard] farmId: $farmId');
      if (farmId == null) {
        print('❌ [Dashboard] farmId is null');
        return;
      }

      final today = DateTime.now();
      final todayStr = _dateStr(today);
      final yesterdayStr = _dateStr(today.subtract(const Duration(days: 1)));
      print('📅 [Dashboard] today=$todayStr  yesterday=$yesterdayStr');

      final db = SupabaseService.client;

      // ── Run queries one by one to avoid type inference issues ──
      final milkToday =
          await db
                  .from('milk_production')
                  .select('quantity_liters')
                  .eq('farm_id', farmId)
                  .eq('production_date', todayStr)
                  .eq('status', 'approved')
              as List;
      final milkYest =
          await db
                  .from('milk_production')
                  .select('quantity_liters')
                  .eq('farm_id', farmId)
                  .eq('production_date', yesterdayStr)
                  .eq('status', 'approved')
              as List;
      final salesToday =
          await db
                  .from('milk_sales')
                  .select('total_amount')
                  .eq('farm_id', farmId)
                  .eq('sale_date', todayStr)
                  .eq('status', 'approved')
              as List;
      final salesYest =
          await db
                  .from('milk_sales')
                  .select('total_amount')
                  .eq('farm_id', farmId)
                  .eq('sale_date', yesterdayStr)
                  .eq('status', 'approved')
              as List;
      final payToday =
          await db
                  .from('payments')
                  .select('amount')
                  .eq('farm_id', farmId)
                  .eq('payment_date', todayStr)
                  .eq('status', 'approved')
              as List;
      final payYest =
          await db
                  .from('payments')
                  .select('amount')
                  .eq('farm_id', farmId)
                  .eq('payment_date', yesterdayStr)
                  .eq('status', 'approved')
              as List;
      final expToday =
          await db
                  .from('expenses')
                  .select('amount')
                  .eq('farm_id', farmId)
                  .eq('expense_date', todayStr)
                  .eq('status', 'approved')
              as List;
      final expYest =
          await db
                  .from('expenses')
                  .select('amount')
                  .eq('farm_id', farmId)
                  .eq('expense_date', yesterdayStr)
                  .eq('status', 'approved')
              as List;

      print('🥛 milkToday=$milkToday');
      print('🥛 milkYest=$milkYest');
      print('💰 salesToday=$salesToday');
      print('💳 payToday=$payToday');
      print('🧾 expToday=$expToday');

      final recentMilk =
          await db
                  .from('milk_production')
                  .select(
                    'quantity_liters, production_date, status, profiles!milk_production_created_by_fkey(full_name)',
                  )
                  .eq('farm_id', farmId)
                  .order('created_at', ascending: false)
                  .limit(3)
              as List;
      final recentSales =
          await db
                  .from('milk_sales')
                  .select('total_amount, sale_date, status, customers(name)')
                  .eq('farm_id', farmId)
                  .order('created_at', ascending: false)
                  .limit(3)
              as List;
      final recentPay =
          await db
                  .from('payments')
                  .select('amount, payment_date, status, customers(name)')
                  .eq('farm_id', farmId)
                  .order('created_at', ascending: false)
                  .limit(2)
              as List;
      final recentExp =
          await db
                  .from('expenses')
                  .select('amount, category, expense_date, status')
                  .eq('farm_id', farmId)
                  .order('created_at', ascending: false)
                  .limit(2)
              as List;

      print('📋 recentMilk=$recentMilk');
      print('📋 recentSales=$recentSales');
      print('📋 recentPay=$recentPay');
      print('📋 recentExp=$recentExp');

      // ── Summary ──
      milkCollected.value = _sum(milkToday, 'quantity_liters');
      milkCollectedDelta.value = _delta(
        _sum(milkToday, 'quantity_liters'),
        _sum(milkYest, 'quantity_liters'),
      );
      milkSold.value = _sum(salesToday, 'total_amount');
      milkSoldDelta.value = _delta(
        _sum(salesToday, 'total_amount'),
        _sum(salesYest, 'total_amount'),
      );
      paymentsReceived.value = _sum(payToday, 'amount');
      paymentsReceivedDelta.value = _delta(
        _sum(payToday, 'amount'),
        _sum(payYest, 'amount'),
      );
      expensesAdded.value = _sum(expToday, 'amount');
      expensesAddedDelta.value = _delta(
        _sum(expToday, 'amount'),
        _sum(expYest, 'amount'),
      );

      print(
        '📊 milkCollected=${milkCollected.value}  milkSold=${milkSold.value}  payments=${paymentsReceived.value}  expenses=${expensesAdded.value}',
      );

      // ── Activity ──
      final List<Map<String, String>> all = [];

      for (final row in recentMilk) {
        final name = (row['profiles'] as Map?)?['full_name'] ?? 'Staff';
        all.add({
          'title': 'Milk Production',
          'subtitle': '${row['quantity_liters']} L by $name',
          'timeAgo': _timeAgo(row['production_date']),
          'type': 'milkProduction',
          'status': row['status'] ?? '',
        });
      }
      for (final row in recentSales) {
        final name = (row['customers'] as Map?)?['name'] ?? 'Customer';
        all.add({
          'title': 'Milk Sale',
          'subtitle': 'Rs ${row['total_amount']} to $name',
          'timeAgo': _timeAgo(row['sale_date']),
          'type': 'milkSale',
          'status': row['status'] ?? '',
        });
      }
      for (final row in recentPay) {
        final name = (row['customers'] as Map?)?['name'] ?? 'Customer';
        all.add({
          'title': 'Payment Received',
          'subtitle': 'Rs ${row['amount']} from $name',
          'timeAgo': _timeAgo(row['payment_date']),
          'type': 'payment',
          'status': row['status'] ?? '',
        });
      }
      for (final row in recentExp) {
        all.add({
          'title': 'Expense Added',
          'subtitle': 'Rs ${row['amount']} for ${row['category']}',
          'timeAgo': _timeAgo(row['expense_date']),
          'type': 'expense',
          'status': row['status'] ?? '',
        });
      }

      activities.assignAll(all);
      print('🎉 [Dashboard] done — ${all.length} activities');
    } catch (e, stack) {
      print('❌ [Dashboard] ERROR: $e');
      print('❌ [Dashboard] STACK: $stack');
    } finally {
      isLoading.value = false;
    }
  }

  void onAddMilkProduction() => Get.toNamed(AppPages.addMilkProduction);
  void onAddMilkSale() => Get.toNamed(AppPages.addMilkSale);
  void onAddPayment() => Get.toNamed(AppPages.addPayment);
  void onAddExpense() => Get.toNamed(AppPages.addExpanse);

  String _dateStr(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  double _sum(List rows, String field) {
    if (rows.isEmpty) return 0.0;
    return rows.fold(
      0.0,
      (sum, row) => sum + ((row[field] ?? 0) as num).toDouble(),
    );
  }

  double _delta(double today, double yesterday) {
    if (yesterday == 0) return today > 0 ? 100.0 : 0.0;
    return ((today - yesterday) / yesterday) * 100;
  }

  String _timeAgo(String? dateStr) {
    if (dateStr == null) return '';
    try {
      final date = DateTime.parse(dateStr);
      final diff = DateTime.now().difference(date).inDays;
      if (diff == 0) return 'Today';
      if (diff == 1) return 'Yesterday';
      return '$diff days ago';
    } catch (_) {
      return '';
    }
  }
}
