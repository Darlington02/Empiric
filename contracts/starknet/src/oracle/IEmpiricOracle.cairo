%lang starknet

struct BaseEntry {
    timestamp: felt,  // Timestamp of the most recent update, UTC epoch
    source: felt,  // UTF-8 encoded uppercased string, e.g. "FTX"
    publisher: felt,  // UTF-8 encoded uppercased string, e.g. "CONSENSYS"
    // Publisher of the data (usually the source, but occasionally a third party)
}

struct SpotEntry {
    base: BaseEntry,
    pair_id: felt,  // UTF-8 encoded uppercased string, e.g. "ETH/USD"
    price: felt,  // Price shifted to the left by decimals
    volume: felt,  // Volume aggregated into this market price
}

namespace EmpiricAggregationModes {
    const MEDIAN = 84959893733710;  // str_to_felt("MEDIAN")
}

@contract_interface
namespace IEmpiricOracle {
    //
    // Getters
    //

    func get_spot_decimals(pair_id: felt) -> (decimals: felt) {
    }

    func get_spot_entries(pair_id: felt, sources_len: felt, sources: felt*) -> (
        entries_len: felt, entries: SpotEntry*
    ) {
    }

    func get_spot_entry(pair_id: felt, source: felt) -> (entry: SpotEntry) {
    }

    func get_spot(pair_id: felt, aggregation_mode: felt) -> (
        price: felt, decimals: felt, last_updated_timestamp: felt, num_sources_aggregated: felt
    ) {
    }

    func get_spot_for_sources(
        pair_id: felt, aggregation_mode: felt, sources_len: felt, sources: felt*
    ) -> (price: felt, decimals: felt, last_updated_timestamp: felt, num_sources_aggregated: felt) {
    }

    func get_spot_entries_for_sources(pair_id: felt, sources_len: felt, sources: felt*) -> (
        entries_len: felt, entries: SpotEntry*
    ) {
    }

    func get_spot_median(pair_id: felt) -> (
        price: felt, decimals: felt, last_updated_timestamp: felt, num_sources_aggregated: felt
    ) {
    }

    func get_spot_median_for_sources(pair_id: felt, sources_len: felt, sources: felt*) -> (
        price: felt, decimals: felt, last_updated_timestamp: felt, num_sources_aggregated: felt
    ) {
    }
}
