class AuthenticationsController < ApplicationController
  def fb_tab
    app_id = "477773122285636"
    app_id_secret = "cf1c67c394a576cba3d01a7911372017"
    @oauth = Koala::Facebook::OAuth.new(app_id, app_id_secret)
    @signed = params[:signed_request]
    @fb_request = @oauth.parse_signed_request(@signed)
    @oauth_access_token = @fb_request["oauth_token"]
    @graph = Koala::Facebook::API.new(@oauth_access_token)
    @profile = @graph.get_object("me")
    @user = User.find_for_facebook_koala(@profile)
    sign_in(@user)
  end
end
