# frozen_string_literal: true

namespace :newsletter do
  # Prints to stdout all active vacancies that can be used for the newsletter.
  #
  # start - The interger number of a vacancy ID that is used as start pointer
  #         for pointer-based pagination.
  desc 'List active vacancies for the newsletter'
  task :build, [:start] => [:environment] do |_, args|
    start = args[:start] || raise('Required argument `start` is not provided')
    table = Vacancy.arel_table
    scope = Vacancy.available.where(table[:id].gt(start)).order(id: :asc)
    helper = Class.new do
      extend VacanciesHelper
    end

    scope.find_each.with_index do |vacancy, index|
      puts " #{index} ".center(80, '~')
      puts ''
      puts vacancy.title
      puts helper.company_location_tag(vacancy).gsub(' &mdash; ', ', ')
      puts ''
      puts ''
      puts vacancy.description
      puts ''
    end
  end
end
