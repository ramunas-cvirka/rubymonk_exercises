# 0.1 Being Meta
class String
  def words
    self.split(' ')
  end
end

# 1.0 Just what does #send do?
## ex. 1
class Nomad
  def initialize(glider)
    @glider = glider
  end

  def do(action)
    @glider.send(action)
  end
end

## ex. 2
class Nomad
  def initialize(glider)
    @glider = glider
  end

  def do(action, argument = nil)
    if argument == nil
      @glider.send(action)
    else
      @glider.send(action, argument)
    end
  end
end

## ex. 3
class Initiate
  def initialize(secretive_monk)
    @secretive_monk = secretive_monk
  end
  
  def	meaning_of_life
    # change this line to sneakily call `meaning_of_life`, even though
    # it is a private method.
    @secretive_monk.send(:meaning_of_life)
  end
end

## ex. 4
def relay(array, data_type)
  array.map { |v| v.send("to_#{data_type}") }
end

# 1.1 Method Missing
## ex. 1
class Spy
  def method_missing sym
  end
end

## ex. 2
class Spy
  def method_missing sym, *args
  end
end

## ex. 3
class Spy
  def method_missing sym, *args, &block
  end
end

## ex. 4
class MethodCall
  def initialize(sym, args)
    @sym = sym
    @args = args
  end
  
  def sym
    @sym
  end
  
  def args
    @args
  end
  
  def ==(other_call)
    @sym == other_call.sym && @args == other_call.args
  end
end

class Spy
  def initialize
    @method_calls = []
  end
  
  def method_missing sym, *args, &block
    @method_calls << MethodCall.new(sym, args)
  end

  def method_called?(sym, *args)
    nmc = MethodCall.new(sym, args)
    @method_calls.any? { |mc| mc == nmc }
  end
end

## ex. 5
class Spy
  def initialize(enemy_agent)
    @enemy_agent = enemy_agent
  end

  def method_missing sym, *args, &block
    @enemy_agent.send(sym, *args)
  end
end

# 1.2 Define Method
class Monk
  ["life", "the universe", "everything"].each do |p|
    define_method("meditate on #{p}".gsub(' ', '_')) { "I know the meaning of #{p}" }
  end
end

# 2.1 Inspector Gadget
editor = Editor.new("class Foo; end")

def auto_complete(editor)
	editor.cursor.read do |word|
      sword = word.to_sym  
      if word == "\n"
        throw :eol
      elsif editor.template.user_classes.include?(sword)
        build_suggestion(eval(word.to_s).methods)
      elsif editor.template.context.methods.include?(sword)
        build_suggestion(editor.template.context.method(sword).parameters)
      end
	end
end

def build_suggestion(list)
  Suggestion.new(list).display
end

# 2.2 Tap In Deeper
## ex. 1
def auto_complete(editor)
  editor.cursor.read do |word|
      sword = word.to_sym  
      if word == "\n"
        throw :eol
      elsif editor.template.user_classes.include?(sword)
        build_suggestion(Editor.const_get(word).methods)
      elsif editor.template.context.methods.include?(sword)
        build_suggestion(editor.template.context.method(sword).parameters)
      end
	end
end

def build_suggestion(list)
  Suggestion.new(list).display
end

## ex. 2
def inspect_instance_variable(class_name, variable)
  eval(class_name).new.instance_variable_get("@#{variable}")
end