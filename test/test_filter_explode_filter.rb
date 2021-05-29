# coding: utf-8
require 'fluent/test'
require 'fluent/test/driver/filter'
require 'fluent/plugin/filter_explode'
require 'test/unit'

class ExplodeFilterTest < Test::Unit::TestCase
  def setup
    Fluent::Test.setup
    @tag = 'test.tag'
  end

  CONFIG = %q!
    
  !

  def create_driver(conf = CONFIG)
    Fluent::Test::Driver::Filter.new(Fluent::ExplodeFilter).configure(conf)
  end

  def get_hostname
    require 'socket'
    Socket.gethostname.chomp
  end

  def test_configure
    d = create_driver
    # map = d.instance.instance_variable_get(:@map)

    # map.each_pair { |k, v|
    #   assert v.is_a?(Fluent::ExplodeFilter)
    # }
  end

  def test_format
    d = create_driver
    
    d.run(default_tag: @tag) do
      d.feed("k" => 'v', "foo.bar" => 'foobar', "log.string" => '123', "log.number" => 123, "properties" => { "k" => "v"})
    end

    assert_equal [{"k" => 'v', "foo" => { "bar" => 'foobar' }, "log" => { "string" => '123', "number" => 123 }, "properties" => { "k" => "v"}}], d.filtered.map(&:last)
  
    assert_equal Hash, d.filtered.map(&:last)[0]["properties"].class
    assert_equal true, d.filtered.map(&:last)[0]["properties"].is_a?(Hash)
    assert_equal true, d.filtered.map(&:last)[0]["k"].is_a?(String)
    assert_equal true, d.filtered.map(&:last)[0]["log"]["string"].is_a?(String)
    assert_equal true, d.filtered.map(&:last)[0]["log"]["number"].is_a?(Numeric)
  end
end