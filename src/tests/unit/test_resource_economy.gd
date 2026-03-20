extends GutTest

var economy: ResourceEconomy

func before_each() -> void:
	economy = ResourceEconomy.new()
	add_child(economy)

func after_each() -> void:
	economy.queue_free()

func test_initial_resources_are_zero() -> void:
	assert_eq(economy.resources["iron"], 0)
	assert_eq(economy.resources["coal"], 0)

func test_add_resource_positive() -> void:
	economy.add_resource("iron", 100)
	assert_eq(economy.resources["iron"], 100)

func test_add_resource_negative_fails() -> void:
	economy.resources["iron"] = 50
	var result = economy.add_resource("iron", -100)
	assert_false(result, "Should fail to subtract more than available")
	assert_eq(economy.resources["iron"], 50, "Resources should not change on failed subtract")

func test_production_over_time() -> void:
	economy.set_production_rate("iron", 10.0)  # 10 per second
	economy._process(1.0)
	assert_eq(economy.resources["iron"], 10)

func test_production_accumulates() -> void:
	economy.set_production_rate("iron", 5.0)
	economy._process(1.0)
	economy._process(2.0)
	assert_eq(economy.resources["iron"], 15)

func test_has_resources_true() -> void:
	economy.resources["iron"] = 100
	economy.resources["coal"] = 50
	var required = {"iron": 80, "coal": 30}
	assert_true(economy.has_resources(required))

func test_has_resources_false() -> void:
	economy.resources["iron"] = 100
	economy.resources["coal"] = 20
	var required = {"iron": 80, "coal": 30}
	assert_false(economy.has_resources(required))

func test_consume_resources_success() -> void:
	economy.resources["iron"] = 100
	economy.resources["coal"] = 50
	var costs = {"iron": 30, "coal": 20}
	
	var result = economy.consume_resources(costs)
	assert_true(result)
	assert_eq(economy.resources["iron"], 70)
	assert_eq(economy.resources["coal"], 30)

func test_consume_resources_insufficient() -> void:
	economy.resources["iron"] = 100
	economy.resources["coal"] = 10
	var costs = {"iron": 30, "coal": 20}
	
	var result = economy.consume_resources(costs)
	assert_false(result, "Should fail if insufficient resources")
	assert_eq(economy.resources["iron"], 100, "Iron should not change on failed consume")
	assert_eq(economy.resources["coal"], 10, "Coal should not change on failed consume")

func test_resource_changed_signal() -> void:
	var signal_received = false
	economy.resource_changed.connect(func(type, amount):
		if type == "iron":
			signal_received = true
	)
	
	economy.add_resource("iron", 50)
	assert_true(signal_received)
