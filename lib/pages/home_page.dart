import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/location_provider.dart';

final starProvider =
StateProvider.family<int, int>((ref, index) => 0);

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationAsync = ref.watch(locationProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Location List')),
      body: locationAsync.when(
        loading: () =>
        const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (locations) => ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: locations.length,
          itemBuilder: (context, index) {
            final location = locations[index];

            /// INIT STAR = DATA STAR (CHỈ 1 LẦN)
            final starState = ref.watch(starProvider(index));
            if (starState == 0) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ref.read(starProvider(index).notifier).state =
                    location.countStar;
              });
            }

            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// IMAGE
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        location.imageUrl,
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(height: 8),

                    /// 🔥 TITLE + STAR + VIEW DETAIL (CÙNG HÀNG)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                location.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                location.address,
                                style: TextStyle(
                                    color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ),

                        /// STAR (TĂNG LIÊN TỤC)
                        GestureDetector(
                          onTap: () {
                            ref
                                .read(starProvider(index).notifier)
                                .state++;
                          },
                          child: Row(
                            children: [
                              const Icon(Icons.star,
                                  color: Colors.red),
                              const SizedBox(width: 4),
                              Text(
                                '${ref.watch(starProvider(index))}',
                                style:
                                const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 12),

                        /// VIEW DETAIL
                        TextButton(
                          onPressed: () {
                            // TODO: Navigator.push(...)
                          },
                          child: const Text('View Detail'),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    /// DESCRIPTION (GIỮA)
                    Center(
                      child: Text(
                        location.description ?? '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.grey[700]),
                      ),
                    ),

                    const SizedBox(height: 12),
                    const Divider(),

                    /// ACTIONS
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceAround,
                      children: const [
                        _ActionItem(
                            icon: Icons.call, label: 'CALL'),
                        _ActionItem(
                            icon: Icons.navigation,
                            label: 'ROUTE'),
                        _ActionItem(
                            icon: Icons.share,
                            label: 'SHARE'),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ActionItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ActionItem(
      {required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue),
        const SizedBox(height: 4),
        Text(label,
            style:
            const TextStyle(color: Colors.blue, fontSize: 12)),
      ],
    );
  }
}
