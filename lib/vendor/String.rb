require "pathname"

class String
  ##
  # Convert to camel case.
  #
  #   "foo_bar".camel_case          #=> "FooBar"
  #
  # @return [String] Receiver converted to camel case.
  #
  def camel_case
    return self if self !~ /_/ && self =~ /[A-Z]+.*/
    split('_').map{|e| e.capitalize}.join
  end
end