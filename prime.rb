require 'prime'

MIN_VALUE = 10
MAX_VALUE = 999_999

class Integer
  def proper_divisors
    return [] if self == 1
    primes = prime_division.flat_map { |prime, freq| [prime] * freq }
    (1...primes.size).each_with_object([1]) do |n, res|
      primes.combination(n).map { |combi| res << combi.inject(:*) }
    end.flatten.uniq
  end
end

class PrimeCache
  attr_accessor :result, :potential_numbers, :divisors
  def initialize
    @result = {}
    @potential_numbers = []
    @divisors = [2, 3, 4, 5, 6, 10, 12, 13, 14, 18, 20, 22]
  end

  def loop_numbers
    (MIN_VALUE..MAX_VALUE).map do |n|
      result[n] = result_set(n)
      puts "step #{n}" if line_threshold(n)
    end
  end

  def fill_result_set
    divisors.each do |div|
      potential_numbers << result.select { |_, value| value == div }
    end
  end

  def result_set(n)
    n.proper_divisors.size + 1
  end

  def line_threshold(n)
    n % 50_000 == 0
  end

  # refactor!
  def find_potential_result
    0.upto(divisors.size).each do |d|
      next if potential_numbers[d].nil?
      potential_numbers[d].each do |num, div|
        # filter one more to hash or array
        puts "divisor #{divisors[d]} - #{num}" # if divisors[d] == 3
        # then use the following line to find suitable numbers
        # num.to_s.chars.map(&:to_i)[0] == 5 && num.to_s.chars.map(&:to_i)[5] == 9
      end
    end
  end
end

prime = PrimeCache.new
prime.loop_numbers
prime.fill_result_set
prime.find_potential_result
