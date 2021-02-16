class UserSerializer
    def initialize user
        @user = user
    end

    def to_serialized_json
        options = {
            include: {
                parties: {
                    except: [:created_at, :updated_at], include: {
                        user: { only: :name}
                    }
                },
                tastings: {
                    include: :party
                }
            },
            except: [:updated_at, :created_at, :password_digest]
        }
        @user.to_json(options)
    end
end