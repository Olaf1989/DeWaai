class Course < ActiveRecord::Base
  belongs_to :course_kind
  has_many :user_courses, :dependent => :destroy
  has_many :users, -> { distinct }, :through => :user_courses

  filterrific(
      default_filter_params: { sorted_by: 'startdate_asc' },
      available_filters: [
        :sorted_by,
        :search_query,
        :with_startdate_gte,
        :with_enddate_lte,
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
     num_or_conditions = 1
     where(
       terms.map {
         or_clauses = [
           "LOWER(course.id) LIKE ?",
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
        order("LOWER(courses.created_at) #{ direction }")
      when /^startdate/
        order("LOWER(courses.startdate) #{ direction }")
      else
        raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
    }

    # Startdate date filter
     scope :with_startdate_gte, lambda { |ref_date|
       where('courses.startdate >= ?', ref_date)
     }

     # Enddate date filter
      scope :with_enddate_lte, lambda { |ref_date|
        where('courses.enddate <= ?', ref_date)
      }

     # Sort options
     def self.options_for_sorted_by
      [
        ['Aangemaakt op (oplopend)', 'created_at_asc'],
        ['Aangemaakt op (aflopend)', 'created_at_desc'],
        ['Begindatum (aflopend)', 'startdate_asc'],
        ['Begindatum (oplopend)', 'startdate_desc'],
      ]
    end

    def self.options_for_select
      order('LOWER(created_at)').map { |e| [e.created_at, e.id] }
      order('LOWER(startdate)').map { |e| [e.updated_at, e.id] }
    end
end
