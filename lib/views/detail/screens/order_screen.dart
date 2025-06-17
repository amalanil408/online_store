import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_store/controllers/order_controller.dart';
import 'package:online_store/core/themes/colors.dart';
import 'package:online_store/core/widgets/common_widget.dart';
import 'package:online_store/models/order_model.dart';
import 'package:online_store/provider/order_provider.dart';
import 'package:online_store/provider/user_provider.dart';
import 'package:online_store/views/detail/screens/order_detail_screen.dart';

class OrderScreen extends ConsumerStatefulWidget {
  const OrderScreen({super.key});

  @override
  ConsumerState<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends ConsumerState<OrderScreen> {
  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    final user = ref.read(userProvider);
    if (user != null) {
      final OrderController orderController = OrderController();
      try {
        final orders = await orderController.loadOrder(
          buyerId: user.id,
          context: context,
        );
        ref.read(orderProvider.notifier).setOrders(orders);
      } catch (e) {
        throw Exception("Error fetching orders : $e");
      }
    }
  }

  Future<void> _deleteOrder(String orderId) async {
    final OrderController orderController = OrderController();
    try {
      await orderController.deletedOrder(id: orderId, context: context);
      _fetchOrders();
    } catch (e) {
      throw Exception("Error deleting orders : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final orders = ref.watch(orderProvider);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.20), 
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 118,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/icons/cartb.png'),fit: BoxFit.cover)
          ),
          child: Stack(
            children: [
              Positioned(
                left: 322,
                top: 52,
                child: Stack(
                  children: [
                    Image.asset('assets/icons/not.png',width: 25,height: 25,),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: 20,
                        height: 20,
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.yellow.shade800,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(child: Text(orders.length.toString(),style: TextStyle(color: whiteColor,fontWeight: FontWeight.bold,fontSize: 11),),),
                      )
                      )
                  ],
                )
                ),
                Positioned(
                  left: 61,
                  top: 51,
                  child: Text(
                    "My Orders",style: GoogleFonts.lato(
                      fontSize: 18,
                      color: whiteColor,
                      fontWeight: FontWeight.bold
                    ),
                  )
                  )
            ],
          ),
        )
        ),
      body:
          orders.isEmpty
              ? Center(child: Text("No Order Found"))
              : ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final OrderModel order = orders[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 25,
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => OrderDetailScreen(order: order)));
                      },
                      child: Container(
                        width: 335,
                        height: 153,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(),
                        child: SizedBox(
                          width: double.infinity,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 336,
                                  height: 154,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    color: whiteColor,
                                    border: Border.all(color: Color(0xFFEFF0F2)),
                                    borderRadius: BorderRadius.circular(9),
                                  ),
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Positioned(
                                        left: 13,
                                        top: 9,
                                        child: Container(
                                          width: 78,
                                          height: 78,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFBCC5FF),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              Positioned(
                                                left: 10,
                                                top: 5,
                                                child: Image.network(
                                                  order.image,
                                                  width: 58,
                                                  height: 67,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 101,
                                        top: 14,
                                        child: SizedBox(
                                          width: 216,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: SizedBox(
                                                  width: double.infinity,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      SizedBox(
                                                        width: double.infinity,
                                                        child: Text(
                                                          order.productName,
                                                          style:
                                                              GoogleFonts.montserrat(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17,
                                                              ),
                                                        ),
                                                      ),
                                                      customSizedBox(heigh: 4),
                                                      Align(
                                                        alignment:
                                                            Alignment.centerLeft,
                                                        child: Text(
                                                          order.category,
                                                          style:
                                                              GoogleFonts.montserrat(
                                                                color: Color(
                                                                  0xFF7F808C,
                                                                ),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                        ),
                                                      ),
                                                      customSizedBox(heigh: 2),
                                                      Align(
                                                        alignment:
                                                            Alignment.centerLeft,
                                                        child: Text(
                                                          "\$${order.productPrice.toStringAsFixed(2)}",
                                                          style:
                                                              GoogleFonts.montserrat(
                                                                fontSize: 15,
                                                                color: Color(
                                                                  0xFF0B0C1E,
                                                                ),
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 13,
                                        top: 113,
                                        child: Container(
                                          width: 100,
                                          height: 25,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            color:
                                                order.delivered == true
                                                    ? Color(0xFF3C55Ef)
                                                    : order.processing == true
                                                    ? Colors.purple
                                                    : Colors.red,
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                          ),
                                          child: Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              Positioned(
                                                left: 9,
                                                top: 3,
                                                child: Text(
                                                  order.delivered == true
                                                      ? "Delivered"
                                                      : order.processing == true
                                                      ? "Processing"
                                                      : "Cancelled",
                                                  style: GoogleFonts.montserrat(
                                                    color: whiteColor,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 1.3,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      order.delivered == true ? SizedBox() : Positioned(
                                        top: 115,
                                        left: 278,
                                        child: InkWell(
                                          onTap: () {
                                            _deleteOrder(order.id);
                                          },
                                          child: Image.asset('assets/icons/delete.png',
                                          width: 20,
                                          height: 20,
                                          ),
                                        )
                                        )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
