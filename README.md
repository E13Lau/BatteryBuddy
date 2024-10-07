# BatteryBuddy

BatteryBuddy 是一个 macOS 应用程序，用于监控和管理您的 Mac 电池状态。它可以帮助您优化电池使用，延长电池寿命，并在关键时刻提醒您。

## 功能特点

- 实时监控电池电量和充电状态
- 自定义电量阈值通知
- 在电池电量达到设定的最大或最小值时发送通知
- 状态栏快速访问
- 自动启动选项
- 节能提醒

## 安装

1. 从 [Releases](https://github.com/E13Lau/BatteryBuddy/releases) 页面下载最新版本的 BatteryBuddy.dmg 文件。
2. 打开 DMG 文件并将 BatteryBuddy 应用程序拖到 Applications 文件夹中。
3. 首次运行时，您可能需要在系统偏好设置中允许来自身份不明开发者的应用。

## 使用方法

1. 启动 BatteryBuddy 应用程序。
2. 点击菜单栏中的 BatteryBuddy 图标来访问主界面。
3. 使用滑块设置您希望接收通知的电池电量范围。
4. 选择是否在登录时自动启动 BatteryBuddy。

## 开发

BatteryBuddy 使用 SwiftUI 开发，采用了清晰的架构设计。

### 项目结构

- `Application`: 应用程序入口和配置
- `Presentation`: 视图模型和用户界面组件
- `Domain`: 业务逻辑和用例
- `Data`: 数据存储和管理

### 构建项目

1. 克隆仓库：
   ```
   git clone https://github.com/E13Lau/BatteryBuddy.git
   ```
2. 打开 `BatteryBuddy.xcodeproj` 文件。
3. 在 Xcode 中构建和运行项目。

## 贡献

欢迎贡献！请阅读 [CONTRIBUTING.md](CONTRIBUTING.md) 了解如何参与项目开发。

## 许可证

本项目采用 MIT 许可证。详情请见 [LICENSE](LICENSE) 文件。

## 联系方式

如有任何问题或建议，请开启一个 issue 或直接联系项目维护者。

---

希望 BatteryBuddy 能够帮助您更好地管理 Mac 电池！
