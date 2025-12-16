import 'package:flutter/material.dart';

void main() {
  runApp(const AlSwadiApp());
}

class AlSwadiApp extends StatelessWidget {
  const AlSwadiApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Al-swadi Pro',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLocked = false;
  String passwordInput = '';
  final String correctPassword = 'Alswadi773500';

  final TextEditingController dateController = TextEditingController();
  final TextEditingController clinicIncomeController = TextEditingController();
  final TextEditingController pharmacyIncomeController = TextEditingController();
  final TextEditingController companiesPaymentController = TextEditingController();
  final TextEditingController cashPurchasesController = TextEditingController();
  final TextEditingController expensesController = TextEditingController();

  List<Map<String, dynamic>> transactions = [];

  @override
  void initState() {
    super.initState();
    dateController.text = DateTime.now().toString().split(' ')[0];
  }

  void calculateAndAddTransaction() {
    try {
      double clinicIncome = double.parse(clinicIncomeController.text.isEmpty ? '0' : clinicIncomeController.text);
      double pharmacyIncome = double.parse(pharmacyIncomeController.text.isEmpty ? '0' : pharmacyIncomeController.text);
      double companiesPayment = double.parse(companiesPaymentController.text.isEmpty ? '0' : companiesPaymentController.text);
      double cashPurchases = double.parse(cashPurchasesController.text.isEmpty ? '0' : cashPurchasesController.text);
      double expenses = double.parse(expensesController.text.isEmpty ? '0' : expensesController.text);

      double finalTotal = clinicIncome + pharmacyIncome - companiesPayment - cashPurchases - expenses;

      setState(() {
        transactions.add({
          'date': dateController.text,
          'clinicIncome': clinicIncome,
          'pharmacyIncome': pharmacyIncome,
          'companiesPayment': companiesPayment,
          'cashPurchases': cashPurchases,
          'expenses': expenses,
          'finalTotal': finalTotal,
        });
      });

      clinicIncomeController.clear();
      pharmacyIncomeController.clear();
      companiesPaymentController.clear();
      cashPurchasesController.clear();
      expensesController.clear();
      dateController.text = DateTime.now().toString().split(' ')[0];

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم إضافة المعاملة بنجاح')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ: $e')),
      );
    }
  }

  void unlockSystem() {
    if (passwordInput == correctPassword) {
      setState(() {
        isLocked = false;
        passwordInput = '';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم فتح القفل بنجاح')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('كلمة المرور غير صحيحة')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLocked) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'النظام مقفول',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red),
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(height: 20),
                TextField(
                  obscureText: true,
                  onChanged: (value) => passwordInput = value,
                  decoration: InputDecoration(
                    labelText: 'كلمة المرور',
                    border: OutlineInputBorder(),
                    textDirection: TextDirection.rtl,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: unlockSystem,
                  child: const Text('فتح القفل'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('نظام Al-swadi Pro'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'إضافة معاملة جديدة',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: dateController,
                decoration: InputDecoration(
                  labelText: '1. التاريخ',
                  border: OutlineInputBorder(),
                  textDirection: TextDirection.rtl,
                ),
                textDirection: TextDirection.rtl,
                readOnly: true,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: clinicIncomeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: '2. دخل العيادة',
                  border: OutlineInputBorder(),
                  textDirection: TextDirection.rtl,
                ),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: pharmacyIncomeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: '3. دخل الصيدلية',
                  border: OutlineInputBorder(),
                  textDirection: TextDirection.rtl,
                ),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: companiesPaymentController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: '4. سداد الشركات',
                  border: OutlineInputBorder(),
                  textDirection: TextDirection.rtl,
                ),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: cashPurchasesController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: '5. مشتريات نقدية',
                  border: OutlineInputBorder(),
                  textDirection: TextDirection.rtl,
                ),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: expensesController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: '6. المصروفات',
                  border: OutlineInputBorder(),
                  textDirection: TextDirection.rtl,
                ),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: calculateAndAddTransaction,
                  child: const Text('إضافة المعاملة'),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'المعاملات اليومية',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 10),
              transactions.isEmpty
                  ? const Text('لا توجد معاملات حتى الآن', textDirection: TextDirection.rtl)
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: transactions.length,
                      itemBuilder: (context, index) {
                        final transaction = transactions[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'التاريخ: ${transaction['date']}',
                                  textDirection: TextDirection.rtl,
                                ),
                                Text(
                                  'دخل العيادة: ${transaction['clinicIncome'].toStringAsFixed(2)}',
                                  textDirection: TextDirection.rtl,
                                ),
                                Text(
                                  'دخل الصيدلية: ${transaction['pharmacyIncome'].toStringAsFixed(2)}',
                                  textDirection: TextDirection.rtl,
                                ),
                                Text(
                                  'سداد الشركات: ${transaction['companiesPayment'].toStringAsFixed(2)}',
                                  textDirection: TextDirection.rtl,
                                ),
                                Text(
                                  'مشتريات نقدية: ${transaction['cashPurchases'].toStringAsFixed(2)}',
                                  textDirection: TextDirection.rtl,
                                ),
                                Text(
                                  'المصروفات: ${transaction['expenses'].toStringAsFixed(2)}',
                                  textDirection: TextDirection.rtl,
                                ),
                                const Divider(),
                                Text(
                                  'الإجمالي النهائي: ${transaction['finalTotal'].toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                    fontSize: 16,
                                  ),
                                  textDirection: TextDirection.rtl,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isLocked = true;
          });
        },
        tooltip: 'قفل النظام',
        child: const Icon(Icons.lock),
      ),
    );
  }

  @override
  void dispose() {
    dateController.dispose();
    clinicIncomeController.dispose();
    pharmacyIncomeController.dispose();
    companiesPaymentController.dispose();
    cashPurchasesController.dispose();
    expensesController.dispose();
    super.dispose();
  }
}
