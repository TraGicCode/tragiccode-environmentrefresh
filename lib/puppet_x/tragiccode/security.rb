

# @api private
module PuppetX
module Tragiccode

module Security
    def self.is_local_system?(username)
        # LocalSystem has many aliases to lets let windows handle this by converting the user to a single SID
        # which is shared across those aliases...
        user_sid = Puppet::Util::Windows::SID.name_to_sid(username)
        Puppet.debug("The SID of #{username} is : #{user_sid}")
        if user_sid == Puppet::Util::Windows::SID::LocalSystem
            return false
        end
        return true
    end
end

end
end