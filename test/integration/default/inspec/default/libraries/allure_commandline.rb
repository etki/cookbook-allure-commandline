class AllureCommandline < Inspec.resource(1)
  NAME = :allure_commandline

  name NAME

  def initialize(path, expected_version = nil)
    @expected_version = expected_version
    @path = path
    @attributes = read_attributes(path)
  end

  def method_missing(name)
    @attributes[name]
  end

  def exist?
    @attributes[:exists]
  end

  def absent?
    @attributes[:absent?]
  end

  def executable?
    @attributes[:executable]
  end

  def work?
    @attributes[:works]
  end

  def works?
    @attributes[:works]
  end

  def working?
    @attributes[:works]
  end

  def accessible_via?(path)
    resource = inspec.file(path)
    resource.executable?(nil, nil) and resource.linked_to?(@attributes[:entrypoint])
  end

  def to_s
    NAME unless @attributes[:path]
    "#{NAME}[#{@attributes[:path]}]"
  end

  private
  def read_attributes(path)
    path_resource = inspec.directory(path)
    entrypoint = "#{path}/bin/allure"
    entrypoint_resource = inspec.file(entrypoint)
    exists = entrypoint_resource.exist?
    attributes = {
        path: path,
        entrypoint: entrypoint,
        exists: exists,
        absent: (not path_resource.exist?),
        executable: (exists and entrypoint_resource.executable?(nil, nil)),
        works: false,
        version: nil
    }
    if exists
      command = "\"#{entrypoint}\" version"
      execution = inspec.command(command)
      Inspec::Log.debug("Command executed during allure_commandline attribute computing: #{execution.inspect}")
      attributes[:works] = execution.exit_status == 0
      attributes[:version] = execution.stdout.strip
    end
    Inspec::Log.debug("Computed allure_commandline attributes: #{attributes.inspect}")
    attributes
  end
end