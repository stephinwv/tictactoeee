class Dog
attr_reader :first_name, :last_name, :sound
    def initialize(fname, lname, sound)
        @first_name = fname
        @last_name = lname
        @sound = sound
    end
    def get_sound()
        "I am #{first_name} #{last_name} and my sound is #{sound}"
    end
end