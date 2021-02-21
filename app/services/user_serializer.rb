class UserSerializer
    def initialize user
        @user = user
    end

    def to_serialized_json
        options = {
            include: {
                invitations: { include: :party, except: [:created_at, :updated_at]}
            }, except: [:created_at, :updated_at, :password_digest]
        }
        @user.to_json(options)
    end

    def tastings_to_serialized_json
        find_closed_party_tastings
        @tastings.to_json()
    end

    def find_closed_party_tastings
        @tastings = []
        @user.tastings.map do |tasting|
            if tasting.party.party_open == false
                tastingData = {
                    tasting: tasting,
                    wine: tasting.wine,
                    date: tasting.party.date
                }
                @tastings << tastingData
            end
        end
    end

end