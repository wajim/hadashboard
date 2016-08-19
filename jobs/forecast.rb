require 'open-uri'
require 'json'

SCHEDULER.every '25m', :first_in => 0 do |job|

open('http://api.wunderground.com/api/22920a603b9e88a7/geolookup/conditions/q/pws:ILUXEMBU10.json') do |f|
  json_string = f.read
  parsed_json = JSON.parse(json_string)
  location = parsed_json['location']['city']
  temp_c = parsed_json['current_observation']['temp_c']
  condition = parsed_json['current_observation']['weather']
  url = parsed_json['current_observation']['icon_url']
  #print "Current temperature in #{location} is: #{temp_f}\n"
  send_event('forecast', { temperature: "#{temp_c}&degC", condition: "#{condition}", icon_bg: "#{url}"})
end
def iconbg_class(icon_url)  
  icon_url
end
end