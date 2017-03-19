attributes = attribute('allure_commandline_integration', default: {})
settings = attribute('allure_commandline', default: {})
suite = attributes['suite']['deleted-with-path']

control 'allure-commandline-path-based-deletion' do
  describe allure_commandline(suite['path'], settings['version']) do
    it { should_not exist }
  end
  describe file(suite['binary']) do
    it { should_not exist }
  end
end
