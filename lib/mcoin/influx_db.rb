# frozen_string_literal: true

require 'pp'
require 'net/http'

module Mcoin
  # :nodoc:
  class InfluxDB
    def initialize(endpoint, db, user = nil, pass = '')
      @endpoint = endpoint
      @db = db
      @user = user
      @pass = pass
    end

    def save(data)
      req = request(data)
      res = Net::HTTP.start(uri.hostname, uri.port) do |http|
        http.request(req)
      end

      pp JSON.parse(res.body) unless res.body.nil?
    end

    protected

    def request(data)
      req = Net::HTTP::Post.new(uri)
      req.basic_auth @user, @pass if @user
      req.content_type = 'multipart/form-data'
      req.body = data.join("\n")
      req
    end

    def uri
      URI("#{@endpoint}/write?db=#{@db}")
    end
  end
end
