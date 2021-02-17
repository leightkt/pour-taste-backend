class PartySerializer
    def initialize party
        @party = party
    end

    def to_serialized_json
        find_host
    
        partyData = {
            party: @party,
            wines: @party.wines,
            tastings: @party.tastings,
            host: {
                host_id: @host_id,
                host_name: @host.name
            }
        }
        partyData.to_json()

    end
    
    def find_host
        @hostinvite = @party.invitations.find do |invitation|
            invitation.host == true
        end
        @host_id = @hostinvite.user_id
        @host = User.find(@host_id)
    end
end