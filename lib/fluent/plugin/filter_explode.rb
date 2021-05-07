require 'fluent/plugin/filter'
require 'fluent/plugin/mixin/mutate_event'

module Fluent
  class ExplodeFilter < Filter
    Fluent::Plugin.register_filter('explode', self)

    def filter(tag, time, record)
      event = Fluent::Plugin::Mixin::MutateEvent.new(record, expand_nesting:true)
      event_data = Fluent::Plugin::Mixin::MutateEvent.new({}, expand_nesting:true)

      event.keys.each do |key|
        event_data.set(key, event.get(key))
      end

      event_data.to_record
    end
  end
end
