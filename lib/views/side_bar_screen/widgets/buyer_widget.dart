import 'package:admin_panel_app_web/controllers/buyer_controller.dart';
import 'package:admin_panel_app_web/models/buyer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuyerWidget extends StatefulWidget {
  const BuyerWidget({super.key});

  @override
  State<BuyerWidget> createState() => _BuyerWidggetStates();
}

class _BuyerWidggetStates extends State<BuyerWidget> {
  late Future<List<Buyer>> futureBuyers;

  @override
  void initState() {
    super.initState();
    futureBuyers = BuyerController().loadBuyer();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Buyer>>(
      future: futureBuyers,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No Buyers Found"));
        } else {
          final buyers = snapshot.data!;
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16), // Cách trái/phải
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // 4 thẻ mỗi hàng
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              itemCount: buyers.length,
              itemBuilder: (context, index) {
                final buyer = buyers[index];
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.blueAccent,
                        child: Text(
                          buyer.fullName[0],
                          style: GoogleFonts.montserrat(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        buyer.fullName,
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${buyer.state}, ${buyer.city}",
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          color: Colors.grey[700],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        buyer.email,
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          // TODO: xử lý xóa Buyer
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(50, 30),
                        ),
                        child: const Text("Delete",
                            style: TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
