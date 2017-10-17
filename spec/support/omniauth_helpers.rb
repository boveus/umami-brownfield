module OmniauthMacros
  def mock_auth_hash
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
			 "extra"=>
			  {"id_token"=>
			    "eyJhbGciOiJSUzI1NiIsImtpZCI6IjRlZWM5NjBhNmQ1MGE3NGY3OTEzNDZjMmJjN2M3NDZkMjdiZTk2YWYifQ.eyJhenAiOiI3NzUxNzA4Mzg3NC1tZm5zbHRmZWRpNG9naGRmcWp1cmY4ZjVpbnNjaDJsMi5hcHBzLmdvb2dsZXVzZXJjb250ZW50LmNvbSIsImF1ZCI6Ijc3NTE3MDgzODc0LW1mbnNsdGZlZGk0b2doZGZxanVyZjhmNWluc2NoMmwyLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwic3ViIjoiMTE1ODIxNTc4NTUyNTM0OTM5NjAwIiwiZW1haWwiOiJzYW11ZWxzbmlkZXIuc0BnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiYXRfaGFzaCI6IlhHMFR4dHlDaERpZTdfTzF2aFo1WFEiLCJpc3MiOiJhY2NvdW50cy5nb29nbGUuY29tIiwiaWF0IjoxNTA4MjgyOTIzLCJleHAiOjE1MDgyODY1MjN9.Jq81ruNegSnR8rbJ6K680LagzBKsY2FC25IUwjhu-heJqi4m6BN1M7ncfIjvvQY9aw_dilwintegbkqCMvxd4izCQQZ9J-aR4enqf1YRcaXIsLv3tzpPzOmELbhm65QJddsJL2UXgb3kfhXf1AFmVBMoFmWTWtlAAqpzYtmvpi7dz96ghxZe7F9jqEOH_I95-Kf_OeT_i4VER00lqCjw6taSwsptdR6GbA132zKVpaMMELqpgOmVYFUaIbSfa8OhddVtZhFZhqqO-9mNB-6D_TF_f9WKkWVq8wuhQiZUV9hHRYqdKPAbCCJQgAMNEZdQX_YUO48ve7ufrz2N2b6dDg",
			 "id_info"=>
			    {"azp"=>"77517083874-mfnsltfedi4oghdfqjurf8f5insch2l2.apps.googleusercontent.com",
			     "aud"=>"77517083874-mfnsltfedi4oghdfqjurf8f5insch2l2.apps.googleusercontent.com",
			     "sub"=>"115821578552534939600",
			     "email"=>"samuelsnider.s@gmail.com",
			     "email_verified"=>true,
			     "at_hash"=>"XG0TxtyChDie7_O1vhZ5XQ",
			     "iss"=>"accounts.google.com",
			     "iat"=>1508282923,
			     "exp"=>1508286523},
   		 "raw_info"=>
		    {"kind"=>"plus#personOpenIdConnect",
		     "gender"=>"male",
		     "sub"=>"115821578552534939600",
		     "name"=>"Samuel Snider",
		     "given_name"=>"Samuel",
		     "family_name"=>"Snider",
		     "profile"=>"https://plus.google.com/115821578552534939600",
		     "picture"=>"https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg?sz=50",
		     "email"=>"samuelsnider.s@gmail.com",
		     "email_verified"=>"true",
		     "locale"=>"en"}}}
  end
end