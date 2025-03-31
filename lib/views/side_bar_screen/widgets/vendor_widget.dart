import 'package:admin_panel_app_web/controllers/vendor_controller.dart';
import 'package:admin_panel_app_web/models/vendor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VendorWidget extends StatefulWidget {
  const VendorWidget({super.key});

  @override
  State<VendorWidget> createState() => _BuyerWidggetStates();
}

class _BuyerWidggetStates extends State<VendorWidget> {
  late Future<List<Vendor>> futureVendors;

  @override
  void initState() {
    super.initState();
    futureVendors = VendorController().loadVendors();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Vendor>>(
      future: futureVendors,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No Vendors Found"));
        } else {
          final vendors = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16), // Cách trái/phải 16px
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 16, // Tăng khoảng cách giữa các cột
                mainAxisSpacing: 16, // Tăng khoảng cách giữa các hàng
                childAspectRatio: 0.8,
              ),
              itemCount: vendors.length,
              itemBuilder: (context, index) {
                final vendor = vendors[index];
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
                          vendor.fullName[0],
                          style: GoogleFonts.montserrat(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        vendor.fullName,
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        vendor.email,
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        vendor.address,
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          color: Colors.grey[700],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        vendor.phone,
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          color: Colors.grey[700],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          // xử lý xóa
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
