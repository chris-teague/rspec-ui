module RSpec
  module Ui
    # Fake class to document RSpec Rails configuration options. In practice,
    # these are dynamically added to the normal RSpec configuration object.
    class Configuration
      # @!method infer_spec_type_from_file_location!
      # Automatically tag specs in conventional directories with matching `type`
      # metadata so that they have relevant helpers available to them. See
      # `RSpec::Rails::DIRECTORY_MAPPINGS` for details on which metadata is
      # applied to each directory.

      # @!method render_views=(val)
      #
      # When set to `true`, controller specs will render the relevant view as
      # well. Defaults to `false`.

      # @!method render_views(val)
      # Enables view rendering for controllers specs.

      # @!method render_views?
      # Reader for currently value of `render_views` setting.
    end

    # Mappings used by `infer_spec_type_from_file_location!`.
    #
    # @api private
    DIRECTORY_MAPPINGS = {
      :ui => %w[spec ui]
    }

    # @private
    def self.initialize_configuration(config)

      config.add_setting :always_run_ui_tests, :default => false

      # Borrowed from rspec-rails
      config.instance_exec do
        def infer_spec_type_from_file_location!
          DIRECTORY_MAPPINGS.each do |type, dir_parts|
            escaped_path = Regexp.compile(dir_parts.join('[\\\/]') + '[\\\/]')
            define_derived_metadata(:file_path => escaped_path) do |metadata|
              metadata[:type] ||= type
            end
          end
        end
      end

      config.include RSpec::Ui::UiExampleGroup, :type => :ui
    end

    initialize_configuration RSpec.configuration
  end
end
