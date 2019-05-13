require 'open-uri'
require 'JSON'


class GamesController < ApplicationController
  def new
    @letters = [*('A'..'Z')].to_a.sample(10)
  end

  def score
    @word_given = params[:word].upcase.chars.sort
    @letters = params[:letters].split.sort

    if !(@word_given - @letters).empty?
      @score = "Sorry, #{params[:word]} can't be built out of the given letters"
    elsif !english_word?(params[:word])
      @score = "Sorry, #{params[:word]} is not an English word"
    else
      @score = 'Congrats! It is an English word'
    end
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end
end
