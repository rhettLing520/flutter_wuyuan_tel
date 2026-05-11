# Flutter 项目开发规范
### 4. Widget 拆分原则

- 单个 Widget 超过 **200 行** 考虑拆分
- 可复用的 UI 提取为独立组件
- 页面内的私有组件放在 `widgets/` 子目录
- 私有 Widget 以下划线开头：`_DiaryEntryTile`

---

## 🚫 禁止事项清单

### ❌ 绝对禁止

1. **不要直接使用 Text widget** → 必须用 `AppText`
2. **不要硬编码颜色** → 必须用 `AppColors`
3. **不要硬编码尺寸** → 必须用 `.sp/.w/.h/.r`
4. **不要直接使用 Navigator** → 必须用 `Get.to()`
5. **不要直接使用 Image** → 必须用 `AppImage`
6. **不要使用 Colors.grey[xxx]** → 必须用 `AppColors.textSecondary` 等
7. **不要直接操作 DOM** → 使用 GetX 响应式

### ⚠️ 谨慎使用

1. **setState**: 优先使用 GetX 响应式
2. **InheritedWidget**: 优先使用 Get.find()
3. **GlobalKey**: 尽量避免，寻找替代方案
4. **BuildContext**: 在异步操作后使用前检查 `mounted`

---

## ✅ 代码审查清单

提交代码前自查：

- [ ] 所有 Text 都改成了 AppText？
- [ ] 所有颜色都使用了 AppColors？
- [ ] 所有尺寸都使用了屏幕适配单位？
- [ ] 所有图片都使用了 AppImage？
- [ ] 路由跳转使用了 GetX API？
- [ ] 状态管理使用了 GetX 响应式？
- [ ] 文件名符合 snake_case 规范？
- [ ] 导入顺序正确？
- [ ] 没有硬编码的魔法数字？
- [ ] 添加了必要的注释？
- [ ] 代码格式已格式化（`dart format`）？

---

## 🛠️ 常用命令


