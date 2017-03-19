attributes = attribute('allure_commandline_integration', default: {})
settings = attribute('allure_commandline', default: {})
suite = attributes['suite']['with-version']

path = sprintf(settings['install_location_pattern'], suite['version'])

control 'allure-commandline-version-based-installation' do
  describe allure_commandline(path) do
    it { should be_working }
    it { should be_accessible_via suite['binary']}
    its('version') { should eq suite['version'] }
  end
end
