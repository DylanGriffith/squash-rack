#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.
#
#    Modified Square's squash_rails for Padrino

require 'squash/ruby'

module Squash
  module Padrino

    # Rack middleware that catches exceptions thrown outside the scope of
    # Padrino's request processing.
    class Rack

      # Instantiates the middleware.
      #
      # @param [Array] app The middleware stack.
      def initialize(app)
        @app = app
      end

      # Rescues any exceptions thrown downstream, notifies Squash, then
      # re-raises them.
      #
      # @param [Hash] env The Rack environment.
      # @return [Hash] The Rack result to pass up the stack.
      def call(env)

        begin
          result = @app.call(env)
        rescue ::Exception => ex
          @env['squash.notified'] = ::Squash::Ruby.notify(ex, squash_rack_data(env))
          raise ex
        end

        result
      end

      # @abstract
      #
      # Override this method to implement filtering of sensitive data in the
      # headers, cookies, and rack hashes (see {#squash_rack_data}). The method
      # signature is the same as `Squash::Ruby#filter_for_squash`, but `kind`
      # can also be `:env` for the Rack environment hash.
      def filter_for_squash(data, kind)
        data
      end

      # @return [Hash<Symbol, Object>] The additional information this
      #   middleware gives to `Squash::Ruby.notify`.
      def squash_rack_data(env)
        data = {
            :headers        => filter_for_squash(request_headers(env), :headers),
            :request_method => env['REQUEST_METHOD'].to_s.upcase,
            :schema         => env['rack.url_scheme'],
            :host           => env['SERVER_NAME'],
            :port           => env['SERVER_PORT'],
            :path           => env['PATH_INFO'],
            :query          => env['QUERY_STRING'],

            :params         => filter_for_squash(env['rack.request.query_hash'], :params),
            :body           => filter_for_squash(env['rack.input'].read, :body),
            :session        => filter_for_squash(env['rack.session'], :session),
            :cookies        => filter_for_squash(env['rack.request.cookie_hash'], :cookies),

            :"rack.env"     => filter_for_squash(env, :rack)
        }

        env['rack.input'].rewind

        data
      end

      private

      # Extract any rack key/value pairs where the key begins with HTTP_*
      def request_headers(env)
        env.select { |key, _| key[0, 5] == 'HTTP_' }
      end
    end
  end
end
