VCR.configure do |config|
  config.cassette_library_dir = Rails.root.join("spec", "vcr")
  config.stub_with :fakeweb
end