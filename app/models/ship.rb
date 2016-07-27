class Ship < ActiveRecord::Base
  belongs_to :course_kind

  filterrific(
      default_filter_params: { sorted_by: 'created_at_desc' },
      available_filters: [
        :sorted_by,
        :search_query,
        :with_damage
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
     num_or_conditions = 2
     where(
       terms.map {
         or_clauses = [
           "LOWER(ship.classtype) LIKE ?",
           "LOWER(ship.name) LIKE ?",
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
        order("LOWER(ships.created_at) #{ direction }")
      when /^updated_at/
        order("LOWER(ships.updated_at) #{ direction }")
      else
        raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
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
end
