attributes = attribute('allure_commandline_integration', default: {})
settings = attribute('allure_commandline', default: {})
suite = attributes['suite']['default']

path = sprintf(settings['install_location_pattern'], settings['version'])

control 'allure-commandline-default-installation' do
  describe allure_commandline(path) do
    it { should exist }
    it { should be_working }
    it { should be_accessible_via suite['binary']  }
    its('version') { should eq settings['version'] }
  end
end
