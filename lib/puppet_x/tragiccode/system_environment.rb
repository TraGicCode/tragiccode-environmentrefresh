require 'win32/registry'

# @api private
module PuppetX
module Tragiccode

module SystemEnvironment
    MACHINE_KEY     = 'SYSTEM\\CurrentControlSet\\Control\\Session Manager\\Environment'
    USER_KEY        = 'Environment'
    REGISTRY_ACCESS = Win32::Registry::KEY_READ
    PATH_ENV_KEYS   = ['Path', 'PSModulePath', 'PATHEXT']

    def self.get_machine_environment_variables()
        self.get_environment_variables(Win32::Registry::HKEY_LOCAL_MACHINE, MACHINE_KEY)
    end

    def self.get_user_environment_variables()
        self.get_environment_variables(Win32::Registry::HKEY_CURRENT_USER, USER_KEY)
    end

    def self.get_environment_variables(root_key, key)
        env_hash = {}
        Win32::Registry.open(root_key, key, REGISTRY_ACCESS) do |reg|
            reg.each_value() do |subkey, type, data|
              env_hash[subkey] = reg.read_s_expand(subkey)
            end
          end
        return env_hash
    end
end

end
end