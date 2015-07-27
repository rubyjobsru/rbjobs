# require 'rails_helper'
#
# # TODO: Refactor specs for VacanciesController
# RSpec.describe VacanciesController do
#   let(:attrs) { { :title => "Foo", :description => "Lorem ipsum" } }
#   let(:vacancy){ stub_model(Vacancy, attrs) }
#
#   describe "GET 'index'" do
#     before do
#       Vacancy.stub_chain(:available, :page, :per).and_return([vacancy])
#     end
#
#     it "should get only available vacancies" do
#       Vacancy.should_receive(:available)
#       get 'index'
#     end
#     it "should be successful" do
#       get 'index'
#       response.should be_success
#     end
#   end
#
#   describe "GET 'new'" do
#     before do
#       Vacancy.stub(:new => vacancy.as_new_record)
#     end
#
#     it "should create a new vacancy" do
#       Vacancy.should_receive(:new)
#       get 'new'
#     end
#     it "should be successful" do
#       get 'new'
#       response.should be_success
#     end
#   end
#
#   describe "POST 'create'" do
#     before do
#       Vacancy.stub(:new => vacancy)
#       VacancyMailer.stub_chain(:creation_notice, :deliver)
#     end
#
#     it "should create a new vacancy" do
#       Vacancy.should_receive(:new)
#       post 'create', :vacancy => attrs
#     end
#     it "should store vacancy's data to database" do
#       vacancy.should_receive(:save)
#       post 'create', :vacancy => attrs
#     end
#
#     context "when vacancy has been saved" do
#       before{ vacancy.stub(:save => true) }
#
#       it "should deliver email notification" do
#         VacancyMailer.should_receive(:creation_notice).with(vacancy)
#         post 'create', :vacancy => attrs
#       end
#       it "should set flash notification" do
#         post 'create', :vacancy => attrs
#         flash.should_not be_blank
#       end
#       it "should response with redirect to root page" do
#         post 'create', :vacancy => attrs
#         response.should redirect_to root_url
#       end
#     end
#     context "when vacancy hasn't been saved because of errors" do
#       before{ vacancy.stub(:save => false, :errors => { :error => "foo" }) }
#
#       it "should be successful" do
#         post 'create', :vacancy => attrs
#         response.should be_success
#       end
#       it "should render 'new' template" do
#         post 'create', :vacancy => attrs
#         response.should render_template('new')
#       end
#     end
#   end
#
#   describe "GET 'show'" do
#     before{ Vacancy.stub(:find_by_id! => vacancy) }
#
#     context "when vacancy has been approved" do
#       before{ vacancy.stub(:approved? => true) }
#
#       it "should be successful" do
#         get 'show', :id => vacancy
#         response.should be_success
#       end
#     end
#     context "when vacancy hasn't been approved" do
#       before{ vacancy.stub(:approved? => false, :owner_token => "owner", :admin_token => "admin") }
#
#       context "and visitor has owner token" do
#         it "should be not found" do
#           get 'show', :id => vacancy, :token => vacancy.owner_token
#           response.should be_not_found
#         end
#       end
#       context "and visitor has admin token" do
#         it "should be success" do
#           get 'show', :id => vacancy, :token => vacancy.admin_token
#           response.should be_success
#         end
#       end
#       context "and visitor doesn't have any token" do
#         it "should be not found" do
#           get 'show', :id => vacancy
#           response.should be_not_found
#         end
#       end
#     end
#   end
#
#   describe "GET 'edit'" do
#     before do
#       vacancy.stub(:owner_token => "owner", :admin_token => "admin")
#       Vacancy.stub(:find_by_id! => vacancy)
#     end
#
#     context "when vacancy has been approved" do
#       before{ vacancy.stub(:approved? => true) }
#
#       context "and visitor has owner token" do
#         it "should be successful" do
#           get 'edit', :id => vacancy, :token => vacancy.owner_token
#           response.should be_success
#         end
#       end
#       context "and visitor has admin token" do
#         it "should be successful" do
#           get 'edit', :id => vacancy, :token => vacancy.admin_token
#           response.should be_success
#         end
#       end
#       context "and visitor doesn't have any token" do
#         it "should be not found" do
#           get 'edit', :id => vacancy
#           response.should be_not_found
#         end
#       end
#     end
#     context "when vacancy has not been approved" do
#       before{ vacancy.stub(:approved? => false) }
#
#       context "and visitor has owner token" do
#         it "should be not found" do
#           get 'edit', :id => vacancy, :token => vacancy.owner_token
#           response.should be_not_found
#         end
#       end
#       context "and visitor has admin token" do
#         it "should be success" do
#           get 'edit', :id => vacancy, :token => vacancy.admin_token
#           response.should be_success
#         end
#       end
#       context "and visitor doesn't have any token" do
#         it "should be not found" do
#           get 'edit', :id => vacancy
#           response.should be_not_found
#         end
#       end
#     end
#   end
#
#   describe "PUT 'update'" do
#     before do
#       vacancy.stub(:owner_token => "owner", :admin_token => "admin")
#       Vacancy.stub(:find_by_id! => vacancy)
#     end
#
#     context "when vacancy has been approved" do
#       before{ vacancy.stub(:approved? => true) }
#
#       context "and visitor has owner token" do
#         context "and vacancy is valid" do
#           before{ vacancy.stub(:valid? => true) }
#
#           it "should update vacancy" do
#             vacancy.should_receive(:update_attributes)
#             put 'update', :id => vacancy, :token => vacancy.owner_token, :vacancy => attrs
#           end
#           it "should redirect to vacancy's page" do
#             put 'update', :id => vacancy, :token => vacancy.owner_token, :vacancy => attrs
#             response.should redirect_to vacancy_url(vacancy)
#           end
#           it "should set flash notification" do
#             put 'update', :id => vacancy, :token => vacancy.owner_token, :vacancy => attrs
#             flash.should_not be_blank
#           end
#         end
#         context "and vacancy is not valid" do
#           before{ vacancy.stub(:valid? => false, :errors => { :foo => "bar" }) }
#
#           it "should be successful" do
#             put 'update', :id => vacancy, :token => vacancy.owner_token, :vacancy => attrs
#             response.should be_success
#           end
#           it "should render edit page" do
#             put 'update', :id => vacancy, :token => vacancy.owner_token, :vacancy => attrs
#             response.should render_template(:edit)
#           end
#         end
#       end
#       context "and visitor has admin token" do
#         context "and vacancy is valid" do
#           before{ vacancy.stub(:valid? => true) }
#
#           it "should update vacancy" do
#             vacancy.should_receive(:update_attributes)
#             put 'update', :id => vacancy, :token => vacancy.admin_token, :vacancy => attrs
#           end
#           it "should redirect to vacancy's page" do
#             put 'update', :id => vacancy, :token => vacancy.admin_token, :vacancy => attrs
#             response.should redirect_to vacancy_url(vacancy)
#           end
#           it "should set flash notification" do
#             put 'update', :id => vacancy, :token => vacancy.admin_token, :vacancy => attrs
#             flash.should_not be_blank
#           end
#         end
#         context "and vacancy is not valid" do
#           before{ vacancy.stub(:valid? => false, :errors => { :foo => "bar" }) }
#
#           it "should be successful" do
#             put 'update', :id => vacancy, :token => vacancy.admin_token, :vacancy => attrs
#             response.should be_success
#           end
#           it "should render edit page" do
#             put 'update', :id => vacancy, :token => vacancy.admin_token, :vacancy => attrs
#             response.should render_template(:edit)
#           end
#         end
#       end
#       context "and visitor doesn't have any token" do
#         it "should be not found" do
#           put 'update', :id => vacancy, :vacancy => attrs
#           response.should be_not_found
#         end
#       end
#     end
#     context "when vacancy has not been approved" do
#       before{ vacancy.stub(:approved? => false) }
#
#       context "and visitor has owner token" do
#         it "should be not found" do
#           put 'update', :id => vacancy, :token => vacancy.owner_token, :vacancy => attrs
#           response.should be_not_found
#         end
#       end
#       context "and visitor has admin token" do
#         context "and vacancy is valid" do
#           before{ vacancy.stub(:valid? => true) }
#
#           it "should update vacancy" do
#             vacancy.should_receive(:update_attributes)
#             put 'update', :id => vacancy, :token => vacancy.admin_token, :vacancy => attrs
#           end
#           it "should redirect to vacancy's page" do
#             put 'update', :id => vacancy, :token => vacancy.admin_token, :vacancy => attrs
#             response.should redirect_to vacancy_url(vacancy)
#           end
#           it "should set flash notification" do
#             put 'update', :id => vacancy, :token => vacancy.admin_token, :vacancy => attrs
#             flash.should_not be_blank
#           end
#         end
#         context "and vacancy is not valid" do
#           before{ vacancy.stub(:valid? => false, :errors => { :foo => "bar" }) }
#
#           it "should be successful" do
#             put 'update', :id => vacancy, :token => vacancy.admin_token, :vacancy => attrs
#             response.should be_success
#           end
#           it "should render edit page" do
#             put 'update', :id => vacancy, :token => vacancy.admin_token, :vacancy => attrs
#             response.should render_template(:edit)
#           end
#         end
#       end
#       context "and visitor doesn't have any token" do
#         it "should be not found" do
#           put 'update', :id => vacancy, :vacancy => attrs
#           response.should be_not_found
#         end
#       end
#     end
#   end
#
#   describe "DELETE 'destroy'" do
#     before do
#       vacancy.stub(:owner_token => "owner", :admin_token => "admin")
#       Vacancy.stub(:find_by_id! => vacancy)
#     end
#
#     context "when vacancy has been approved" do
#       before{ vacancy.stub(:approved? => true) }
#
#       context "and visitor has owner token" do
#         it "should be not found" do
#           delete 'destroy', :id => vacancy, :token => vacancy.owner_token
#           response.should be_not_found
#         end
#       end
#       context "and visitor has admin token" do
#         before { vacancy.stub(:destroy => true) }
#
#         it "should destroy vacancy" do
#           vacancy.should_receive(:destroy)
#           delete 'destroy', :id => vacancy, :token => vacancy.admin_token
#         end
#         it "should redirect to vacancies page" do
#           delete 'destroy', :id => vacancy, :token => vacancy.admin_token
#           response.should redirect_to root_url
#         end
#         it "should set flash notification" do
#           delete 'destroy', :id => vacancy, :token => vacancy.admin_token
#           flash.should_not be_blank
#         end
#       end
#       context "and visitor doesn't have any token" do
#         it "should be not found" do
#           delete 'destroy', :id => vacancy
#           response.should be_not_found
#         end
#       end
#     end
#     context "when vacancy has not been approved" do
#       before{ vacancy.stub(:approved? => false) }
#
#       context "and visitor has owner token" do
#         it "should be not found" do
#           delete 'destroy', :id => vacancy, :token => vacancy.owner_token
#           response.should be_not_found
#         end
#       end
#       context "and visitor has admin token" do
#         before { vacancy.stub(:destroy => true) }
#
#         it "should destroy vacancy" do
#           vacancy.should_receive(:destroy)
#           delete 'destroy', :id => vacancy, :token => vacancy.admin_token
#         end
#         it "should redirect to vacancies page" do
#           delete 'destroy', :id => vacancy, :token => vacancy.admin_token
#           response.should redirect_to root_url
#         end
#         it "should set flash notification" do
#           delete 'destroy', :id => vacancy, :token => vacancy.admin_token
#           flash.should_not be_blank
#         end
#       end
#       context "and visitor doesn't have any token" do
#         it "should be not found" do
#           delete 'destroy', :id => vacancy
#           response.should be_not_found
#         end
#       end
#     end
#   end
#
#   describe "PUT 'approve'" do
#     before do
#       vacancy.stub(:owner_token => "owner", :admin_token => "admin")
#       Vacancy.stub(:find_by_id! => vacancy)
#     end
#
#     context "when visitor has owner token" do
#       it "should be not found" do
#         put 'approve', :id => vacancy, :token => vacancy.owner_token
#         response.should be_not_found
#       end
#     end
#     context "when visitor has admin token" do
#       before do
#         vacancy.stub(:approve! => true)
#         VacancyMailer.stub_chain(:approval_notice, :deliver)
#       end
#
#       it "should approve vacancy" do
#         vacancy.should_receive(:approve!)
#         put 'approve', :id => vacancy, :token => vacancy.admin_token
#       end
#       it "should deliver email notification" do
#         VacancyMailer.should_receive(:approval_notice).with(vacancy)
#         put 'approve', :id => vacancy, :token => vacancy.admin_token
#       end
#       it "should redirect to vacancy's page" do
#         put 'approve', :id => vacancy, :token => vacancy.admin_token
#         response.should redirect_to vacancy_url(vacancy)
#       end
#       it "should set flash notification" do
#         put 'approve', :id => vacancy, :token => vacancy.admin_token
#         flash.should_not be_blank
#       end
#     end
#     context "and visitor doesn't have any token" do
#       it "should be not found" do
#         put 'approve', :id => vacancy
#         response.should be_not_found
#       end
#     end
#   end
# end
