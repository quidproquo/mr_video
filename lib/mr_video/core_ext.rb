unless Hash.instance_methods.include?(:transform_keys)
  class Hash
    def transform_keys
      result = self.class.new
      each_key do |key|
        result[yield(key)] = self[key]
      end
      result
    end
  end
end

