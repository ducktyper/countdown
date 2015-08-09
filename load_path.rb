["", "test", "app/models"].each do |path|
  $LOAD_PATH.unshift File.expand_path("../#{path}", __FILE__)
end
