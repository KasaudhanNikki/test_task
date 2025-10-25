import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/property_detail_provider.dart';
import '../widgets/gaps.dart';

class PropertyDetailBottomSheet extends StatefulWidget {
  final String villaId;
  final dynamic villa;

  const PropertyDetailBottomSheet({
    Key? key,
    required this.villaId,
    required this.villa,
  }) : super(key: key);

  @override
  State<PropertyDetailBottomSheet> createState() =>
      _PropertyDetailBottomSheetState();
}

class _PropertyDetailBottomSheetState extends State<PropertyDetailBottomSheet> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.villaId.isNotEmpty) {
        context
            .read<PropertyDetailProvider>()
            .loadPropertyDetail(widget.villaId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PropertyDetailProvider>(
      builder: (context, provider, child) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Expanded(
                child: provider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : provider.errorMessage != null
                    ? _buildErrorState(provider.errorMessage!)
                    : _buildContentState(provider.propertyDetail),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildErrorState(String errorMessage) {
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
            errorMessage,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const VerticalGap(24),
          ElevatedButton.icon(
            onPressed: () {
              context
                  .read<PropertyDetailProvider>()
                  .loadPropertyDetail(widget.villaId);
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildContentState(propertyDetail) {
    if (propertyDetail == null) {
      return const Center(
        child: Text('No property details available'),
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (propertyDetail.image != null && propertyDetail.image!.isNotEmpty)
            Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  propertyDetail.image!,
                  height: 250,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Center(
                    child: Icon(
                      Icons.image_not_supported,
                      size: 64,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ),
            )
          else
            Container(
              height: 250,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Icon(
                  Icons.home_work,
                  size: 80,
                  color: Colors.grey[600],
                ),
              ),
            ),
          const VerticalGap(16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              propertyDetail.name ?? 'Unnamed Property',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const VerticalGap(8),
          if (widget.villa.distance != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Icon(Icons.location_on, size: 20, color: Colors.grey[600]),
                  const HorizontalGap(8),
                  Text(
                    '${widget.villa.distance} km away',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          const VerticalGap(16),
          if (widget.villa.currencyCode != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Icon(Icons.currency_exchange,
                      size: 20, color: Colors.grey[600]),
                  const HorizontalGap(8),
                  Text(
                    'Currency: ${widget.villa.currencyCode}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          const VerticalGap(24),
          if (propertyDetail.id != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Property ID',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    propertyDetail.id.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    context.read<PropertyDetailProvider>().clearPropertyDetail();
    super.dispose();
  }
}