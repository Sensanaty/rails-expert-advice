# frozen_string_literal: true

# Pagy initializer file (4.3.0)
# Customize only what you really need and notice that Pagy works also without any of the following lines.
# Should you just cherry pick part of this file, please maintain the require-order of the extras

# Extras
# See https://ddnexus.github.io/pagy/extras

# Backend Extras

# Array extra: Paginate arrays efficiently, avoiding expensive array-wrapping and without overriding
# See https://ddnexus.github.io/pagy/extras/array
# require 'pagy/extras/array'

# Countless extra: Paginate without any count, saving one query per rendering
# See https://ddnexus.github.io/pagy/extras/countless
# require 'pagy/extras/countless'
# Pagy::VARS[:cycle] = false    # default

# Elasticsearch Rails extra: Paginate `ElasticsearchRails::Results` objects
# See https://ddnexus.github.io/pagy/extras/elasticsearch_rails
# default :pagy_search method: change only if you use
# also the searchkick extra that defines the same
# VARS[:elasticsearch_rails_search_method] = :pagy_search
# require 'pagy/extras/elasticsearch_rails'

# Searchkick extra: Paginate `Searchkick::Results` objects
# See https://ddnexus.github.io/pagy/extras/searchkick
# default :pagy_search method: change only if you use
# also the elasticsearch_rails extra that defines the same
# VARS[:searchkick_search_method] = :pagy_search
# require 'pagy/extras/searchkick'

# Feature Extras

# Headers extra: http response headers (and other helpers) useful for API pagination
# See http://ddnexus.github.io/pagy/extras/headers
# require 'pagy/extras/headers'
# Pagy::VARS[:headers] = { page: 'Current-Page', items: 'Page-Items', count: 'Total-Count', pages: 'Total-Pages' }     # default

# Support extra: Extra support for features like: incremental, infinite, auto-scroll pagination
# See https://ddnexus.github.io/pagy/extras/support
# require 'pagy/extras/support'

# Items extra: Allow the client to request a custom number of items per page with an optional selector UI
# See https://ddnexus.github.io/pagy/extras/items
# require 'pagy/extras/items'
# Pagy::VARS[:items_param] = :items    # default
# Pagy::VARS[:max_items]   = 100       # default

# Overflow extra: Allow for easy handling of overflowing pages
# See https://ddnexus.github.io/pagy/extras/overflow
# require 'pagy/extras/overflow'
# Pagy::VARS[:overflow] = :empty_page    # default  (other options: :last_page and :exception)

# Metadata extra: Provides the pagination metadata to Javascript frameworks like Vue.js, react.js, etc.
# See https://ddnexus.github.io/pagy/extras/metadata
# you must require the shared internal extra (BEFORE the metadata extra) ONLY if you need also the :sequels
# require 'pagy/extras/shared'
require 'pagy/extras/metadata'
# For performance reason, you should explicitly set ONLY the metadata you use in the frontend
Pagy::VARS[:metadata] = %i[first_url prev_url page_url next_url last_url count page prev next last]

# Trim extra: Remove the page=1 param from links
# See https://ddnexus.github.io/pagy/extras/trim
require 'pagy/extras/trim'
# after requiring it will trim by default
# set to false if you want to make :trim an opt-in variable
# Pagy::VARS[:trim] = true # default

# Pagy Variables
# See https://ddnexus.github.io/pagy/api/pagy#variables
# All the Pagy::VARS are set for all the Pagy instances but can be overridden
# per instance by just passing them to Pagy.new or the #pagy controller method

# Instance variables
# See https://ddnexus.github.io/pagy/api/pagy#instance-variables
Pagy::VARS[:items] = 15

# Other Variables
# See https://ddnexus.github.io/pagy/api/pagy#other-variables
# Pagy::VARS[:size]       = [1,4,4,1]                       # default
# Pagy::VARS[:page_param] = :page                           # default
# Pagy::VARS[:params]     = {}                              # default
# Pagy::VARS[:anchor]     = '#anchor'                       # example
# Pagy::VARS[:link_extra] = 'data-remote="true"'            # example

# Rails

# Rails: extras assets path required by the helpers that use javascript
# (pagy*_nav_js, pagy*_combo_nav_js, and pagy_items_selector_js)
# See https://ddnexus.github.io/pagy/extras#javascript
# Rails.application.config.assets.paths << Pagy.root.join('javascripts')
