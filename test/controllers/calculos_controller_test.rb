require 'test_helper'

class CalculosControllerTest < ActionController::TestCase
  setup do
    @calculo = calculos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:calculos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create calculo" do
    assert_difference('Calculo.count') do
      post :create, calculo: { diametro_cilindro: @calculo.diametro_cilindro, diametro_tubo: @calculo.diametro_tubo, perdida_persion: @calculo.perdida_persion, presion_trabajo: @calculo.presion_trabajo, velocidad_cilindro: @calculo.velocidad_cilindro }
    end

    assert_redirected_to calculo_path(assigns(:calculo))
  end

  test "should show calculo" do
    get :show, id: @calculo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @calculo
    assert_response :success
  end

  test "should update calculo" do
    patch :update, id: @calculo, calculo: { diametro_cilindro: @calculo.diametro_cilindro, diametro_tubo: @calculo.diametro_tubo, perdida_persion: @calculo.perdida_persion, presion_trabajo: @calculo.presion_trabajo, velocidad_cilindro: @calculo.velocidad_cilindro }
    assert_redirected_to calculo_path(assigns(:calculo))
  end

  test "should destroy calculo" do
    assert_difference('Calculo.count', -1) do
      delete :destroy, id: @calculo
    end

    assert_redirected_to calculos_path
  end
end
