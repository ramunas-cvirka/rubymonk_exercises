# Whodunnit?
def location_in_hierarchy(object, method)
  l = [object.class]
  obj = object.class
  while obj.superclass != nil
    l << obj.superclass
    obj = obj.superclass
  end
  l.reverse.each { |c| return c if c.instance_methods.include? method }
end

# Compute sum of cubes for a given range
def sum_of_cubes(a, b)
  (a..b).inject(0) { |acc, iter| acc + iter**3 }
end