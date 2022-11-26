require 'net/http'
require 'json'

class Horoscope
  ALLOWED_SIGNS = %w(aries taurus gemini cancer leo virgo libra scorpio sagittarius capricorn aquarius pisces)
  ERROR_MESSAGE = "Hey dummy, that's not a proper zodiac sign. Reach out to Mike Cassano if you need help figuring out what they are. He's an astrological expert!"
  HOROSCOPE_ENDPOINT ="https://any.ge/horoscope/api/?sign=XXSIGNXX&type=daily&day=today&lang=en"

  def initialize(zodiac_sign)
    @zodiac_sign = zodiac_sign
  end

  def call
    return invalid_sign_message unless valid_sign?

    retrieve_horoscope
  end

  def self.get_daily(zodiac_sign)
    new(zodiac_sign).call
  end

  private

  attr_reader :zodiac_sign

  def invalid_sign_message
    "#{zodiac_sign.upcase}: #{ERROR_MESSAGE}"
  end

  def valid_sign?
    ALLOWED_SIGNS.include?(zodiac_sign)
  end

  def retrieve_horoscope
    uri = URI(HOROSCOPE_ENDPOINT.gsub("XXSIGNXX", zodiac_sign))
    response = json_response(uri)
    assemble_message(response)
  end

  def json_response(uri)
    JSON.parse(Net::HTTP.get(uri))
  end

  def assemble_message(json)
    horoscope = json[0]["text"]
    "#{zodiac_sign.upcase}: #{strip_html_tags(horoscope)}"
  end

  def strip_html_tags(text)
    re = /<("[^"]*"|'[^']*'|[^'">])*>/
    text.gsub(re, '')
  end
end
