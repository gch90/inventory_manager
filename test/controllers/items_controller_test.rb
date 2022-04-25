require 'test_helper'

class ItemsControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get '/items/new'
    assert_response :success
  end

  test 'should get create' do
    post 'items/create'
    assert_response :success
  end

  test 'should get index' do
    get '/items'
    assert_response :success
  end

  test 'should get edit' do
    get 'items/:id/edit'
    assert_response :success
  end

  test 'should get show' do
    get :show
    assert_response :success
  end

  test 'should get destroy' do
    get :destroy
    assert_response :success
  end

  test 'should get update' do
    get :update
    assert_response :success
  end
end
