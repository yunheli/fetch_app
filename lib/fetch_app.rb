require "fetch_app/version"
require 'rest-client'
module FetchApp
  ANDROID_BASE_URL = 'http://www.wandoujia.com/apps/'
  IOS_BASE_URL = 'http://itunes.apple.com/lookup?country=cn&'
  # Your code goes here...
  class << self
    def fetch_app type,bundle_id
      type ||= 'ios'
      type = type.downcase
      if type != 'ios' && type != 'android'
        return nil
      end

      Object.send("fetch_#{type}",bundle_id)
    end

    def fetch_ios bundle_id

    end

    def fetch_android bundle_id
      url = ANDROID_BASE_URL+"#{bundle_id}?json"
      data = RestClient.get(url)
      return nil if !data
      body = data.body
      begin
      
      info = JSON.parse(body)
      if info && info.packageName
        info_detail = {
          name: info.app.title,
          app_id: info.packageName,
          version: info.app.latestApk.versionName,
          desc: info.app.description.gsub("<br />","\n"),
          link: info.app.latestApk.downloadUrl.referUrl,
          icon: info.app.icons.px256 || info.app.icons.px100,
          screens: info.app.screenshots.normal
        }

        return info_detail
      else
        return nil
      end

      rescue Exception => e
        return nil
      end

    end

  end
end
