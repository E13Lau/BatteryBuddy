import Testing

/// 测试 ConfigureUseCases 类的功能
struct ConfigureUseCasesTests {
    /// 测试获取默认配置值
    @Test("测试获取默认配置值")
    func testGetConfigureWithDefaultValues() {
        let mockStorage = MockKeyValueStorage()
        let configureUseCases = ConfigureUseCases(storage: mockStorage)

        let configure = configureUseCases.getConfigure()

        // 验证默认值是否正确
        #expect(configure.min == 20.0)
        #expect(configure.max == 80.0)
        #expect(configure.autoStartWhenLaunch == false)
    }

    /// 测试获取已存储的配置值
    @Test("测试获取已存储的配置值")
    func testGetConfigureWithStoredValues() {
        let mockStorage = MockKeyValueStorage()
        // 设置模拟存储的值
        mockStorage.set(key: "min", value: 30.0)
        mockStorage.set(key: "max", value: 90.0)
        mockStorage.set(key: "autoStartWhenLaunch", value: true)

        let configureUseCases = ConfigureUseCases(storage: mockStorage)
        let configure = configureUseCases.getConfigure()

        // 验证获取的值是否与存储的值匹配
        #expect(configure.min == 30.0)
        #expect(configure.max == 90.0)
        #expect(configure.autoStartWhenLaunch == true)
    }

    /// 测试保存配置
    @Test("测试保存配置")
    func testSaveConfigure() {
        let mockStorage = MockKeyValueStorage()
        let configureUseCases = ConfigureUseCases(storage: mockStorage)

        let configure = Configure(min: 25.0, max: 85.0, autoStartWhenLaunch: true)
        let result = configureUseCases.saveConfigure(configure)

        // 验证保存操作是否成功，以及存储的值是否正确
        #expect(result == true)
        #expect(mockStorage.get(key: "min") as Double? == 25.0)
        #expect(mockStorage.get(key: "max") as Double? == 85.0)
        #expect(mockStorage.get(key: "autoStartWhenLaunch") as Bool? == true)
    }

    /// 测试更新最小值
    @Test("测试更新最小值")
    func testUpdateMin() {
        let mockStorage = MockKeyValueStorage()
        let configureUseCases = ConfigureUseCases(storage: mockStorage)

        let result = configureUseCases.updateMin(35.0)

        // 验证更新操作是否成功，以及存储的值是否正确
        #expect(result == true)
        #expect(mockStorage.get(key: "min") as Double? == 35.0)
    }

    /// 测试更新最大值
    @Test("测试更新最大值")
    func testUpdateMax() {
        let mockStorage = MockKeyValueStorage()
        let configureUseCases = ConfigureUseCases(storage: mockStorage)

        let result = configureUseCases.updateMax(95.0)

        // 验证更新操作是否成功，以及存储的值是否正确
        #expect(result == true)
        #expect(mockStorage.get(key: "max") as Double? == 95.0)
    }

    /// 测试更新自动启动设置
    @Test("测试更新自动启动设置")
    func testUpdateAutoStartWhenLaunch() {
        let mockStorage = MockKeyValueStorage()
        let configureUseCases = ConfigureUseCases(storage: mockStorage)

        let result = configureUseCases.updateAutoStartWhenLaunch(true)

        // 验证更新操作是否成功，以及存储的值是否正确
        #expect(result == true)
        #expect(mockStorage.get(key: "autoStartWhenLaunch") as Bool? == true)
    }

    /// 测试重置为默认配置
    @Test("测试重置为默认配置")
    func testResetToDefault() {
        let mockStorage = MockKeyValueStorage()
        // 先设置一些非默认值
        mockStorage.set(key: "min", value: 30.0)
        mockStorage.set(key: "max", value: 90.0)
        mockStorage.set(key: "autoStartWhenLaunch", value: true)

        let configureUseCases = ConfigureUseCases(storage: mockStorage)
        let result = configureUseCases.resetToDefault()

        // 验证重置操作是否成功，以及所有值是否恢复为默认值
        #expect(result == true)
        #expect(mockStorage.get(key: "min") as Double? == 20.0)
        #expect(mockStorage.get(key: "max") as Double? == 80.0)
        #expect(mockStorage.get(key: "autoStartWhenLaunch") as Bool? == false)
    }
}
