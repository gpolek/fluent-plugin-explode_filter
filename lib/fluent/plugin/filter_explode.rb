require 'fluent/plugin/filter'

module Fluent
  class ExplodeFilter < Filter
    Fluent::Plugin.register_filter('explode', self)

    include Fluent::PluginMixin::MutateEvent

    def filter(tag, time, record)
      event = Fluent::PluginMixin::MutateEvent.new(record, expand_nesting:true)
      event_data = Fluent::PluginMixin::MutateEvent.new({}, expand_nesting:true)

      event.keys.each do |key|
        event_data.set(key, event.get(key))
      end

      event_data.to_record
    end
  end
end
