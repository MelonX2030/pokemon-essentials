module GameData
  class Ability
    attr_reader :id
    attr_reader :real_name
    attr_reader :real_description
    attr_reader :flags

    DATA = {}
    DATA_FILENAME = "abilities.dat"

    extend ClassMethodsSymbols
    include InstanceMethods

    SCHEMA = {
      "SectionName"  => [:id,               "m"],
      "Name"         => [:real_name,        "s"],
      "Description"  => [:real_description, "q"],
      "Flags"        => [:flags,            "*s"]
    }

    def initialize(hash)
      @id               = hash[:id]
      @real_name        = hash[:real_name]        || "Unnamed"
      @real_description = hash[:real_description] || "???"
      @flags            = hash[:flags]            || []
    end

    # @return [String] the translated name of this ability
    def name
      return pbGetMessageFromHash(MessageTypes::Abilities, @real_name)
    end

    # @return [String] the translated description of this ability
    def description
      return pbGetMessageFromHash(MessageTypes::AbilityDescs, @real_description)
    end

    def has_flag?(flag)
      return @flags.any? { |f| f.downcase == flag.downcase }
    end
  end
end
