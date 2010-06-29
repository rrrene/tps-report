#!/usr/bin/env ruby -wKU

require 'csv'

class Report
  attr_accessor :collection
  
  def initialize(arr = [], opts = {})
    self.collection = arr
    @fields = self.class.fields_from_object(opts[:fields])
    @field_seperator = opts[:field_seperator] || ';'
    @row_seperator = opts[:row_seperator]
  end
  
  def report_fields
    if instance_fields = @fields
      instance_fields
    else
      @@fields ||= {}
      if class_fields = @@fields[self.class.name]
        class_fields
      else
        self.class.fields_from_object(collection.first)
      end
    end
  end
  
  def to_s
    out = ""
    csv = CSV::Writer.create(out, @field_seperator, @row_seperator)
    csv << report_fields if report_fields
    collection.each do |item|
      csv << row_for(item)
    end
    csv.close
    out
  end
  
  def row_for(ar)
    return ar if ar.is_a?(Array)
    report_fields.map { |f| 
      ar.respond_to?(f) ? ar.method(f).call : ar[f]
    }
  end
  
  class << self
    def fields(*new_fields)
      @@fields ||= {}
      if new_fields.empty?
        @@fields[name]
      else
        @@fields[name] = fields_from_object(new_fields)
      end
    end
    alias keys fields
    
    def fields_from_object(new_fields)
      return if new_fields.nil?
      new_fields = [new_fields] unless new_fields.is_a?(Array)
      new_fields.map { |f|         
        obj = f.respond_to?(:attributes) ? f.attributes : f
        obj.respond_to?(:keys) ? obj.keys : obj 
      }.flatten
    end
  
    def row_for(ar)
      new.row_for(ar)
    end
  end
end