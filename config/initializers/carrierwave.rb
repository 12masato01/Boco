if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: 'AKIAQ4HYINFW4AIVBWPX',
      aws_secret_access_key: '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',
      region: 'ap-northeast-1'
    }

    config.fog_directory  = 'boco-image'
    config.cache_storage = :fog
  end
end