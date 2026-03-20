# Resource Economy System
# Manages player resources (iron, coal) and production

class_name ResourceEconomy
extends Node

signal resource_changed(resource_type: String, amount: int)
signal production_started(resource_type: String)
signal production_stopped(resource_type: String)

var resources: Dictionary = {
	"iron": 0,
	"coal": 0
}

var production_rate: Dictionary = {
	"iron": 0,
	"coal": 0
}

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	# Apply production rates
	for resource_type in production_rate.keys():
		if production_rate[resource_type] > 0:
			add_resource(resource_type, production_rate[resource_type] * delta)

## Add resources (positive or negative for consumption)
func add_resource(resource_type: String, amount: float) -> bool:
	if resource_type not in resources:
		return false
	
	var new_amount = resources[resource_type] + amount
	
	# Prevent negative resources (consumption check)
	if new_amount < 0:
		return false
	
	resources[resource_type] = int(new_amount)
	resource_changed.emit(resource_type, resources[resource_type])
	return true

## Check if we have enough resources
func has_resources(costs: Dictionary) -> bool:
	for resource_type in costs.keys():
		if resource_type not in resources:
			return false
		if resources[resource_type] < costs[resource_type]:
			return false
	return true

## Consume resources (must check has_resources first)
func consume_resources(costs: Dictionary) -> bool:
	if not has_resources(costs):
		return false
	
	for resource_type in costs.keys():
		resources[resource_type] -= costs[resource_type]
		resource_changed.emit(resource_type, resources[resource_type])
	
	return true

## Set production rate for a resource type (from miners)
func set_production_rate(resource_type: String, rate: float) -> void:
	if resource_type in production_rate:
		production_rate[resource_type] = rate

## Get current resources
func get_resources() -> Dictionary:
	return resources.duplicate()

## Reset for testing
func reset() -> void:
	for resource_type in resources.keys():
		resources[resource_type] = 0
		production_rate[resource_type] = 0
