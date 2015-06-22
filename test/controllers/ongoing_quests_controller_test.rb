require 'test_helper'

class OngoingQuestsControllerTest < ActionController::TestCase
  setup do
    @ongoing_quest = ongoing_quests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ongoing_quests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ongoing_quest" do
    assert_difference('OngoingQuest.count') do
      post :create, ongoing_quest: { quest_id: @ongoing_quest.quest_id, user_id: @ongoing_quest.user_id }
    end

    assert_redirected_to ongoing_quest_path(assigns(:ongoing_quest))
  end

  test "should show ongoing_quest" do
    get :show, id: @ongoing_quest
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ongoing_quest
    assert_response :success
  end

  test "should update ongoing_quest" do
    patch :update, id: @ongoing_quest, ongoing_quest: { quest_id: @ongoing_quest.quest_id, user_id: @ongoing_quest.user_id }
    assert_redirected_to ongoing_quest_path(assigns(:ongoing_quest))
  end

  test "should destroy ongoing_quest" do
    assert_difference('OngoingQuest.count', -1) do
      delete :destroy, id: @ongoing_quest
    end

    assert_redirected_to ongoing_quests_path
  end
end
