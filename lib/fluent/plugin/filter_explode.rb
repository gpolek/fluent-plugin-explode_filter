require 'fluent/plugin/filter'
require 'fluent/plugin/mixin/mutate_event'

module Fluent
  class ExplodeFilter < Filter
    Fluent::Plugin.register_filter('explode', self)

    def filter(tag, time, record)
      event = Fluent::Plugin::Mixin::MutateEvent.new(record, expand_nesting:true)
      event_data = iterate(event)
      event_data.to_record
    end

    def iterate(event)
      event_data = Fluent::Plugin::Mixin::MutateEvent.new({}, expand_nesting:true)
      event.each do |key, value|
        value.is_a?(Hash) ? event_data.set(key, iterate(Fluent::Plugin::Mixin::MutateEvent.new(event.get(key), expand_nesting:true))) : event_data.set(key, event.get(key))
      end
      return event_data
    end
  end
end
