library;

import 'package:flutter/material.dart';
import 'material_card.dart';

/// 课程资料标签页
///
/// 显示和管理课程资料文件
class CourseMaterialsTab extends StatefulWidget {
  /// 资料列表
  final List<Map<String, dynamic>> materials;

  /// 资料变化回调
  final ValueChanged<List<Map<String, dynamic>>>? onMaterialsChanged;

  /// 上传资料回调
  final VoidCallback? onUpload;

  const CourseMaterialsTab({
    super.key,
    required this.materials,
    this.onMaterialsChanged,
    this.onUpload,
  });

  @override
  State<CourseMaterialsTab> createState() => _CourseMaterialsTabState();
}

class _CourseMaterialsTabState extends State<CourseMaterialsTab> {
  late List<Map<String, dynamic>> _materials;

  @override
  void initState() {
    super.initState();
    _materials = List.from(widget.materials);
  }

  @override
  void didUpdateWidget(CourseMaterialsTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.materials != oldWidget.materials) {
      _materials = List.from(widget.materials);
    }
  }

  void _deleteMaterial(int index) {
    setState(() {
      _materials.removeAt(index);
    });
    widget.onMaterialsChanged?.call(_materials);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 上传资料按钮
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: widget.onUpload,
              icon: const Icon(Icons.upload_file),
              label: const Text('上传课程资料'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF4757),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ),

        // 资料列表
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _materials.length,
            itemBuilder: (context, index) {
              final material = _materials[index];
              return MaterialCard(
                title: material['title'] as String,
                description: material['description'] as String,
                fileSize: material['fileSize'] as String,
                uploaded: material['uploaded'] as bool? ?? false,
                onDelete: () => _deleteMaterial(index),
              );
            },
          ),
        ),
      ],
    );
  }
}
