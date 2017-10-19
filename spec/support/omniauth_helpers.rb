module OmniauthMacros
  def mock_auth_hash_google
    # The mock_auth configuration allows you to set per-provider (or default)
    # authentication hashes to return during integration testing.
    OmniAuth.config.mock_auth[:google_oauth2] = 
			{"provider"=>"google_oauth2",
			 "uid"=>"115821578552534939600",
			 "info"=>
			  {"name"=>"Samuel Snider",
			   "email"=>"samuelsnider.s@gmail.com",
			   "first_name"=>"Samuel",
			   "last_name"=>"Snider",
			   "image"=>"https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg",
			   "urls"=>{"Google"=>"https://plus.google.com/115821578552534939600"}},
			 "credentials"=>
			  {"token"=>"ya29.GlznBK9tz0vKxye6x8RCu90dJPQtixhUKELtwLume4Zpo7sy7pvyLZd5BFGiqLve2SQPnu2inGkaLt_XMBFoSjvAq9EhEPt0O6XLYIITuma6srZAPnkEm9IorXcF_w",
			   "expires_at"=>1508286523,
			   "expires"=>true},
			 }
  end
	def mock_auth_hash_twitter
		OmniAuth.config.mock_auth[:twitter] =
		{"provider"=>"twitter",
		 "uid"=>"825463277643763712",
		 "info"=>
		  {"nickname"=>"leumasredins",
		   "name"=>"Samuel Snider",
		   "email"=>nil,
		   "image"=>"http://pbs.twimg.com/profile_images/917449851427741697/HY62Dgp__normal.jpg",
		   "description"=>"",
		   "urls"=>
			 	{"Website"=>nil, "Twitter"=>"https://twitter.com/leumasredins"}
			},
		 	"credentials"=>{"token"=>"825463277643763712-Ed4aIIUnO8L5qVYalperBCC7CePYMo8", "secret"=>"JRPT7A7OqETRRUv9EeMmfN3gFqgDAwZJGTTMXW68s5Cor"}
		}
	end
  def mock_auth_hash_facebook
		OmniAuth.config.mock_auth[:facebook]
  end
end