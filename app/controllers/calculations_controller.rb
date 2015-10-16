class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.gsub(" ", "").length

    @word_count = @text.split.length

    @occurrences = @text.downcase.split.count(@special_word)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f
    @months = @years*12
    @e_rate = @apr/1200

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    @monthly_payment = @principal*(@e_rate+(@e_rate/(((1+@e_rate)**(@months))-1)))

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending - @starting
    @minutes = @seconds / 1.minute
    @hours = @seconds / 1.hour
    @days = @seconds / 1.day
    @weeks = @seconds / 1.week
    @years = @seconds / 1.year

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)


    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @sorted_numbers.last-@sorted_numbers.first
    #@sorted_numbers.to_formatted_s

    @median = (@sorted_numbers[((@sorted_numbers.length-1)/2)]+@sorted_numbers[(@sorted_numbers.length/2)]) / 2

    @sum = @numbers.sum

    @mean = (@numbers.sum)/(@numbers.size)

    sumsqrdiff=0
    @numbers.each do |num|
        sumsqrdiff += (num-@mean)**2
    end
    @variance = sumsqrdiff/@count


    #This needs to be done as an each do

    @standard_deviation = @variance**.5

    @mode = @sorted_numbers.uniq.max_by{ |i| @sorted_numbers.count( i ) }

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
