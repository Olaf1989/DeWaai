class User < ActiveRecord::Base
  rolify
  authenticates_with_sorcery!

  has_many :user_courses, :dependent => :destroy
  has_many :courses, -> { distinct }, :through => :user_courses

  after_create :assign_default_role # After create assign default role

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, uniqueness: true # Email must be unique (not more than one user per email)
  validates :email, :firstname, :surename, :birthdate, :address, :zipcode, :city, :telephone, presence: true # Must be present, so all the info is there if there is a submit for an course

  filterrific(
    default_filter_params: { sorted_by: 'created_at_desc' },
    available_filters: [
      :sorted_by,
      :search_query,
      :with_created_at_gte,
      :with_created_at_lte,
      :with_all_role_ids,
    ]
  )

  # Searchfunction
  scope :search_query, lambda { |query|
  return nil  if query.blank?
   # condition query, parse into individual keywords
   terms = query.downcase.split(/\s+/)
   # replace "*" with "%" for wildcard searches,
   # append '%', remove duplicate '%'s
   terms = terms.map { |e|
     (e.gsub('*', '%') + '%').gsub(/%+/, '%')
   }
   # configure number of OR conditions for provision
   # of interpolation arguments. Adjust this if you
   # change the number of OR conditions.
   num_or_conditions = 4
   where(
     terms.map {
       or_clauses = [
         "LOWER(users.email) LIKE ?",
         "LOWER(users.firstname) LIKE ?",
         "LOWER(users.surenamePrefix) LIKE ?",
         "LOWER(users.surename) LIKE ?",
       ].join(' OR ')
       "(#{ or_clauses })"
     }.join(' AND '),
     *terms.map { |e| [e] * num_or_conditions }.flatten
   )
  }

  # Sort
  scope :sorted_by, lambda { |sort_option|
  direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
  case sort_option.to_s
    when /^created_at/
      order("LOWER(users.created_at) #{ direction }")
    when /^updated_at/
      order("LOWER(users.updated_at) #{ direction }")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
  end
  }

  # Created_at date filter
   scope :with_created_at_gte, lambda { |ref_date|
     where('users.created_at >= ?', ref_date)
   }

   # Updated_at date filter
    scope :with_created_at_lte, lambda { |ref_date|
      where('users.updated_at <= ?', ref_date)
    }

   # Sort options
   def self.options_for_sorted_by
    [
      ['Aangemaakt op (oplopend)', 'created_at_asc'],
      ['Aangemaakt op (aflopend)', 'created_at_desc'],
      ['Gewijzigd op (aflopend)', 'updated_at_asc'],
      ['Gewijzigd op (oplopend)', 'updated_at_desc'],
    ]
  end

  def self.options_for_select
    order('LOWER(created_at)').map { |e| [e.created_at, e.id] }
    order('LOWER(updated_at)').map { |e| [e.updated_at, e.id] }
  end


  # If user creates an account it will get the role 'cursist' if there isn't any other role selected.
  # So if an admin creates an account and will select an role, it will not use the default role.
  def assign_default_role
    if self.roles.blank?
      self.add_role :Cursist
    end
  end
end
