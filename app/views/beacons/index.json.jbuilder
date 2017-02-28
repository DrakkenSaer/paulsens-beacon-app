json.beacons @beacons do |beacon|
  json.partial! 'beacons/beacon', beacon: beacon
end