require 'pry'
Dir["lib/*.rb"].each {|file| load file }

binding.pry
