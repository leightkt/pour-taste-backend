class PartySerializer
    def initialize party, user_id = nil
        @party = party
        @user_id = user_id
    end

    def to_serialized_json
        find_host
        find_invite
        partyData = {
            party: @party,
            wines: @party.wines,
            invite: @invite,
            tastings: find_tastings,
            host: {
                host_id: @host_id,
                host_name: @host.name
            }
        }
        
        partyData.to_json()

    end

    def results_to_serialized_json
        find_host
        total_wine_scores
        find_winner
        sort_scores

        partyData = {
            party: @party,
            host: {
                host_id: @host_id,
                host_name: @host.name
            },
            scores: @scores,
            winner: @winner
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

    def find_invite
        @invite = @party.invitations.find{|invite| invite.user_id == @user_id.to_i}
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

    def total_wine_scores
        @partywines = @party.wines.uniq{|wine| wine.id}

        @scores = []
        @partywines.each do |wine|
            total_rating = wine.tastings.reduce(0) do |sum, tasting|
                if tasting.party_id == @party.id && tasting.user_id != @host_id
                    sum + tasting.rating.to_f
                else
                    sum
                end
            end
            average_rating = (total_rating / (wine.tastings.length - 1) ).round(2)
            wineData = {
                wine: wine,
                score: average_rating
            }
            @scores << wineData
        end

    end

    def sort_scores
        @scores = @scores.sort_by{|scoreData| scoreData[:score]}.reverse()
    end

    def find_winner
        @winner = @scores.max_by {|wineData| wineData[:score]}
    end
end