class MyLogger
  LEVEL = :none
  
  class << self
    def puts message
      Kernel::puts message if LEVEL != :none
    end
  end
end