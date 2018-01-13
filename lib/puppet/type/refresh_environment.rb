Puppet::Type.newtype(:refresh_environment) do

  @doc = <<-HERE
    Refreshes environment both system & user environment variables along with preserving any process specific set environment variables
    for ruby within current run of puppet. The `refresh_environment` is used in situation where a resource modifies some user or system
    environment variable and would like the process that puppet is running under be updated to reflect these changes so that further resources
    in the catalog can utilize these updated environment variables.

    Sample usage:
      package { 'awscli':
        ensure   => 'present',
        provider => 'chocolatey',
        notify   => Refresh_environment['after awscli package']
      }

      refresh_environment { 'after awscli package':
      }

      archive { 'C:\\awesome-image.png':
        ensure => present,
        source => 's3://mycompany/images/awesome-image.png',
      }

  HERE


  newparam(:name, namevar: true) do
    desc 'The name of the refresh_environment resource.  Used for uniqueness.'
  end

  def refresh
    Puppet.debug("Refreshing refresh_environment")
    provider.refresh_environment_variables
  end
end