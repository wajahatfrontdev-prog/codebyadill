import 'package:flutter/material.dart';
import 'package:icare/screens/order_tracking.dart';
import 'package:icare/utils/imagePaths.dart';
import 'package:icare/utils/theme.dart';
import 'package:icare/widgets/back_button.dart';
import 'package:icare/widgets/custom_text.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isWeb = MediaQuery.of(context).size.width > 900;
    
    final List<Map<String, dynamic>> orders = [
      {
        "id": "ORD-5521",
        "status": "Delivered",
        "color": const Color(0xFF10B981),
        "products": [
          {"name": "Liver Cleanse", "image": ImagePaths.capsule},
        ],
        "pharmacy": "Green Pharma",
        "date": "22 Sep 2025",
        "amount": "2,000",
        "qty": 1,
        "isDelivered": true,
      },
      {
        "id": "ORD-5522",
        "status": "In Transit",
        "color": const Color(0xFFF59E0B),
        "products": [
          {"name": "Vitamin C", "image": ImagePaths.capsule2},
        ],
        "pharmacy": "HealthCare Plus",
        "date": "24 Sep 2025",
        "amount": "1,500",
        "qty": 2,
        "isDelivered": false,
      },
      {
        "id": "ORD-5523",
        "status": "Processing",
        "color": const Color(0xFF6366F1),
        "products": [
          {"name": "Pain Relief", "image": ImagePaths.capsule},
          {"name": "Syrup", "image": ImagePaths.capsule2},
        ],
        "pharmacy": "City Pharmacy",
        "date": "25 Sep 2025",
        "amount": "3,200",
        "qty": 3,
        "isDelivered": false,
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFD),
      body: CustomScrollView(
        slivers: [
          // Stunning Header
          SliverAppBar(
            expandedHeight: 220,
            floating: true,
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 0,
            leading: const CustomBackButton(),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primaryColor.withOpacity(0.05), Colors.white],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(isWeb ? 60 : 20, 40, isWeb ? 60 : 40, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomText(
                        text: "PURCHASE HISTORY",
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        color: AppColors.primaryColor,
                        letterSpacing: 2,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CustomText(
                              text: "My Personal Orders",
                              fontSize: isWeb ? 36 : 24,
                              fontWeight: FontWeight.w900,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          if (isWeb)
                            _buildHeaderStats(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Search and Filters (Web only)
          if (isWeb)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 24),
                child: Row(
                  children: [
                    _buildFilterChip("All Orders", true),
                    const SizedBox(width: 12),
                    _buildFilterChip("Delivered", false),
                    const SizedBox(width: 12),
                    _buildFilterChip("Pending", false),
                    const Spacer(),
                    _buildSearchBar(),
                  ],
                ),
              ),
            ),

          // Orders Content
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: isWeb ? 60 : 20,
              vertical: isWeb ? 0 : 20,
            ),
            sliver: isWeb 
              ? SliverGrid(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 550,
                    mainAxisExtent: 280,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (ctx, i) => _buildModernOrderCard(context, orders[i], isWeb),
                    childCount: orders.length,
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (ctx, i) => _buildModernOrderCard(context, orders[i], isWeb),
                    childCount: orders.length,
                  ),
                ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }

  Widget _buildHeaderStats() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: const [
          Icon(Icons.shopping_bag_rounded, size: 16, color: Color(0xFF64748B)),
          SizedBox(width: 8),
          Text("Total: 24 Orders", style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
          SizedBox(width: 12),
          Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: Color(0xFF64748B)),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      width: 300,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: "Search an order...",
          prefixIcon: Icon(Icons.search_rounded, size: 20, color: Color(0xFF94A3B8)),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryColor : Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: isActive ? AppColors.primaryColor : const Color(0xFFE2E8F0)),
        boxShadow: isActive ? [BoxShadow(color: AppColors.primaryColor.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 4))] : null,
      ),
      child: CustomText(
        text: label,
        color: isActive ? Colors.white : const Color(0xFF64748B),
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildModernOrderCard(BuildContext context, Map<String, dynamic> order, bool isWeb) {
    return Container(
      margin: EdgeInsets.only(bottom: isWeb ? 0 : 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              // Product Image Display
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image.asset(order['products'][0]['image'], height: 48, width: 48),
              ),
              const SizedBox(width: 20),
              // Order Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: order['products'][0]['name'],
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF0F172A),
                    ),
                    const SizedBox(height: 4),
                    CustomText(
                      text: "${order['pharmacy']} • Qty: ${order['qty']}",
                      fontSize: 13,
                      color: const Color(0xFF64748B),
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
              // Status Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: order['color'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: CustomText(
                  text: order['status'],
                  color: order['color'],
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: order['isDelivered'] ? "Delivered on ${order['date']}" : "Order Date: ${order['date']}",
                    fontSize: 12,
                    color: order['isDelivered'] ? const Color(0xFF10B981) : const Color(0xFF94A3B8),
                    fontWeight: FontWeight.w600,
                  ),
                  CustomText(
                    text: "RS. ${order['amount']}",
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: AppColors.primaryColor,
                  ),
                ],
              ),
              if (!order['isDelivered'])
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const OrderTrackingScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Track Order", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                )
              else
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFFF1F5F9),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Reorder", style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.w700, fontSize: 13)),
                ),
            ],
          ),
        ],
      ),
    );
  }
}