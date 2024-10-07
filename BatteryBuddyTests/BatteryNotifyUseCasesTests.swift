import Testing

/// 测试 BatteryNotifyUseCases 类的功能
struct BatteryNotifyUseCasesTests {

    @Test("测试充电状态变化时是否正确通知")
    func testShouldNotifyWhenChargingStateChanges() {
        let batteryNotifyUseCases = BatteryNotifyUseCases(
            notificationUseCases: MockNotificationUseCases())
        let old = BatteryInfo(batteryLevel: 50.0, isCharging: false)
        let new = BatteryInfo(batteryLevel: 50.0, isCharging: true)

        let result = batteryNotifyUseCases.shouldNotify(old: old, new: new, min: 20.0, max: 80.0)

        #expect(result.shouldNotify == true, "充电状态变化时应该通知")
        #expect(result.message == "电池状态变化：开始充电", "通知消息应该正确")
    }

    @Test("测试电池电量达到最大值时是否正确通知")
    func testShouldNotifyWhenBatteryLevelReachesMax() {
        let batteryNotifyUseCases = BatteryNotifyUseCases(
            notificationUseCases: MockNotificationUseCases())
        let old = BatteryInfo(batteryLevel: 79.0, isCharging: true)
        let new = BatteryInfo(batteryLevel: 80.0, isCharging: true)

        let result = batteryNotifyUseCases.shouldNotify(old: old, new: new, min: 20.0, max: 80.0)

        #expect(result.shouldNotify == true, "电池电量达到最大值时应该通知")
        #expect(result.message == "电池电量已达到80%，可以拔掉充电器", "通知消息应该正确")
    }

    @Test("测试电池电量达到最小值时是否正确通知")
    func testShouldNotifyWhenBatteryLevelReachesMin() {
        let batteryNotifyUseCases = BatteryNotifyUseCases(
            notificationUseCases: MockNotificationUseCases())
        let old = BatteryInfo(batteryLevel: 21.0, isCharging: false)
        let new = BatteryInfo(batteryLevel: 20.0, isCharging: false)

        let result = batteryNotifyUseCases.shouldNotify(old: old, new: new, min: 20.0, max: 80.0)

        #expect(result.shouldNotify == true, "电池电量达到最小值时应该通知")
        #expect(result.message == "电池电量已降至20%，请及时充电", "通知消息应该正确")
    }

    @Test("测试电池状态无显著变化时是否正确不通知")
    func testShouldNotNotifyWhenNoSignificantChange() {
        let batteryNotifyUseCases = BatteryNotifyUseCases(
            notificationUseCases: MockNotificationUseCases())
        let old = BatteryInfo(batteryLevel: 50.0, isCharging: false)
        let new = BatteryInfo(batteryLevel: 49.0, isCharging: false)

        let result = batteryNotifyUseCases.shouldNotify(old: old, new: new, min: 20.0, max: 80.0)

        #expect(result.shouldNotify == false, "电池状态无显著变化时不应该通知")
        #expect(result.message == nil, "不应该有通知消息")
    }

    @Test("测试充电中但未达到最大值时是否正确不通知")
    func testShouldNotNotifyWhenChargingButBelowMax() {
        let batteryNotifyUseCases = BatteryNotifyUseCases(
            notificationUseCases: MockNotificationUseCases())
        let old = BatteryInfo(batteryLevel: 70.0, isCharging: true)
        let new = BatteryInfo(batteryLevel: 75.0, isCharging: true)

        let result = batteryNotifyUseCases.shouldNotify(old: old, new: new, min: 20.0, max: 80.0)

        #expect(result.shouldNotify == false, "充电中但未达到最大值时不应该通知")
        #expect(result.message == nil, "不应该有通知消息")
    }

    @Test("测试放电中但高于最小值时是否正确不通知")
    func testShouldNotNotifyWhenDischargingButAboveMin() {
        let batteryNotifyUseCases = BatteryNotifyUseCases(
            notificationUseCases: MockNotificationUseCases())
        let old = BatteryInfo(batteryLevel: 30.0, isCharging: false)
        let new = BatteryInfo(batteryLevel: 25.0, isCharging: false)

        let result = batteryNotifyUseCases.shouldNotify(old: old, new: new, min: 20.0, max: 80.0)

        #expect(result.shouldNotify == false, "放电中但高于最小值时不应该通知")
        #expect(result.message == nil, "不应该有通知消息")
    }
}
