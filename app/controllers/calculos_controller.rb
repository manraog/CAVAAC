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
    # Se alamacena el calculo en una variable global
    @calculo = Calculo.new(calculo_params)
    # Variables auxiliares en el calculo del tubo
    a = @calculo.diametro_cilindro
    b = @calculo.velocidad_cilindro
    diam_cil = [8.1, 12.16, 20, 25, 32, 40, 50, 63, 80, 100, 125, 140, 160]
    vel_cil = [50, 100, 150, 200, 250, 300, 400, 500, 750, 1000]
    # Hash con los valores de la primer tabla
    total = {[8.1,50]=>0.1, [8.1,100]=>0.1, [8.1,150]=>0.15, [8.1,200]=>0.2, [8.1,250]=>0.25, [8.1,300]=>0.3, [8.1,400]=>0.4, [8.1,500]=>0.5, [8.1,750]=>0.75, [8.1,1000]=>1, 
    [12.16,50]=>0.12, [12.16,100]=>0.23, [12.16,150]=>0.36, [12.16,200]=>0.46, [12.16,250]=>0.6, [12.16,300]=>0.72,  [12.16,400]=>1, [12.16,500]=>1.2, [12.16,750]=>1.8, [12.16,1000]=>2.4, 
    [20,50]=>0.2, [20,100]=>0.4, [20,150]=>0.6, [20,200]=>0.8, [20,250]=>1, [20,300]=>1.2, [20,400]=>1.6, [20,500]=>2, [20,750]=>3, [20,1000]=>4, 
    [25,50]=>0.35, [25,100]=>0.67, [25,150]=>1, [25,200]=>1.3, [25,250]=>1.7, [25,300]=>2, [25,400]=>2.7, [25,500]=>3.4, [25,750]=>5, [25,1000]=>6.7, 
    [32,50]=>0.55, [32,100]=>1.1, [32,150]=>1.7, [32,200]=>2.2, [32,250]=>2.8, [32,300]=>3.7, [32,400]=>4.4, [32,500]=>5.5, [32,750]=>8.5, [32,1000]=>11, 
    [40,50]=>0.85, [40,100]=>1.7, [40,150]=>2.6, [40,200]=>3.4, [40,250]=>4.3, [40,300]=>5, [40,400]=>6.8, [40,500]=>8.5, [40,750]=>12.8, [40,1000]=>17, 
    [50,50]=>1.4, [50,100]=>2.7, [50,150]=>4, [50,200]=>5.4, [50,250]=>6.8, [50,300]=>8.1, [50,400]=>10.8, [50,500]=>13.5, [50,750]=>20.3, [50,1000]=>27, 
    [63,50]=>2.1, [63,100]=>4.2, [63,150]=>6.3, [63,200]=>8.4, [63,250]=>10.5, [63,300]=>12.6, [63,400]=>16.8, [63,500]=>21, [63,750]=>31.5, [63,1000]=>42, 
    [80,50]=>3.4, [80,100]=>6.8, [80,150]=>10.2, [80,200]=>13.6, [80,250]=>17, [80,300]=>20.4, [80,400]=>27.2, [80,500]=>34, [80,750]=>51, [80,1000]=>68, 
    [100,50]=>5.4, [100,100]=>10.8, [100,150]=>16.2, [100,200]=>21.6, [100,250]=>27, [100,300]=>32.4, [100,400]=>43.2, [100,500]=>54, [100,750]=>81, [100,1000]=>108, 
    [125,50]=>8.4, [125,100]=>16.8, [125,150]=>25.2, [125,200]=>33.6, [125,250]=>42, [125,300]=>50.4, [125,400]=>67.2, [125,500]=>84, [125,750]=>126, [125,1000]=>168, 
    [140,50]=>10.6, [140,100]=>21.1, [140,150]=>31.7, [140,200]=>42.2, [140,250]=>52.8, [140,300]=>62, [140,400]=>84.4, [140,500]=>106, [140,750]=>158, [140,1000]=>211, 
    [160,50]=>13.8, [160,100]=>27.6, [160,150]=>41.4, [160,200]=>55.2, [160,250]=>69, [160,300]=>82.8, [160,400]=>110, [160,500]=>138, [160,750]=>207, [160,1000]=>276}
    # Hash con sus respectivos valores para el tubo
    tubo = {1.48 => '4 x 2.5', 3.72 => '6 x 4', 6.73 => '8 x 5', 10.00 => '8 x 6', 12.70 => '10 x 6.5', 19.97 => '10 x 7.5', 20.92 => '12 x 8', 29.45 => '12 x 9'}

    respond_to do |format|
      if @calculo.save
        # Adaptar a valoreas admitibles
        i = 0
        while i <= diam_cil.size - 1
          if a > diam_cil[-1]
            a = diam_cil[-1]
            break
          elsif a < diam_cil[0]
            a = diam_cil[0]
            break
          elsif a >= diam_cil[i] && a < diam_cil[i+1]
            a = diam_cil[i]
          end
          i += 1
        end

        i = 0
        while i <= vel_cil.size - 1
          if b > vel_cil[-1]
            b = vel_cil[-1]
            break
          elsif b < vel_cil[0]
            b = vel_cil[0]
            break
          elsif b >= vel_cil[i] && b < vel_cil[i+1]
            b = vel_cil[i]
          end
          i += 1
        end
        
        # Usando los valores se encuentra el diametro del tubo
        c = total[[a,b]] 
        i = 0
        while i <= tubo.keys.size - 1
          if c < tubo.keys[0]
            c = tubo.keys[0]
            break
          elsif c > tubo.keys[-1]
            c = tubo.keys[-1]
            break
          elsif c >= tubo.keys[i] && c < tubo.keys[i+1]
            c = tubo.keys[i]
          end
          i += 1
        end
        @calculo.diametro_tubo = tubo[c]
        @calculo.save

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
    # Se actualiza el calculo con los valores del formulario
    @calculo.update(calculo_params)
    # Variables auxiliares en el calculo del tubo
    a = @calculo.diametro_cilindro
    b = @calculo.velocidad_cilindro
    diam_cil = [8.1, 12.16, 20, 25, 32, 40, 50, 63, 80, 100, 125, 140, 160]
    vel_cil = [50, 100, 150, 200, 250, 300, 400, 500, 750, 1000]
    # Hash con los valores de la primer tabla
    total = {[8.1,50]=>0.1, [8.1,100]=>0.1, [8.1,150]=>0.15, [8.1,200]=>0.2, [8.1,250]=>0.25, [8.1,300]=>0.3, [8.1,400]=>0.4, [8.1,500]=>0.5, [8.1,750]=>0.75, [8.1,1000]=>1, 
    [12.16,50]=>0.12, [12.16,100]=>0.23, [12.16,150]=>0.36, [12.16,200]=>0.46, [12.16,250]=>0.6, [12.16,300]=>0.72,  [12.16,400]=>1, [12.16,500]=>1.2, [12.16,750]=>1.8, [12.16,1000]=>2.4, 
    [20,50]=>0.2, [20,100]=>0.4, [20,150]=>0.6, [20,200]=>0.8, [20,250]=>1, [20,300]=>1.2, [20,400]=>1.6, [20,500]=>2, [20,750]=>3, [20,1000]=>4, 
    [25,50]=>0.35, [25,100]=>0.67, [25,150]=>1, [25,200]=>1.3, [25,250]=>1.7, [25,300]=>2, [25,400]=>2.7, [25,500]=>3.4, [25,750]=>5, [25,1000]=>6.7, 
    [32,50]=>0.55, [32,100]=>1.1, [32,150]=>1.7, [32,200]=>2.2, [32,250]=>2.8, [32,300]=>3.7, [32,400]=>4.4, [32,500]=>5.5, [32,750]=>8.5, [32,1000]=>11, 
    [40,50]=>0.85, [40,100]=>1.7, [40,150]=>2.6, [40,200]=>3.4, [40,250]=>4.3, [40,300]=>5, [40,400]=>6.8, [40,500]=>8.5, [40,750]=>12.8, [40,1000]=>17, 
    [50,50]=>1.4, [50,100]=>2.7, [50,150]=>4, [50,200]=>5.4, [50,250]=>6.8, [50,300]=>8.1, [50,400]=>10.8, [50,500]=>13.5, [50,750]=>20.3, [50,1000]=>27, 
    [63,50]=>2.1, [63,100]=>4.2, [63,150]=>6.3, [63,200]=>8.4, [63,250]=>10.5, [63,300]=>12.6, [63,400]=>16.8, [63,500]=>21, [63,750]=>31.5, [63,1000]=>42, 
    [80,50]=>3.4, [80,100]=>6.8, [80,150]=>10.2, [80,200]=>13.6, [80,250]=>17, [80,300]=>20.4, [80,400]=>27.2, [80,500]=>34, [80,750]=>51, [80,1000]=>68, 
    [100,50]=>5.4, [100,100]=>10.8, [100,150]=>16.2, [100,200]=>21.6, [100,250]=>27, [100,300]=>32.4, [100,400]=>43.2, [100,500]=>54, [100,750]=>81, [100,1000]=>108, 
    [125,50]=>8.4, [125,100]=>16.8, [125,150]=>25.2, [125,200]=>33.6, [125,250]=>42, [125,300]=>50.4, [125,400]=>67.2, [125,500]=>84, [125,750]=>126, [125,1000]=>168, 
    [140,50]=>10.6, [140,100]=>21.1, [140,150]=>31.7, [140,200]=>42.2, [140,250]=>52.8, [140,300]=>62, [140,400]=>84.4, [140,500]=>106, [140,750]=>158, [140,1000]=>211, 
    [160,50]=>13.8, [160,100]=>27.6, [160,150]=>41.4, [160,200]=>55.2, [160,250]=>69, [160,300]=>82.8, [160,400]=>110, [160,500]=>138, [160,750]=>207, [160,1000]=>276}
    # Hash con sus respectivos valores para el tubo
    tubo = {1.48 => '4 x 2.5', 3.72 => '6 x 4', 6.73 => '8 x 5', 10.00 => '8 x 6', 12.70 => '10 x 6.5', 19.97 => '10 x 7.5', 20.92 => '12 x 8', 29.45 => '12 x 9'}
    
    respond_to do |format|
      if @calculo.save
        # Adaptar a valoreas admitibles
        i = 0
        while i <= diam_cil.size - 1
          if a > diam_cil[-1]
            a = diam_cil[-1]
            break
          elsif a < diam_cil[0]
            a = diam_cil[0]
            break
          elsif a >= diam_cil[i] && a < diam_cil[i+1]
            a = diam_cil[i]
          end
          i += 1
        end

        i = 0
        while i <= vel_cil.size - 1
          if b > vel_cil[-1]
            b = vel_cil[-1]
            break
          elsif b < vel_cil[0]
            b = vel_cil[0]
            break
          elsif b >= vel_cil[i] && b < vel_cil[i+1]
            b = vel_cil[i]
          end
          i += 1
        end
        
        # Usando los valores se encuentra el diametro del tubo
        c = total[[a,b]] 
        i = 0
        while i <= tubo.keys.size - 1
          if c < tubo.keys[0]
            c = tubo.keys[0]
            break
          elsif c > tubo.keys[-1]
            c = tubo.keys[-1]
            break
          elsif c >= tubo.keys[i] && c < tubo.keys[i+1]
            c = tubo.keys[i]
          end
          i += 1
        end

        @calculo.diametro_tubo = tubo[c]
        @calculo.save
        
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
