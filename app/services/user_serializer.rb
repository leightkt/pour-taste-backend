class UserSerializer
    def initialize user
        @user = user
    end

    def to_serialized_json
        options = {
            include: {
                invitations: { include: :party, except: [:created_at, :updated_at]},
                tastings: { include: :party, except: [:created_at, :updated_at] }
            }, except: [:created_at, :updated_at]
        }
        @user.to_json(options)
    end

end