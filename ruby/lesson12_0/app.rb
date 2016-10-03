require 'yaml'
require './mini_ar'

config = YAML.load_file('config.yml')
scheme = YAML.load_file('db.yml')

MiniActiveRecord::connect config

p Figure.all
p Figure.get(1)
#p Figures.methods
#figure = Figure.get(1)
#figures = Figure.all
#p figures
