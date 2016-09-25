require 'yaml'

# Ruby-метод для создания объекта нужного класса
def self.Figure(type, params = {})
    Object.const_get("Figure::#{type.capitalize}").new params
rescue NameError
    raise 'Неизвестный тип'
end

class Figure

    attr_reader :p1, :p2, :p3, :p4, :p5, :formula, :squre

    def initialize params
        set_params params
    end
    def set_params params
      @p1 = params['p1']
      @p2 = params['p2']
      @p3 = params['p3']
      @p4 = params['p4']
      @p5 = params['p5']
      @formula = params['formula']
      @squre = 0
      p params
    end

    def calc_squre
      to_eval = "@squre = #{@formula}"
      eval to_eval
      p @squre
    end

    class Circle < self; end
    class Rectangle < self; end
    class Romb < self; end
    class Triangle < self; end
end

fig = Figure :triangle, {'p1' => 2, 'formula' => 'p1 * 2 + 4'}
fig.calc_squre

# res = YAML.load_file("db.yml")
# p res
