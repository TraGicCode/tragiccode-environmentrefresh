
require File.join(File.dirname(__FILE__), '../../../puppet_x/tragiccode/system_environment')
require File.join(File.dirname(__FILE__), '../../../puppet_x/tragiccode/security')
require File.join(File.dirname(__FILE__), '../../../puppet_x/tragiccode/hash_extensions')

Puppet::Type.type(:refresh_environment).provide(:windows) do
    
    confine :operatingsystem => [:windows]
    
    def refresh_environment_variables
      new_process_env_hash = {}
      current_process_preserved_env_hash = ENV.to_hash
      machine_env_hash  = PuppetX::Tragiccode::SystemEnvironment.get_machine_environment_variables()
      Puppet.debug("Machine Environment Varibales = #{machine_env_hash}")
      
      # Ignore paths.  We will build these up seperately later.
      new_process_env_hash  = PuppetX::Tragiccode::HashExtensions.remove_keys_from_hash(current_process_preserved_env_hash, PuppetX::Tragiccode::SystemEnvironment::PATH_ENV_KEYS)
      # Ignore USERNAME from machine environment variable.  It's not really useful.
      new_process_env_hash.merge!(PuppetX::Tragiccode::HashExtensions.remove_keys_from_hash(machine_env_hash, 'USERNAME'))

      if PuppetX::Tragiccode::Security.is_local_system?(ENV['USERNAME'])
        user_env_hash = PuppetX::Tragiccode::SystemEnvironment.get_user_environment_variables()
        Puppet.debug("User Environment Varibales = #{user_env_hash}")
        new_process_env_hash.merge!(PuppetX::Tragiccode::HashExtensions.remove_keys_from_hash(user_env_hash, PuppetX::Tragiccode::SystemEnvironment::PATH_ENV_KEYS))
        # Tack on user paths to end of machine ones.
        PuppetX::Tragiccode::SystemEnvironment::PATH_ENV_KEYS.each { |path_key| new_process_env_hash[path_key] += ";#{user_env_hash[path_key]}" }
      end
      
      # TODO: Handle path changes done from the current process.
      # TODO: 8.3 file paths are showing up as a diff
      # TODO: i should be able to diff and tell the following to the user
      #       - Keys added
      #       - Keys Removed
      #       - Keys changed
      if current_process_preserved_env_hash != new_process_env_hash
        Puppet.debug("Environment for the process is stale will be updated.")
        Puppet.debug("Previous Environment Varibales = #{current_process_preserved_env_hash}")
        Puppet.debug("New Environment Variables = #{new_process_env_hash}")
        ENV.to_hash.merge(new_process_env_hash)
      else
        Puppet.debug("Environment for the process is already up-to-date.")
      end
    end

end