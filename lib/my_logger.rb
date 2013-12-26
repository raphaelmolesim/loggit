class MyLogger
  LEVEL = :none
  
  class << self
    def puts message
      puts message if LEVEL != :none
    end
  end
end