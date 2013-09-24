Redmine::Plugin.register :redmine_reaction_time do
  name 'Redmine Reaction Time plugin'
  author 'Pavel Nemkin'
  description 'Plugin adds report on reaction time for performing issues'
  version '0.0.1'
  url 'https://github.com/olemskoi/redmine_reaction_time'
  author_url 'https://github.com/kanfet'
  menu :application_menu, :reaction_time, { :controller => 'reaction_time_report', :action => 'show' },
       :caption => proc{ I18n.t('reaction_time.caption') }
end
