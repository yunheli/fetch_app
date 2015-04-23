require "fetch_app/version"
require 'rest-client'
require 'json'
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

      self.send("fetch_#{type}",bundle_id)
    end

    def fetch_ios bundle_id=""
      url = IOS_BASE_URL ;

      if  bundle_id.is_a?(Numeric)
        bundle_id = bundle_id.to_s
      end

      return raise 'bundle_id is error' if !bundle_id || bundle_id.empty?
      if /^[0-9]*$/.match(bundle_id)
        url += 'id='
      else
        url += 'bundleId='
      end

      url += bundle_id

      data = RestClient.get(url)
      raise 'app info nil' if !data

      body = data.body

      begin
        info = JSON.parse(body)
        if info["resultCount"] == 1
          info = info['results'][0]

          if info["kind"] == 'software'
            info_detail = {
              name: info["trackName"],
              app_id: info["bundleId"],
              desc: info["description"],
              link: info["trackViewUrl"],
              icon: info["artworkUrl512"],
              screens: info["screenshotUrls"],
              version: info["version"],
              track_id: info["trackId"],
              gener: info["genres"][0]
            }
            return info_detail
          else
            raise 'app info nil'
          end
        else
          raise 'app info nil'
        end
      rescue Exception => e
        raise e
      end
    end

    def fetch_android bundle_id
      return raise 'bundle_id is error' if !bundle_id || bundle_id.empty?
      url = ANDROID_BASE_URL+"#{bundle_id}?json"
      data = RestClient.get(url)
      return raise 'app info null'  if !data
      begin
        info = JSON.parse(data.body)
        puts 'info[:packageName]',info["packageName"]
        if info && info["packageName"]
          info_detail = {
            name: info["app"]["title"],
            app_id: info["packageName"],
            version: info["app"]["latestApk"]["versionName"],
            desc: info["app"]["description"].gsub("<br />","\n"),
            link: info["app"]["latestApk"]["downloadUrl"]["referUrl"],
            icon: info["app"]["icons"]["px256"] || info["app"]["icons"]["px100"],
            screens: info["app"]["screenshots"]["normal"],
            gener: info["app"]["categories"][0]["name"]
          }
          return info_detail
        else
          return raise 'app info null' 
        end
      rescue Exception => e
        raise e
      end

    end

  end
end
