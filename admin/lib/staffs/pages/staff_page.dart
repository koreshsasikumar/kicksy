import 'package:admin/appTheme/app_color.dart';
import 'package:admin/extension/extension.dart';
import 'package:admin/staffs/pages/add_staff_layout.dart';
import 'package:admin/staffs/provider/staffs_provider.dart';
import 'package:admin/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StaffsPage extends ConsumerStatefulWidget {
  const StaffsPage({super.key});
  @override
  ConsumerState<StaffsPage> createState() => _StaffsPageState();
}

class _StaffsPageState extends ConsumerState<StaffsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.watch(staffsProvider.notifier).fetchStaffs());
  }

  @override
  Widget build(BuildContext context) {
    final staffNotifier = ref.read(staffsProvider.notifier);
    final theme = Theme.of(context);
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      body: Padding(
        padding: 16.padAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Staff',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: 100,
                  height: 40,
                  child: CustomButton(
                    backgroundColor: AppColor.secondaryColor,
                    onPressed: () {
                      scaffoldKey.currentState?.openEndDrawer();
                    },
                    child: const Text(
                      "Add Staff",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            20.height,
            Consumer(
              builder: (context, ref, child) {
                final staffState = ref.watch(staffsProvider);
                return Expanded(
                  child: staffState.isLoading
                      ? Center(child: CircularProgressIndicator())
                      : staffState.staffList.isEmpty
                      ? const Center(
                          child: Text(
                            "No staff members found.",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        )
                      : DataTable(
                          columns: [
                            DataColumn(label: Text('S.no')),
                            DataColumn(label: Text('Profile')),
                            DataColumn(label: Text('Name')),
                            DataColumn(label: Text('Email')),
                            DataColumn(label: Text('phone Number')),
                            DataColumn(label: Text('Active')),
                            DataColumn(label: Text('Delete')),
                          ],
                          rows: List.generate(staffState.staffList.length, (
                            index,
                          ) {
                            final staff = staffState.staffList[index];
                            final imageUrl = staff['imageUrl'] ?? '';

                            return DataRow(
                              cells: [
                                DataCell(Text('${index + 1}')),
                                DataCell(
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.grey.shade300,
                                    backgroundImage: (imageUrl.isNotEmpty)
                                        ? NetworkImage(imageUrl)
                                        : null,
                                    child: (imageUrl.isEmpty)
                                        ? const Icon(
                                            Icons.person,
                                            color: Colors.white,
                                          )
                                        : null,
                                  ),
                                ),

                                DataCell(Text(staff['name'] ?? '')),
                                DataCell(Text(staff['email'] ?? '')),
                                DataCell(Text(staff['phoneNumber'] ?? '')),
                                DataCell(
                                  Icon(
                                    staff['isActive'] == true
                                        ? Icons.check_circle
                                        : Icons.cancel,
                                    color: staff['isActive'] == true
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ),
                                DataCell(
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () async {
                                      await staffNotifier.deleteStaff(
                                        staff['id'],
                                      );
                                      await staffNotifier.fetchStaffs();
                                    },
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                );
              },
            ),
          ],
        ),
      ),
      endDrawer: AddStaffLayout(),
    );
  }
}
