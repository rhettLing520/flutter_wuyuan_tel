# secretchat

A new Flutter project.

## Getting Started

架构
getx
hive


lib/
├── core/          # 全局核心（封装轮子、工具类）
├── models/        # 数据模型
├── view_models/   # 业务逻辑（VM层）
├── views/         # 页面 UI
└── widgets/       # 公共组件



lib/
├── main.dart               # 程序主入口（只运行app）
├── app.dart                # GetMaterialApp 配置（主题、路由、全局配置）


├── core/                   # 核心通用（整个项目共用）
│   ├── constants/          # 颜色、字符串、常量
│   ├── utils/             # 工具类、扩展、校验
│   ├── network/           # Dio 封装、拦截器、异常
│   └── theme/             # 主题、文字样式
│
├── config/                 # 环境配置
│   ├── environment.dart
│   └── app_config.dart
│
├── data/                   # 数据层
│   ├── models/            # 实体类
│   ├── datasources/       # 远程/本地数据源
│   └── repositories/      # 仓库层（管理数据）
│
├── services/               # 全局服务（单例）
│   ├── auth_service.dart  # 登录、token
│   ├── storage_service.dart # 本地存储
│   └── api_service.dart   # 网络请求服务
│
├── logic/                  # GetX 控制器层
│   ├── bindings/          # 依赖注入（GetX 专用）
│   └── controllers/       # 所有页面控制器
│
├── pages/                  # 业务页面（按模块分包）
│   ├── home/
│   │   ├── widgets/       # 页面内私有组件
│   │   └── home_page.dart
│   ├── login/
│   └── profile/
│
├── routes/                 # GetX 路由
│   ├── app_routes.dart    # 路由名称
│   └── app_pages.dart     # 路由列表
│
└── widgets/                # 全局公共组件
├── custom_button.dart
├── loading.dart
└── error_widget.dart

状态管理：getx

网络请求：dio

路由：getx

本地存储：share和hive

UI组件：flutter_screenutil + fluttertoast

图标：fluentui_system_icons


This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.



