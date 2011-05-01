class Object
  def send_updates!(hash)
    # updates values based on blocks passed in a hash

    hash.each do |key, block|
        self[key] = block.call(self[key]) if self[key]
    end

  end
end


