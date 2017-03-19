attributes = attribute('allure_commandline_integration', default: {})
versions = (attributes['versions'] or [])
suite = attributes['suite']['acceptance']

control 'allure-commandline-acceptance' do
  versions.each do |version|
    path = sprintf(suite['path_format'], version)
    binary_location = sprintf(suite['binary_location_format'], version)
    describe allure_commandline(path) do
      it { should exist }
      it { should be_working }
      its('version') { should eq version }
      it { should be_accessible_via binary_location }
    end
  end
end
