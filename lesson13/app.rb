require 'yaml'
require './mini_ar'

config = YAML.load_file('config.yml')
scheme = YAML.load_file('db.yml')

MiniActiveRecord::connect config

MiniActiveRecord::all_tables.each do |table|
  require "./models/#{table}"
end

MiniActiveRecord::generated_classes.each do |class_name|
  p "#{class_name}:"
  p Object.const_get("#{class_name}").new.fields
end

#p Figures.methods
#figure = Figure.get(1)
#figures = Figure.all
#p figures
