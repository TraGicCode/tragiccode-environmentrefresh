# refreshenvironment

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with refreshenvironment](#setup)
    * [Setup requirements](#setup-requirements)
    * [Beginning with refreshenvironment](#beginning-with-refreshenvironment)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Development - Guide for contributing to the module](#development)

## Description

The refreshenvironment module adds type for refreshing both system & user environment variables along with preserving any process specific set environment variables for the current run of puppet.  This type is meant to solve the issue where during a puppet run environment variables are changed by resources, for exampling installing a pacakge, and you would like those to immediately be available from within the current and future runs of puppet.

## Setup

### Setup Requirements

The refreshenvironment module requires the following:

* Puppet Agent 4.7.1 or later.
* Windows Server 2008 and up.

### Beginning with refreshenvironment

Below shows an example of how to refresh environment variables immediatly after installation of a package so that further resources in the catalog can utilize them immediately.

```puppet
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
```

## Reference

### Types

Parameters are optional unless otherwise noted.

#### `refresh_environment`

Refreshes environment both system & user environment variables along with preserving any process specific set environment variables for ruby within current run of puppet.

##### `name`

The name of the refresh_environment resource.  Used for uniqueness.

Default: the title of your declared resource.


## Contributing

1. Fork it ( <https://github.com/tragiccode/tragiccode-refreshenvironment/fork> )
1. Create your feature branch (`git checkout -b my-new-feature`)
1. Commit your changes (`git commit -am 'Add some feature'`)
1. Push to the branch (`git push origin my-new-feature`)
1. Create a new Pull Request