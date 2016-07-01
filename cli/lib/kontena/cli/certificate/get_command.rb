
module Kontena::Cli::Certificate
  class GetCommand < Clamp::Command
    include Kontena::Cli::Common
    include Kontena::Cli::GridOptions


    option '--secret-name', 'SECRET_NAME', 'The name for the secret to store the certificate in'
    parameter "[DOMAIN] ...", "Domain to get certificate for. The first one should be the one you used in authorization"


    def execute
      require_api_url
      token = require_token
      secret = secret_name || "LE_CERTIFICATE_#{domain_list[0].gsub('.', '_')}"
      data = {domains: domain_list, secret_name: secret}
      response = client(token).post("certificates/#{current_grid}/certificate", data)
      puts "Certificate successfully received and stored into vault with key #{response['secret_name']}"
    end
  end
end
