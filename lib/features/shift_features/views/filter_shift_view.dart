import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart'; // Ensure you have intl package in pubspec.yaml for clean date formatting
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';
import 'package:staffing/app/constants/app_colors.dart';
import 'package:staffing/app/extensions/route.dart';
import 'package:staffing/app/network/network_response_model.dart';
import 'package:staffing/app/utils/show_status_snackbar_util.dart';
import 'package:staffing/features/common_features/widgets/custom_dropdown_field_widget.dart';
import 'package:staffing/features/common_features/widgets/custom_elevated_button_widget.dart';
import 'package:staffing/features/common_features/widgets/custom_text_field_widget.dart';
import 'package:staffing/features/shift_features/view_models/shift_view_model.dart';
import 'package:table_calendar/table_calendar.dart';

class FilterShiftView extends StatefulWidget {
  const FilterShiftView({super.key});

  @override
  State<FilterShiftView> createState() => _FilterShiftViewState();
}

class _FilterShiftViewState extends State<FilterShiftView>
    with WidgetsBindingObserver {
  String shiftType = '';
  String profession = '';
  String minRange = '';
  bool isAddressFetching = false;

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  final TextEditingController _locationTEC = TextEditingController();
  double? lat;
  double? lng;
  bool isChangedAddress = false;

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

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      showStatusSnackbar(
        context,
        message:
            'Location services are disabled. Please enable location services in your device settings.',
        type: .error,
      );
      throw Exception('Location services are disabled.');
    } else {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          showStatusSnackbar(
            context,
            message: 'Location permissions are denied.',
          );
          throw Exception('Location permissions are denied.');
        }
      }

      // Check permission
    }

    if (permission == LocationPermission.deniedForever) {
      showStatusSnackbar(
        context,
        message:
            'Location permissions are permanently denied, we cannot request permissions.',
      );
      throw Exception('Location permissions are permanently denied.');
    }

    // Get current position
    return await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 0,
      ),
    );
  }

  Future<void> getAddressFromLatLng(double lat, double lng) async {
    final Geocoding geocoding = Geocoding();
    try {
      List<Placemark> placemarks = await geocoding.placemarkFromCoordinates(
        lat,
        lng,
      );
      Placemark place = placemarks[0];
      String address =
          "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
      print("Address: $address");
      _locationTEC.text = address;
      setState(() {});
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> getLatLngFromAddress(String address) async {
    Geocoding geocoding = Geocoding();
    try {
      List<Location> locations = await geocoding.locationFromAddress(address);

      if (locations.isNotEmpty) {
        double latitude = locations.first.latitude;
        double longitude = locations.first.longitude;
        lat = latitude;
        lng = longitude;
        print("Latitude: $latitude, Longitude: $longitude");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _locationTEC.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      final enabled = await Geolocator.isLocationServiceEnabled();

      if (!enabled) return;

      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );

      try {
        final position = await _determinePosition();

        lat = position.latitude;
        lng = position.longitude;

        await getAddressFromLatLng(lat!, lng!);

        setState(() {});
      } catch (_) {
      } finally {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
              controller: _locationTEC,
              textInputType: TextInputType.text,
              placeHolder: 'Current Location',
              suffixIcon: RemixIcons.crosshair_2_line,
              onChanged: (p0) {
                isChangedAddress = true;
                return;
              },
              onSuffixTap: () async {
                if (await Geolocator.isLocationServiceEnabled() == false) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Location services are disabled'),
                      content: const Text(
                        'Please enable location services in your device settings.',
                      ),
                      actions: [
                        TextButton(
                          child: const Text('Cancel'),
                          onPressed: () => Navigator.pop(context),
                        ),
                        TextButton(
                          child: const Text('Settings'),
                          onPressed: () {
                            Geolocator.openLocationSettings();
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                } else {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (_) =>
                        const Center(child: CircularProgressIndicator()),
                  );
                  try {
                    final position = await _determinePosition();

                    lat = position.latitude;
                    lng = position.longitude;

                    await getAddressFromLatLng(lat!, lng!);
                  } catch (_) {
                    // Ignore or show a message if needed.
                  } finally {
                    if (mounted && Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  }
                }
              },
            ),
            if (isAddressFetching) SizedBox(height: 8.h),
            if (isAddressFetching) LinearProgressIndicator(),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) => Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          // FIX: SingleChildScrollView allows the Dialog to shrinkwrap exactly to the calendar height
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              StatefulBuilder(
                                builder: (context, dialogSetState) =>
                                    TableCalendar(
                                      firstDay: DateTime.utc(
                                        DateTime.now().year,
                                        DateTime.now().month,
                                        DateTime.now().day,
                                      ),
                                      lastDay: DateTime.utc(2099, 12, 31),
                                      focusedDay: _focusedDay,
                                      selectedDayPredicate: (day) =>
                                          isSameDay(_selectedDay, day),
                                      rangeStartDay: _rangeStart,
                                      rangeEndDay: _rangeEnd,
                                      rangeSelectionMode: _rangeSelectionMode,
                                      onDaySelected: (selectedDay, focusedDay) {
                                        dialogSetState(() {
                                          _selectedDay = selectedDay;
                                          _focusedDay = focusedDay;
                                        });
                                        setState(() {});
                                      },
                                      onRangeSelected:
                                          (start, end, focusedDay) {
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
                                        leftChevronIcon: Icon(
                                          Icons.chevron_left,
                                        ),
                                        rightChevronIcon: Icon(
                                          Icons.chevron_right,
                                        ),
                                      ),
                                      calendarStyle: CalendarStyle(
                                        rangeHighlightColor: AppColors
                                            .themeColor
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
                                          color: AppColors.themeColor
                                              .withValues(alpha: 0.3),
                                          shape: BoxShape.circle,
                                        ),
                                        selectedDecoration: BoxDecoration(
                                          color: AppColors.themeColor,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        _selectedDay = null;
                                        _rangeStart = null;
                                        _rangeEnd = null;
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Reset'),
                                  ),
                                  SizedBox(width: 8.w),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Done'),
                                  ),
                                ],
                              ),
                            ],
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
                    value: profession.isEmpty ? 'All' : profession,
                    items: ['All', 'RN', 'LPN', 'CNA'],
                    onChanged: (value) {
                      profession = value!;
                    },
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
                    value: shiftType.isEmpty ? 'All' : shiftType,
                    items: ['All', 'Days', 'Nights', 'Evenings', 'Overnight'],
                    onChanged: (value) {
                      shiftType = value!;
                    },
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: CustomDropdownFieldWidget(
                    label: 'Pay Range',
                    value: minRange.isEmpty ? '\$0+/hr' : minRange,
                    items: [
                      '\$0+/hr',
                      '\$20+/hr',
                      '\$30+/hr',
                      '\$40+/hr',
                      '\$50+/hr',
                      '\$60+/hr',
                      '\$70+/hr',
                      '\$80+/hr',
                      '\$100+/hr',
                    ],
                    onChanged: (value) {
                      minRange = value!;
                      //need to extract only number 20, 300 from this string "\$20+/hr, \$300+/hr"
                      minRange = minRange.substring(1);
                      minRange = minRange.substring(0, minRange.indexOf('+'));
                      print("minRange: $minRange");
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 32.h),
            Consumer<ShiftViewModel>(
              builder: (context, provider, child) => provider.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : customElevatedButtonWidget(
                      text: 'Apply Filter',
                      onTapped: () async {
                        if (isChangedAddress) {
                          setState(() {
                            isAddressFetching = true;
                          });
                          await getLatLngFromAddress(_locationTEC.text);
                          isChangedAddress = false;
                          setState(() {
                            isAddressFetching = false;
                          });
                        }
                        NetworkResponseModel responseModel = await context
                            .read<ShiftViewModel>()
                            .searchShifts(
                              facility: _locationTEC.text,
                              lat: lat,
                              lng: lng,
                              profession: profession == 'All'
                                  ? null
                                  : profession,
                              // minRange: double.parse(minRange),
                              shiftType: shiftType == 'All'
                                  ? null
                                  : shiftType.toLowerCase(),
                              fromDate: _rangeStart != null
                                  ? DateFormat(
                                      'yyyy-MM-dd',
                                    ).format(_rangeStart!)
                                  : null,
                              toDate: _rangeEnd != null
                                  ? DateFormat('yyyy-MM-dd').format(_rangeEnd!)
                                  : null,
                            );
                        if (responseModel.isSuccess) {
                          context.pop();
                        }
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
