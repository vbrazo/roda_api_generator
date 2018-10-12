module RspecSequel
  module Matchers

    class HaveManyToOneMatcher < RspecSequel::Association
      def association_type
        :many_to_one
      end
      
      def valid?(db, i, c, attribute, options)
        matching = super

        # check that association model exists, etc.
        matching
      end
    end

    def have_many_to_one(*args)
      HaveManyToOneMatcher.new(*args)
    end

  end
end