class UserSerializer
    def initialize user
        @user = user
    end

    def to_serialized_json
        options = {
            include: {
                invitations: { include: :party, except: [:created_at, :updated_at]}
            }, except: [:created_at, :updated_at, :password_digest, :email]
        }
        @user.to_json(options)
    end

    def tastings_to_serialized_json
        options = {
            include: {
                tastings: { include: 
                    [:wine, :party], except: [:created_at, :updated_at] }
            }, except: [:invitations, :created_at, :updated_at, :password_digest, :email]
        }
        @user.to_json(options)
    end

end