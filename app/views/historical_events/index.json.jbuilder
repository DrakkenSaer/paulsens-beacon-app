json.historical_events @historical_events do |historical_event| 
  json.partial! 'historical_events/historical_event', historical_event: historical_event
end