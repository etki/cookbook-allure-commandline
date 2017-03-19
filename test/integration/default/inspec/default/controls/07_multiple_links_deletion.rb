attributes = attribute('allure_commandline_integration', default: {})
settings = attribute('allure_commandline', default: {})
suite = attributes['suite']['deleted-with-multiple-links']

control 'allure-commandline-multiple-links-deletion' do
  describe allure_commandline(suite['path'], settings['version']) do
    it { should_not exist }
  end
  describe file(suite['binary']) do
    it { should_not exist }
  end
  suite['links'].each do |link|
    describe file(link) do
      it { should_not exist }
    end
  end
end
