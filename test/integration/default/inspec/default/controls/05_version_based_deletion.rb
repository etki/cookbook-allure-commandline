attributes = attribute('allure_commandline_integration', default: {})
settings = attribute('allure_commandline', default: {})
suite = attributes['suite']['deleted-with-version']

path = sprintf(settings['install_location_pattern'], suite['version'])

control 'allure-commandline-version-based-deletion' do
  describe allure_commandline(path) do
    it { should_not exist }
  end
  describe file(suite['binary']) do
    it { should_not exist }
  end
end
