class PartySerializer
    def initialize party, user_id
        @party = party
        @user_id = user_id
    end

    def to_serialized_json
        find_host
        partyData = {
            party: @party,
            wines: @party.wines,
            tastings: find_tastings,
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

    def find_tastings
        tastings = []
        User.find(@user_id).tastings.map do |taste|
            if taste.party_id == @party.id
                tasting = {
                    tasting: taste, 
                    wine: taste.wine
                }
                tastings << tasting
            end
        end
        return tastings
    end
end