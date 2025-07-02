import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart' as pie_chart_package;
import 'package:fl_chart/fl_chart.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFD9D9D9),
        title: Row(
          children: [
            const Text(
              'Care',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const Text(
              'Connect',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {},
              child: const Text('Dashboard', style: TextStyle(color: Colors.blue)),
            ),
            const SizedBox(width: 16),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/users_list');
              },
              child: const Text('Users List', style: TextStyle(color: Colors.black)),
            ),
            const Spacer(),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.black),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black),
            onPressed: () {
              Navigator.pushNamed(context, '/home_screen');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Wrap(
              spacing: 24,
              runSpacing: 24,
              alignment: WrapAlignment.center,
              children: [
                _buildStatCard('Total Users', '467', Icons.people, Colors.teal.shade100),
                _buildStatCard('Old Adults', '354', Icons.person, Colors.green.shade100),
                _buildStatCard('Caregivers', '57', Icons.health_and_safety, Colors.blue.shade100),
                _buildStatCard('Family Members', '56', Icons.family_restroom, Colors.lightBlue.shade100),
              ],
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: _buildUserGrowthLineChart(context),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildUserGrowthCard(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color backgroundColor) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 56, color: Colors.black54),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityCard(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        height: MediaQuery.of(context).size.width / 5.5,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Recent Activity',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text('• 4h ago Family Member account created'),
              Text('• 6h ago Old Adult account created'),
              Text('• 7h ago Old Adult account deleted'),
              Text('• 12h ago Family Member account created'),
              Text('• Yesterday Caregiver account created'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserGrowthCard(BuildContext context) {
    final dataMap = {
      "Old Adults": 76.0,
      "Caregivers": 12.0,
      "Family Members": 12.0,
    };

    final colorList = [
      Colors.green,
      Colors.blue,
      Colors.orange,
      Colors.red,
    ];

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        height: MediaQuery.of(context).size.width / 5.5,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'User Distribution',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: pie_chart_package.PieChart(
                        dataMap: dataMap,
                        animationDuration: const Duration(milliseconds: 800),
                        chartLegendSpacing: 16,
                        chartRadius: MediaQuery.of(context).size.width / 7.0,
                        colorList: colorList,
                        chartType: pie_chart_package.ChartType.disc,
                        legendOptions: const pie_chart_package.LegendOptions(
                          showLegendsInRow: false,
                          legendPosition: pie_chart_package.LegendPosition.right,
                          showLegends: true,
                          legendShape: BoxShape.circle,
                          legendTextStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        chartValuesOptions: const pie_chart_package.ChartValuesOptions(
                          showChartValueBackground: true,
                          showChartValues: true,
                          showChartValuesInPercentage: true,
                          showChartValuesOutside: false,
                          decimalPlaces: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserGrowthLineChart(BuildContext context) {
    final List<FlSpot> userGrowthData = [
      FlSpot(0, 50),
      FlSpot(1, 100),
      FlSpot(2, 150),
      FlSpot(3, 220),
      FlSpot(4, 300),
      FlSpot(5, 380),
      FlSpot(6, 467),
      FlSpot(7, 500),
      FlSpot(8, 530),
      FlSpot(9, 560),
      FlSpot(10, 590),
      FlSpot(11, 620),
      FlSpot(12, 650),
      FlSpot(13, 680),
      FlSpot(14, 710),
      FlSpot(15, 740),
      FlSpot(16, 770),
      FlSpot(17, 800),
      FlSpot(18, 830),
      FlSpot(19, 860),
      FlSpot(20, 890),
      FlSpot(21, 920),
      FlSpot(22, 950),
    ];

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        height: MediaQuery.of(context).size.width / 5.5,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'User Growth Over Time',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(show: false),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            if (value % 100 == 0) {
                              return Text('${value.toInt()}', style: const TextStyle(fontSize: 12));
                            }
                            return const SizedBox.shrink();
                          },
                          reservedSize: 40,
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            if (value % 5 == 0) {
                              return Text('Day ${value.toInt() + 1}', style: const TextStyle(fontSize: 12));
                            }
                            return const SizedBox.shrink();
                          },
                          reservedSize: 30,
                        ),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    lineBarsData: [
                      LineChartBarData(
                        spots: userGrowthData,
                        isCurved: true,
                        barWidth: 4,
                        color: Colors.blue,
                        belowBarData: BarAreaData(show: true, color: Colors.blue.withOpacity(0.2)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
