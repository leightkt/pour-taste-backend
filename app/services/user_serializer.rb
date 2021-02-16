class UserSerializer
    def initialize user, parties, tastings
        @user = user
        @parties = parties
        @tastings = tastings
    end

    def to_serialized_json
        find_host
        userdata = {
            user: @user, 
            parties: @hosted_parties,
            tastings: @tastings
        }
        
        userdata.to_json()
    end

    def find_host   
        @hosted_parties = []
        @parties.each do |party|
            hosted_party =  {
                party: party,
                host_id: party.user_id,
                host: User.find(party.user_id).name
            }
            @hosted_parties << hosted_party
        end
    end
end