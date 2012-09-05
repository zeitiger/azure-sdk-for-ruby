#-------------------------------------------------------------------------
# Copyright 2012 Microsoft Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#--------------------------------------------------------------------------
require "integration/test_helper"
require "azure/core/auth/shared_key"

describe "Authorizing against the server" do
  let :uri do
    URI(Azure::Core.config.blob_host + "/?comp=list")
  end

  it "can make a simple request using SharedKey" do
    auth = Azure::Core::Auth::Authorizer.new
    signer = Azure::Core::Auth::Strategies::SharedKey.new

    request = Azure::Core::HttpRequest.new(:get, uri)
    auth.sign(request, signer)
    response = request.call

    response.status_code.must_equal 200
  end
end