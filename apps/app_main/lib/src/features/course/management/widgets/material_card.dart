library;

import 'package:flutter/material.dart';

/// 课程资料卡片
///
/// 用于显示课程资料文件
class MaterialCard extends StatelessWidget {
  /// 资料标题
  final String title;

  /// 资料描述
  final String description;

  /// 文件大小
  final String fileSize;

  /// 是否已上传
  final bool uploaded;

  /// 删除回调
  final VoidCallback? onDelete;

  const MaterialCard({
    super.key,
    required this.title,
    required this.description,
    required this.fileSize,
    required this.uploaded,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          // 文件图标
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.description,
              size: 28,
              color: Colors.blue,
            ),
          ),
          const SizedBox(width: 12),
          // 文件信息
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  fileSize,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          // 操作按钮
          if (onDelete != null)
            IconButton(
              icon: const Icon(Icons.delete_outline, size: 20, color: Colors.red),
              onPressed: onDelete,
              tooltip: '删除',
            ),
        ],
      ),
    );
  }
}
