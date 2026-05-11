# SecretChat - Flutter 项目开发规范

## 📋 项目概述

**项目名称**: SecretChat（加密聊天应用）
**技术栈**: Flutter + Dart
**架构模式**: MVVM + GetX
**本地存储**: Hive + SharedPreferences
**网络请求**: Dio
**屏幕适配**: flutter_screenutil

---

## 📁 目录结构

```
lib/
├── main.dart           # 程序入口
├── app.dart            # GetMaterialApp 配置
├── core/               # 核心层（常量、工具、网络）
├── config/             # 环境配置
├── data/               # 数据层（模型、数据源、仓库）
├── services/           # 全局服务（单例）
├── logic/              # GetX 控制器层
├── pages/              # 业务页面（按模块分包）
├── routes/             # 路由管理
└── widgets/            # 全局公共组件
```

详细目录结构参考：`DEVELOPMENT.md`

---

## 🎯 核心开发原则

### 1. UI 组件规范

#### 文本样式
- ✅ **必须使用** `AppText` 替代 `Text`
- ✅ **必须使用** `AppColors` 定义的颜色
- ✅ **必须使用** `AppFontWeights` 定义的字重
- ✅ **必须使用** 屏幕适配单位（`.sp`, `.w`, `.h`, `.r`）
- ❌ **禁止**硬编码颜色和尺寸
- ❌ **禁止**使用 `Colors.grey[xxx]`

示例：
```dart
// ✅ 正确
AppText('标题', fontSize: 16.sp, color: AppColors.textPrimary, fontWeight: AppFontWeights.medium)

// ❌ 错误
Text('标题', style: TextStyle(fontSize: 16.sp, color: Colors.grey[600]))
```

#### 图片使用
- ✅ **必须使用** `AppImage` 组件
- ✅ 图片路径从 `AppImages` 中获取

#### 按钮使用
- ✅ 使用 `CommonButton` 或 `GradientButton`
- ❌ 不要直接使用 `ElevatedButton`

### 2. 状态管理规范

- ✅ 使用 **GetX** 进行状态管理
- ✅ 响应式变量使用 `.obs`
- ✅ UI 更新使用 `Obx()` 包裹
- ✅ Controller 通过 `Get.put()` 或 Binding 注册
- ❌ 避免使用 `setState`

### 3. 路由导航规范

- ✅ 使用 `Get.to()`, `Get.off()`, `Get.toNamed()`
- ❌ **禁止**直接使用 `Navigator.push()`

### 4. 代码组织规范

#### 命名规范
- 文件名：`snake_case`（如：`home_page.dart`）
- 类名：`PascalCase`（如：`HomePage`）
- 变量名：`camelCase`（如：`userName`）
- 常量：`UPPER_SNAKE_CASE`（如：`MAX_COUNT`）

#### 页面拆分
- 每个 Tab 页面独立文件
- Widget 超过 200 行考虑拆分
- 私有 Widget 以下划线开头

#### 导入顺序
1. Flutter SDK
2. Dart SDK
3. 第三方包
4. 项目内部文件（从外到内）

---

## 📂 常用路径

| 类型 | 路径 |
|------|------|
| 页面 | `lib/pages/` |
| 控制器 | `lib/logic/controllers/` |
| 服务 | `lib/services/` |
| 模型 | `lib/data/models/` |
| 常量 | `lib/core/constants/` |
| 组件 | `lib/widgets/` |

---

## 🚫 绝对禁止

1. ❌ 直接使用 `Text` widget → 用 `AppText`
2. ❌ 硬编码颜色 → 用 `AppColors`
3. ❌ 硬编码尺寸 → 用 `.sp/.w/.h/.r`
4. ❌ 直接使用 `Navigator` → 用 `Get.to()`
5. ❌ 直接使用 `Image` → 用 `AppImage`
6. ❌ 使用 `Colors.grey[xxx]` → 用 `AppColors.textSecondary`


不用读取这些生成的文件，例如.dart_tool, .idea,.build文件就不要检查了