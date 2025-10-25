import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/villa_provider.dart';
import '../widgets/gaps.dart';
import 'business_unit_properties_screen.dart';
import '../providers/property_detail_provider.dart';
import 'property_detail_screen.dart';
class ClaimedVillasScreen extends StatefulWidget {
  const ClaimedVillasScreen({super.key});

  @override
  State<ClaimedVillasScreen> createState() => _ClaimedVillasScreenState();
}

class _ClaimedVillasScreenState extends State<ClaimedVillasScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<VillaProvider>(context, listen: false).loadVillas();
    });
  }

  Future<void> _logout() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.logout();
    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  void _showVillaDetailsBottomSheet(BuildContext context, dynamic villa) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PropertyDetailBottomSheet(
        villaId: villa.id?.toString() ?? '',
        villa: villa,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Claimed Villas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Consumer<VillaProvider>(
        builder: (context, villaProvider, child) {
          if (villaProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (villaProvider.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red[300],
                  ),
                  const VerticalGap(16),
                  Text(
                    villaProvider.errorMessage!,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const VerticalGap(24),
                  ElevatedButton.icon(
                    onPressed: () => villaProvider.loadVillas(),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (villaProvider.villas.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.home_work_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const VerticalGap(16),
                  Text(
                    'No villas found',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                  const VerticalGap(24),
                  ElevatedButton.icon(
                    onPressed: () => villaProvider.loadVillas(),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Refresh'),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => villaProvider.loadVillas(),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: villaProvider.villas.length,
              itemBuilder: (context, index) {
                final villa = villaProvider.villas[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: InkWell(
                    onTap: () {
                      _showVillaDetailsBottomSheet(context, villa);
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.home_work,
                              size: 40,
                              color: Colors.grey[600],
                            ),
                          ),
                          const HorizontalGap(16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  villa.name ?? 'Unnamed Villa',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const VerticalGap(4),
                                if (villa.distance != null)
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        size: 16,
                                        color: Colors.grey[600],
                                      ),
                                      const HorizontalGap(4),
                                      Text(
                                        '${villa.distance} km away',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                const VerticalGap(8),
                                if (villa.currencyCode != null)
                                  Text(
                                    'Currency: ${villa.currencyCode}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                              ],
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BusinessUnitPropertiesScreen(
                                    businessUnitId: villa.businessUnitId?.toString(),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Icon(
                                Icons.chevron_right,
                                color: Colors.grey[400],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}