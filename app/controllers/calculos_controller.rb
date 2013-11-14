class CalculosController < ApplicationController
  before_action :set_calculo, only: [:show, :edit, :update, :destroy]

  # GET /calculos
  # GET /calculos.json
  def index
    @calculos = Calculo.all
  end

  # GET /calculos/1
  # GET /calculos/1.json
  def show
  end

  # GET /calculos/new
  def new
    @calculo = Calculo.new
  end

  # GET /calculos/1/edit
  def edit
  end

  # POST /calculos
  # POST /calculos.json
  def create
    @calculo = Calculo.new(calculo_params)
   
    a = @calculo.diametro_cilindro
    b = @calculo.velocidad_cilindro
    diam_cil = [8.1, 12.16, 20, 25, 32, 40, 50, 63, 80, 100, 125, 140, 160]
    vel_cil = [50, 100, 150, 200, 250, 300, 400, 500, 750, 1000]
    total = {[8.1,50]=>0.1, [8.1,100]=>0.1, [8.1,150]=>0.15, [12.16,50]=>0.12}
    tubo = {1.48 => '4 x 2.5', 3.72 => '6 x 4', 6.73 => '8 x 5', 10.00 => '8 x 6', 12.70 => '10 x 6.5', 19.97 => '10 x 7.5', 20.92 => '12 x 8', 29.45 => '12 x 9'}

    i = 0
    while i <= diam_cil.size - 1
      if a >= diam_cil[i] && a < diam_cil[i+1]
        a = diam_cil[i]
      elsif a < diam_cil[0]
        a = diam_cil[0]
      end
      i += 1
    end
    i = 0
    while i <= vel_cil.size - 1
      if b >= vel_cil[i] && b < vel_cil[i+1]
        b = vel_cil[i]
      elsif b < vel_cil[0]
        b = vel_cil[0]
      end
      i += 1
    end
    c = total[[a,b]] 
    i = 0
    while i <= tubo.keys.size - 1
      if c >= tubo.keys[i] && c < tubo.keys[i+1]
        c = tubo.keys[i]
      elsif c < tubo.keys[0]
        c = tubo.keys[0]
      elsif c > tubo.keys[-1]
        c tubo.keys[-1]
      end
      i += 1
    end
    @calculo.diametro_tubo = tubo[c]

    respond_to do |format|
      if @calculo.save
        format.html { redirect_to @calculo, notice: 'Se realizo el calculo de tuberia correctamente.' }
        format.json { render action: 'show', status: :created, location: @calculo }
      else
        format.html { render action: 'new' }
        format.json { render json: @calculo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /calculos/1
  # PATCH/PUT /calculos/1.json
  def update
    @calculo.update(calculo_params)
    a = @calculo.diametro_cilindro
    b = @calculo.velocidad_cilindro
    @calculo.diametro_tubo = a + b
    diam_cil = [8.1, 12.16, 20, 25, 32, 40, 50, 63, 80, 100, 125, 140, 160]
    vel_cil = [50, 100, 150, 200, 250, 300, 400, 500, 750, 1000]
    total = {[8.1,50]=>0.1, [8.1,100]=>0.1, [8.1,150]=>0.15, [12.16,50]=>0.12}
    tubo = {1.48 => '4 x 2.5', 3.72 => '6 x 4', 6.73 => '8 x 5', 10.00 => '8 x 6', 12.70 => '10 x 6.5', 19.97 => '10 x 7.5', 20.92 => '12 x 8', 29.45 => '12 x 9'}

    i = 0
    while i <= diam_cil.size - 1
      if a >= diam_cil[i] && a < diam_cil[i+1]
        a = diam_cil[i]
      elsif a < diam_cil[0]
        a = diam_cil[0]
      end
      i += 1
    end
    i = 0
    while i <= vel_cil.size - 1
      if b >= vel_cil[i] && b < vel_cil[i+1]
        b = vel_cil[i]
      elsif b < vel_cil[0]
        b = vel_cil[0]
      end
      i += 1
    end
    c = total[[a,b]] 
    i = 0
    while i <= tubo.keys.size - 1
      if c >= tubo.keys[i] && c < tubo.keys[i+1]
        c = tubo.keys[i]
      elsif c < tubo.keys[0]
        c = tubo.keys[0]
      elsif c > tubo.keys[-1]
        c tubo.keys[-1]
      end
      i += 1
    end
    @calculo.diametro_tubo = tubo[c]
    respond_to do |format|
      if @calculo.save
        format.html { redirect_to @calculo, notice: 'Los datos han sido actualizados.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @calculo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calculos/1
  # DELETE /calculos/1.json
  def destroy
    @calculo.destroy
    respond_to do |format|
      format.html { redirect_to calculos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_calculo
      @calculo = Calculo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def calculo_params
      params.require(:calculo).permit(:perdida_persion, :diametro_cilindro, :velocidad_cilindro, :presion_trabajo, :diametro_tubo)
    end
end
