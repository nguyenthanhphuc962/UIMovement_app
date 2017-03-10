CarrierWave.configure do |config|
  #config.fog_provider = 'fog/aws'                        # required
  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     'AKIAIUJ6FWCIXGTJS76A',     # required
    aws_secret_access_key: '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', # required
    region:                'us-west-2'                 # optional, defaults to 'us-east-1'

  }
  #config.cache_dir = "#{Rails.root}/tmp/uploads"
  config.fog_directory  = 'uimovement-app'
end

module CarrierWave
  module MiniMagick
    def quality(percentage)
      manipulate! do |img|
        img.quality(percentage.to_s)
        img = yield(img) if block_given?
        img
      end
    end
  end
end
