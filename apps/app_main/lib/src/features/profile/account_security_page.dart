library;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

/// 账号与资质页面
///
/// 可以修改账号名、头像等信息，管理个人资质
class AccountSecurityPage extends StatefulWidget {
  const AccountSecurityPage({super.key});

  @override
  State<AccountSecurityPage> createState() => _AccountSecurityPageState();
}

class _AccountSecurityPageState extends State<AccountSecurityPage> {
  // 用户信息
  String _username = '微信用户';
  String _avatarUrl = 'https://picsum.photos/150/150?random=301';
  String _phone = '138****8888';
  String _email = 'user@example.com';
  String _bio = '这是我的个人简介';

  final ImagePicker _imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          '账号与资质',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
      body: ListView(
        children: [
          // 头像和用户名区域
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // 头像
                GestureDetector(
                  onTap: _changeAvatar,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(_avatarUrl),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF4757),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                // 用户名
                Text(
                  _username,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '点击头像修改',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // 用户信息列表
          _buildSection([
            _buildListItem(
              icon: Icons.person,
              title: '昵称',
              value: _username,
              onTap: _editUsername,
            ),
            _buildListItem(
              icon: Icons.info_outline,
              title: '个人简介',
              value: _bio,
              onTap: _editBio,
            ),
          ]),

          const SizedBox(height: 12),

          // 联系方式
          _buildSection([
            _buildListItem(
              icon: Icons.phone,
              title: '手机号',
              value: _phone,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('手机号修改功能开发中...')),
                );
              },
            ),
            _buildListItem(
              icon: Icons.email,
              title: '邮箱',
              value: _email,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('邮箱修改功能开发中...')),
                );
              },
            ),
          ]),

          const SizedBox(height: 12),

          // 账号安全
          _buildSection([
            _buildListItem(
              icon: Icons.lock,
              title: '修改密码',
              value: '',
              trailing: const Icon(Icons.chevron_right, size: 20),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('修改密码功能开发中...')),
                );
              },
            ),
            _buildListItem(
              icon: Icons.verified_user,
              title: '个人资质管理',
              value: '已认证',
              trailing: const Icon(Icons.chevron_right, size: 20),
              onTap: () {
                _showQualificationManagement(context);
              },
            ),
            _buildListItem(
              icon: Icons.security,
              title: '隐私设置',
              value: '',
              trailing: const Icon(Icons.chevron_right, size: 20),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('隐私设置功能开发中...')),
                );
              },
            ),
          ]),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  /// 构建区块
  Widget _buildSection(List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  /// 构建列表项
  Widget _buildListItem({
    required IconData icon,
    required String title,
    required String value,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Column(
      children: [
        if (onTap != null)
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: _buildListContent(icon, title, value, trailing),
            ),
          )
        else
          _buildListContent(icon, title, value, trailing),
        const Divider(height: 1, indent: 56),
      ],
    );
  }

  /// 构建列表内容
  Widget _buildListContent(IconData icon, String title, String value, Widget? trailing) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[700]),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black87,
              ),
            ),
          ),
          if (value.isNotEmpty)
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          if (trailing != null) trailing,
        ],
      ),
    );
  }

  /// 修改头像
  void _changeAvatar() async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                '修改头像',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 24),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.blue),
                title: const Text('拍照'),
                onTap: () {
                  Navigator.pop(context);
                  _takePhoto();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.green),
                title: const Text('从相册选择'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage();
                },
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  /// 拍照
  void _takePhoto() async {
    try {
      final XFile? photo = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );
      if (photo != null) {
        setState(() {
          _avatarUrl = photo.path;
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('头像已更新')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('拍照功能暂不可用')),
        );
      }
    }
  }

  /// 从相册选择
  void _pickImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (image != null) {
        setState(() {
          _avatarUrl = image.path;
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('头像已更新')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('选择图片功能暂不可用')),
        );
      }
    }
  }

  /// 编辑昵称
  void _editUsername() {
    final TextEditingController controller = TextEditingController(text: _username);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('修改昵称'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: '请输入昵称',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
          maxLength: 20,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                setState(() {
                  _username = controller.text.trim();
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('昵称已更新')),
                );
              }
            },
            child: const Text(
              '确定',
              style: TextStyle(color: Color(0xFFFF4757)),
            ),
          ),
        ],
      ),
    );
  }

  /// 编辑个人简介
  void _editBio() {
    final TextEditingController controller = TextEditingController(text: _bio);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('修改个人简介'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: '请输入个人简介',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
          maxLines: 3,
          maxLength: 100,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _bio = controller.text.trim();
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('个人简介已更新')),
              );
            },
            child: const Text(
              '确定',
              style: TextStyle(color: Color(0xFFFF4757)),
            ),
          ),
        ],
      ),
    );
  }

  /// 显示个人资质管理
  void _showQualificationManagement(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            // 标题栏
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.withValues(alpha: 0.2),
                  ),
                ),
              ),
              child: Row(
                children: [
                  const Text(
                    '个人资质管理',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            // 内容区域
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // 认证状态卡片
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.green.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.verified,
                          color: Colors.green[700],
                          size: 32,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '已认证讲师',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[700],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '您的讲师资质已通过审核',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 资质信息
                  const Text(
                    '资质信息',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),

                  _buildQualificationItem(
                    icon: Icons.badge,
                    label: '真实姓名',
                    value: '张三',
                  ),

                  _buildQualificationItem(
                    icon: Icons.card_membership,
                    label: '身份证号',
                    value: '310***********1234',
                  ),

                  _buildQualificationItem(
                    icon: Icons.school,
                    label: '最高学历',
                    value: '本科',
                  ),

                  _buildQualificationItem(
                    icon: Icons.work,
                    label: '职业背景',
                    value: '软件工程师',
                  ),

                  _buildQualificationItem(
                    icon: Icons.stars,
                    label: '擅长领域',
                    value: 'Flutter开发、前端架构',
                  ),

                  _buildQualificationItem(
                    icon: Icons.description,
                    label: '认证时间',
                    value: '2026-03-15',
                  ),

                  const SizedBox(height: 20),

                  // 资质证书
                  const Text(
                    '资质证书',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // 证书列表
                  _buildCertificateCard(
                    title: '教师资格证',
                    status: '已审核',
                    statusColor: Colors.green,
                    imageUrl: 'https://picsum.photos/300/200?random=501',
                  ),

                  const SizedBox(height: 12),

                  _buildCertificateCard(
                    title: '专业技术职称证书',
                    status: '已审核',
                    statusColor: Colors.green,
                    imageUrl: 'https://picsum.photos/300/200?random=502',
                  ),

                  const SizedBox(height: 20),

                  // 操作按钮
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('修改资质功能开发中...')),
                        );
                      },
                      icon: const Icon(Icons.edit, size: 18),
                      label: const Text('修改资质信息'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFFFF4757),
                        side: const BorderSide(color: Color(0xFFFF4757)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建资质信息项
  Widget _buildQualificationItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: Colors.grey[600],
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  /// 构建证书卡片
  Widget _buildCertificateCard({
    required String title,
    required String status,
    required Color statusColor,
    required String imageUrl,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          // 证书缩略图
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              width: 80,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),

          // 证书信息
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontSize: 11,
                      color: statusColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 查看按钮
          Icon(
            Icons.chevron_right,
            color: Colors.grey[400],
          ),
        ],
      ),
    );
  }
}
