

# @api private
module PuppetX
    module Tragiccode
    
module HashExtensions
    def self.remove_keys_from_hash(hash, *keys)
        _hash = hash.dup
        keys.each { |key| _hash.delete(key) }
        return _hash
    end
end

end
end