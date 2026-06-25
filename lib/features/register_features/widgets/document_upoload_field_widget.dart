import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:staffing/app/constants/app_colors.dart';

class DocumentUpoloadFieldWidget extends StatefulWidget {
  final String label;
  final Function(PlatformFile?) onFileSelected;

  const DocumentUpoloadFieldWidget({
    super.key,
    required this.label,
    required this.onFileSelected,
  });

  @override
  State<DocumentUpoloadFieldWidget> createState() =>
      _DocumentUpoloadFieldWidgetState();
}

class _DocumentUpoloadFieldWidgetState
    extends State<DocumentUpoloadFieldWidget> {
  PlatformFile? _selectedFile;

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png', 'doc', 'docx'],
      );

      if (result != null) {
        setState(() {
          _selectedFile = result.files.first;
        });
        widget.onFileSelected(_selectedFile);
      }
    } catch (e) {
      debugPrint("Error picking file: $e");
    }
  }

  void _removeFile() {
    setState(() {
      _selectedFile = null;
    });
    widget.onFileSelected(null);
  }

  @override
  Widget build(BuildContext context) {
    const Color brandNavy = Color(0xFF0D2352);
    const Color mutedSlate = Color(0xFF94A3B8);
    const Color lightGreyBg = Color(0xFFF8FAFC);

    final bool hasFile = _selectedFile != null;

    return Padding(
      padding: EdgeInsets.only(bottom: 20.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Field Label Text
          Text(
            widget.label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: .w600,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8.h),

          // Actionable Attachment Container
          InkWell(
            onTap: hasFile ? null : _pickFile, // Clicking opens picker if empty
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: double.infinity,
              height: 58.h,
              decoration: BoxDecoration(
                color: hasFile ? lightGreyBg : Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: AppColors.themeColor, width: 1.2.w),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  // File Name or Dynamic Placeholder Text
                  Expanded(
                    child: Text(
                      hasFile ? _selectedFile!.name : 'Attach file',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: hasFile ? brandNavy : mutedSlate,
                        fontWeight: hasFile
                            ? FontWeight.w500
                            : FontWeight.normal,
                      ),
                    ),
                  ),

                  // Interactive Right End Trailing Icon
                  hasFile
                      ? IconButton(
                          icon: Icon(
                            Icons.close,
                            color: Colors.redAccent,
                            size: 22.r,
                          ),
                          onPressed: _removeFile,
                        )
                      : Icon(Icons.attach_file, color: mutedSlate, size: 24.r),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
