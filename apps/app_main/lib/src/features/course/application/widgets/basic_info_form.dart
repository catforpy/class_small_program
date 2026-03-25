library;

import 'package:flutter/material.dart';

/// 基本信息表单组件
///
/// 用于课程申请的基本信息输入
class BasicInfoForm extends StatefulWidget {
  /// 分类列表
  final List<String> categories;

  /// 难度等级列表
  final List<String> difficulties;

  /// 状态列表
  final List<String> statuses;

  /// 初始分类
  final String? initialCategory;

  /// 初始难度
  final String? initialDifficulty;

  /// 初始状态
  final String? initialStatus;

  /// 初始标题
  final String? initialTitle;

  /// 初始副标题
  final String? initialSubtitle;

  /// 初始简介
  final String? initialIntroduction;

  /// 初始目标
  final String? initialObjectives;

  /// 初始亮点
  final String? initialHighlights;

  /// 表单变化回调
  final VoidCallback? onFormChanged;

  const BasicInfoForm({
    super.key,
    required this.categories,
    required this.difficulties,
    required this.statuses,
    this.initialCategory,
    this.initialDifficulty,
    this.initialStatus,
    this.initialTitle,
    this.initialSubtitle,
    this.initialIntroduction,
    this.initialObjectives,
    this.initialHighlights,
    this.onFormChanged,
  });

  @override
  State<BasicInfoForm> createState() => _BasicInfoFormState();
}

class _BasicInfoFormState extends State<BasicInfoForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subtitleController = TextEditingController();
  final TextEditingController _introductionController = TextEditingController();
  final TextEditingController _objectivesController = TextEditingController();
  final TextEditingController _highlightsController = TextEditingController();

  String? _selectedCategory;
  String? _selectedDifficulty;
  String? _selectedStatus;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.initialTitle ?? '';
    _subtitleController.text = widget.initialSubtitle ?? '';
    _introductionController.text = widget.initialIntroduction ?? '';
    _objectivesController.text = widget.initialObjectives ?? '';
    _highlightsController.text = widget.initialHighlights ?? '';
    _selectedCategory = widget.initialCategory;
    _selectedDifficulty = widget.initialDifficulty;
    _selectedStatus = widget.initialStatus;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _subtitleController.dispose();
    _introductionController.dispose();
    _objectivesController.dispose();
    _highlightsController.dispose();
    super.dispose();
  }

  void _notifyChanged() {
    widget.onFormChanged?.call();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // 课程标题
        _buildSectionCard(
          title: '课程标题',
          child: TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              hintText: '请输入课程标题',
              border: OutlineInputBorder(),
            ),
            maxLength: 50,
            onChanged: (_) => _notifyChanged(),
          ),
        ),

        const SizedBox(height: 16),

        // 课程副标题
        _buildSectionCard(
          title: '课程副标题',
          child: TextField(
            controller: _subtitleController,
            decoration: const InputDecoration(
              hintText: '请输入课程副标题',
              border: OutlineInputBorder(),
            ),
            maxLength: 100,
            onChanged: (_) => _notifyChanged(),
          ),
        ),

        const SizedBox(height: 16),

        // 课程分类
        _buildSectionCard(
          title: '课程分类',
          child: DropdownButtonFormField<String>(
            value: _selectedCategory,
            decoration: const InputDecoration(
              hintText: '请选择课程分类',
              border: OutlineInputBorder(),
            ),
            items: widget.categories.map((category) {
              return DropdownMenuItem(
                value: category,
                child: Text(category),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedCategory = value;
              });
              _notifyChanged();
            },
          ),
        ),

        const SizedBox(height: 16),

        // 难度等级
        _buildSectionCard(
          title: '难度等级',
          child: DropdownButtonFormField<String>(
            value: _selectedDifficulty,
            decoration: const InputDecoration(
              hintText: '请选择难度等级',
              border: OutlineInputBorder(),
            ),
            items: widget.difficulties.map((difficulty) {
              return DropdownMenuItem(
                value: difficulty,
                child: Text(difficulty),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedDifficulty = value;
              });
              _notifyChanged();
            },
          ),
        ),

        const SizedBox(height: 16),

        // 课程状态
        _buildSectionCard(
          title: '课程状态',
          child: DropdownButtonFormField<String>(
            value: _selectedStatus,
            decoration: const InputDecoration(
              hintText: '请选择课程状态',
              border: OutlineInputBorder(),
            ),
            items: widget.statuses.map((status) {
              return DropdownMenuItem(
                value: status,
                child: Text(status),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedStatus = value;
              });
              _notifyChanged();
            },
          ),
        ),

        const SizedBox(height: 16),

        // 课程简介
        _buildSectionCard(
          title: '课程简介',
          child: TextField(
            controller: _introductionController,
            decoration: const InputDecoration(
              hintText: '请输入课程简介',
              border: OutlineInputBorder(),
            ),
            maxLines: 5,
            maxLength: 500,
            onChanged: (_) => _notifyChanged(),
          ),
        ),

        const SizedBox(height: 16),

        // 学习目标
        _buildSectionCard(
          title: '学习目标',
          child: TextField(
            controller: _objectivesController,
            decoration: const InputDecoration(
              hintText: '请输入学习目标，每行一个',
              border: OutlineInputBorder(),
            ),
            maxLines: 5,
            maxLength: 500,
            onChanged: (_) => _notifyChanged(),
          ),
        ),

        const SizedBox(height: 16),

        // 课程亮点
        _buildSectionCard(
          title: '课程亮点',
          child: TextField(
            controller: _highlightsController,
            decoration: const InputDecoration(
              hintText: '请输入课程亮点，每行一个',
              border: OutlineInputBorder(),
            ),
            maxLines: 5,
            maxLength: 500,
            onChanged: (_) => _notifyChanged(),
          ),
        ),
      ],
    );
  }

  /// 构建区域卡片
  Widget _buildSectionCard({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  /// 获取表单数据
  Map<String, dynamic> getFormData() {
    return {
      'title': _titleController.text,
      'subtitle': _subtitleController.text,
      'category': _selectedCategory,
      'difficulty': _selectedDifficulty,
      'status': _selectedStatus,
      'introduction': _introductionController.text,
      'objectives': _objectivesController.text,
      'highlights': _highlightsController.text,
    };
  }
}
