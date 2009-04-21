# Copyright 2009 Sidu Ponnappa

# Licensed under the Apache License, Version 2.0 (the "License"); 
# you may not use this file except in compliance with the License. 
# You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0 
# Unless required by applicable law or agreed to in writing, software distributed under the License 
# is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. 
# See the License for the specific language governing permissions and limitations under the License. 

# This is a base implementation of a
# hash mutator that ensures that the <tt>mutate</tt> method
# will chain to the next mutator by using a
# template method.
class Wrest::Components::Mutators::Base
  attr_reader :next_mutator
    
  def initialize(next_mutator = nil)
    @next_mutator = next_mutator
  end
  
  # This is a template method which operates on a tuple (well, pair)
  # from a hash map and guarantees mutator chaining.
  #
  # Iterating over any hash using <tt>each</tt> injects
  # each key/value pair from the hash in the
  # form of an array.
  # Thus the tuple this method expects 
  # is simply [:key, :value]
  #
  # The implementation of the mutation is achieved by
  # overriding the <tt>do_mutate</tt> method in a subclass.
  # Note that failing to do so will result in an exception
  # at runtime.
  def mutate(tuple)
    out_tuple = do_mutate(tuple)
    next_mutator ? next_mutator.mutate(out_tuple) : out_tuple
  end
  
  protected
  def do_mutate(tuple)
    raise Wrest::MethodNotOverriddenException
  end
end