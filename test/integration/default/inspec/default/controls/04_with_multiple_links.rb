attributes = attribute('allure_commandline_integration', default: {})
settings = attribute('allure_commandline', default: {})
suite = attributes['suite']['with-multiple-links']

path = sprintf(settings['install_location_pattern'], settings['version'])

control 'allure-commandline-with-multiple-links' do
  describe allure_commandline(path) do
    it { should be_working }
    suite['links'].each do |link|
      it { should be_accessible_via link }
    end
  end
end
