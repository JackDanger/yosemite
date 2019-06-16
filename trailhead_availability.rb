#!/usr/bin/env ruby
require 'open-uri'
require 'nokogiri'

module TrailheadAvailability
  extend self
  STATUS_PAGE = 'https://www.nps.gov/yose/planyourvisit/fulltrailheads.htm'

  def check(start, finish)
    available_during(start, finish)
  end

  def trailhead_names
    @trailhead_names ||= trailhead_full_dates.keys
  end

  private

  def available_during(start, finish)
    trailhead_full_dates.reject do |trailhead_name, full_dates|
      (start..finish).any? { |trip_day| full_dates.include?(trip_day) }
    end.keys
  end

  def trailhead_full_dates
    @trailhead_full_dates ||= begin
      report_section.children.each_with_object({}) do |child, acc|
        next if child.text.gsub(/[\r\n\t ]/, '').empty?
        next if child.text =~ /Report Date/i
        trailhead_name = child.search('b').text
        if trailhead_name.empty?
          # Note: This relies on modern Ruby with stable hash keys
          trailhead_name = acc.keys.last
          each_date(child.text) { |date| acc[trailhead_name] << date }
        else
          acc[trailhead_name] = []
        end
      end
    end
  end

  def report_section
    @report_section ||= doc.search('div#cs_control_5529617:contains("Report Date: ")').children.last
  end

  def doc
    @doc ||= Nokogiri::HTML(open(STATUS_PAGE).read)
  end

  def each_date(date_line)
    month, *days = date_line.split(' ')
    days.each { |day| yield Date.parse("#{month} #{day}") }
  rescue => e
    require 'pry'
    binding.pry
    p e
  end
end


# If this script is called directly
if $0 == __FILE__
  if ARGV.empty?
    warn "USAGE: #{$0} start_date [end_date]"
    exit 1
  end

  start, finish = ARGV
  finish ||= start

  start = Date.parse(start)
  finish = Date.parse(finish)

  available_trailheads = TrailheadAvailability.check(start, finish)

  puts "Found #{available_trailheads.size}/#{TrailheadAvailability.trailhead_names.size} available trailheads"
  available_trailheads.each do |trailhead|
    puts "  #{trailhead}"
  end
end
