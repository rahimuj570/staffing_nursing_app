import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart'; // Ensure you have intl package in pubspec.yaml for clean date formatting
import 'package:remixicon/remixicon.dart';
import 'package:staffing/app/constants/app_colors.dart';
import 'package:staffing/features/common_features/widgets/custom_dropdown_field_widget.dart';
import 'package:staffing/features/common_features/widgets/custom_elevated_button_widget.dart';
import 'package:staffing/features/common_features/widgets/custom_text_field_widget.dart';
import 'package:table_calendar/table_calendar.dart';

class FilterShiftView extends StatefulWidget {
  const FilterShiftView({super.key});

  @override
  State<FilterShiftView> createState() => _FilterShiftViewState();
}

class _FilterShiftViewState extends State<FilterShiftView> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  // Helper method to dynamically generate the button label text
  String _getDateRangeText() {
    final DateFormat formatter = DateFormat('MMM dd, yyyy');
    if (_rangeStart != null && _rangeEnd != null) {
      return '${formatter.format(_rangeStart!)} - ${formatter.format(_rangeEnd!)}';
    } else if (_rangeStart != null) {
      return formatter.format(_rangeStart!);
    } else if (_selectedDay != null) {
      return formatter.format(_selectedDay!);
    }
    return 'Date'; // Default fallback text
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController locationTEC = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text('Filter Shifts')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            customTextFieldWidget(
              prefixIcon: RemixIcons.map_pin_2_line,
              label: '',
              controller: locationTEC,
              textInputType: TextInputType.text,
              placeHolder: 'Current Location',
              suffixIcon: RemixIcons.crosshair_2_line,
              onSuffixTap: () {},
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          // FIX: SingleChildScrollView allows the Dialog to shrinkwrap exactly to the calendar height
                          child: SingleChildScrollView(
                            child: StatefulBuilder(
                              builder: (context, dialogSetState) => TableCalendar(
                                firstDay: DateTime.utc(
                                  DateTime.now().year,
                                  DateTime.now().month,
                                  DateTime.now().day,
                                ),
                                lastDay: DateTime.utc(2030, 12, 31),
                                focusedDay: _focusedDay,
                                selectedDayPredicate: (day) =>
                                    isSameDay(_selectedDay, day),
                                rangeStartDay: _rangeStart,
                                rangeEndDay: _rangeEnd,
                                rangeSelectionMode: _rangeSelectionMode,
                                onDaySelected: (selectedDay, focusedDay) {
                                  // Sync state to dialog layout
                                  dialogSetState(() {
                                    _selectedDay = selectedDay;
                                    _focusedDay = focusedDay;
                                  });
                                  // Sync state back to outer screen view layout
                                  setState(() {});
                                },
                                onRangeSelected: (start, end, focusedDay) {
                                  dialogSetState(() {
                                    _rangeStart = start;
                                    _rangeEnd = end;
                                    _focusedDay = focusedDay;
                                  });
                                  setState(() {});
                                },
                                headerStyle: const HeaderStyle(
                                  formatButtonVisible: false,
                                  titleCentered: true,
                                  leftChevronIcon: Icon(Icons.chevron_left),
                                  rightChevronIcon: Icon(Icons.chevron_right),
                                ),
                                calendarStyle: CalendarStyle(
                                  rangeHighlightColor: AppColors.themeColor
                                      .withValues(alpha: 0.15),
                                  rangeStartDecoration: BoxDecoration(
                                    color: AppColors.themeColor,
                                    shape: BoxShape.circle,
                                  ),
                                  rangeEndDecoration: BoxDecoration(
                                    color: AppColors.themeColor,
                                    shape: BoxShape.circle,
                                  ),
                                  todayDecoration: BoxDecoration(
                                    color: AppColors.themeColor.withValues(
                                      alpha: 0.3,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  selectedDecoration: BoxDecoration(
                                    color: AppColors.themeColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.themeColor,
                          width: 1.5,
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.0.r),
                        child: Row(
                          children: [
                            // FIX: Text label is now evaluated dynamically
                            Expanded(
                              child: Text(
                                _getDateRangeText(),
                                style: TextStyle(
                                  overflow: .ellipsis,
                                  color: AppColors.themeColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              RemixIcons.calendar_line,
                              color: AppColors.themeColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: CustomDropdownFieldWidget(
                    label: 'Profession',
                    value: 'RN',
                    items: ['RN', 'LPN', 'CNA'],
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: CustomDropdownFieldWidget(
                    label: 'Shift Type',
                    value: 'All',
                    items: ['All', 'Morning', 'Afternoon', 'Evening', 'Night'],
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: CustomDropdownFieldWidget(
                    label: 'Pay Range',
                    value: '\$20+/hr',
                    items: [
                      '\$20+/hr',
                      '\$30+/hr',
                      '\$40+/hr',
                      '\$50+/hr',
                      '\$60+/hr',
                      '\$70+/hr',
                      '\$80+/hr',
                      '\$100+/hr',
                    ],
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
            SizedBox(height: 32.h),
            customElevatedButtonWidget(text: 'Apply Filter', onTapped: () {}),
          ],
        ),
      ),
    );
  }
}
