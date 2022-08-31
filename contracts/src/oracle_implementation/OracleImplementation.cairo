%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.bool import TRUE, FALSE

from entry.structs import Entry
from proxy.library import Proxy
from oracle_implementation.library import (
    Oracle_set_oracle_controller_address,
    Oracle_get_entries,
    Oracle_get_value,
    Oracle_get_entry,
    Oracle_get_all_sources,
    Oracle_publish_entry,
)

#
# Constructor
#

@external
func initializer{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    oracle_controller_address : felt, proxy_admin : felt
):
    Proxy.initializer(proxy_admin)
    Oracle_set_oracle_controller_address(oracle_controller_address)
    return ()
end

#
# Upgrades
#

@external
func upgrade{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    new_implementation : felt
):
    Proxy.assert_only_admin()
    Proxy._set_implementation_hash(new_implementation)
    return ()
end

#
# Setters
#

@external
func setAdmin{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(new_admin : felt):
    Proxy.assert_only_admin()
    Proxy._set_admin(new_admin)
    return ()
end

#
# Getters
#

@view
func get_implementation_hash{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    ) -> (address : felt):
    let (address) = Proxy.get_implementation_hash()
    return (address)
end

@view
func get_admin{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}() -> (
    admin : felt
):
    let (admin) = Proxy.get_admin()
    return (admin)
end

@view
func get_entries{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    key : felt, sources_len : felt, sources : felt*
) -> (entries_len : felt, entries : Entry*):
    let (entries_len, entries) = Oracle_get_entries(key, sources_len, sources)
    return (entries_len, entries)
end

@view
func get_value{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    key : felt, aggregation_mode : felt, sources_len : felt, sources : felt*
) -> (value : felt, last_updated_timestamp : felt, num_sources_aggregated : felt):
    let (value, last_updated_timestamp, num_sources_aggregated) = Oracle_get_value(
        key, aggregation_mode, sources_len, sources
    )
    return (value, last_updated_timestamp, num_sources_aggregated)
end

@view
func get_entry{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    key : felt, source : felt
) -> (entry : Entry):
    let (entry) = Oracle_get_entry(key, source)
    return (entry)
end

@view
func get_all_sources{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    key : felt
) -> (sources_len : felt, sources : felt*):
    let (sources_len, sources) = Oracle_get_all_sources(key)
    return (sources_len, sources)
end

#
# Setters
#

@external
func set_oracle_controller_address{
    syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr
}(oracle_controller_address : felt):
    Oracle_set_oracle_controller_address(oracle_controller_address)
    return ()
end

@external
func publish_entry{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    new_entry : Entry
):
    Oracle_publish_entry(new_entry)
    return ()
end
