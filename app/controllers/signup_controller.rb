class SignupController < ApplicationController
  before_action :validates_step1, only: :step2 # step1のバリデーション
  before_action :validates_step2, only: :step3 # step2のバリデーション
  before_action :validates_step4, only: :create_step5 # step4のバリデーション
  skip_before_action :authenticate_user!

  # コメントアウトしている箇所は、userテーブルに保存するカラム名を作成したら外していきます。無い状態だとエラーがでるため
  # ウィザードフォーム用コントローラー
  # 各アクションごとに新規インスタンスを作成します
  # 各アクションごとに、遷移元のページのデータをsessionに保管していきます

  def step1
    @user = User.new
  end

  def validates_step1
    session[:name] = user_params[:name]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:last_name] = user_params[:last_name]
    session[:first_name] = user_params[:first_name]
    session[:last_name_kana] = user_params[:last_name_kana]
    session[:first_name_kana] = user_params[:first_name_kana]

    # バリデーション用に、仮でインスタンスを作成する
    @user = User.new(
      name: session[:name], # sessionに保存された値をインスタンスに渡す
      email: session[:email],
      password: session[:password],
      last_name: session[:last_name], # 入力前の情報は、バリデーションに通る値を仮で入れる
      first_name: session[:first_name],
      last_name_kana: session[:last_name_kana],
      first_name_kana: session[:first_name_kana],
      tel_number: "00000000000"
    )
    # 仮で作成したインスタンスのバリデーションチェックを行う
    render '/signup/step1' unless @user.valid?
  end

  def step2
    session[:name] = user_params[:name]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:password_confirmation] = user_params[:password_confirmation]
    session[:last_name] = user_params[:last_name]
    session[:first_name] = user_params[:first_name]
    session[:last_name_kana] = user_params[:last_name_kana]
    session[:first_name_kana] = user_params[:first_name_kana]
    session[:birthday] = user_params[:birthday]
    @user = User.new
  end

  def validates_step2
    # step2で入力された値をsessionに保存
    session[:tel_number] = user_params[:tel_number]
    # バリデーション用に、仮でインスタンスを作成する
    @user = User.new(
      name: session[:name], # sessionに保存された値をインスタンスに渡す
      email: session[:email],
      password: session[:password],
      last_name: session[:last_name], # 入力前の情報は、バリデーションに通る値を仮で入れる
      first_name: session[:first_name],
      last_name_kana: session[:last_name_kana],
      first_name_kana: session[:first_name_kana],
      tel_number: session[:tel_number], # sessionに保存された値をインスタンスに渡す
      )
    # 仮で作成したインスタンスのバリデーションチェックを行う
    render '/signup/step2' unless @user.valid?
  end


  def step3
    # step2で入力された値をsessionに保存(step3のフォームの urlで指定したパス(=ここ) で、ページを読み込む際に行って欲しいアクション)
    session[:tel_number] = user_params[:tel_number]
    @user = User.new
  end

  def step4
    @delivery = Delivery.new
    @user = User.find(current_user.id)
  end


  def step5
  end

  def create
    @user = User.new(
      name: session[:name],
      email: session[:email],
      password: session[:password],
      birthday: @@birthday,
      tel_number: session[:tel_number],
      last_name: session[:last_name],
      first_name: session[:first_name],
      last_name_kana: session[:last_name_kana],
      first_name_kana: session[:first_name_kana])

    if @user.save
      # ログインするための情報を保管
      SnsCredential.update(user_id: @user.id)
      session.clear
      session[:id] = @user.id
      sign_in User.find(session[:id]) unless user_signed_in?

      @@user_id = current_user.id
      redirect_to step4_signup_index_path
    # else
    #   render 'signup' #ログインできなかった場合の遷移
    end
  end

  def jip
    @data = Jipcode.locate(params[:input])
  end

  def create_step4
    @user = User.find(current_user.id)
    @@user_id = current_user.id
    @delivery = Delivery.new(
    user_id: @@user_id,
    last_name: delivery_params[:last_name],
    first_name: delivery_params[:first_name],
    last_name_kana: delivery_params[:last_name_kana],
    first_name_kana: delivery_params[:first_name_kana],
    postal_code: delivery_params[:postal_code],
    area: delivery_params[:area],
    city: delivery_params[:city],
    address: delivery_params[:address],
    building: delivery_params[:building])
    if @delivery.save
      redirect_to step5_signup_index_path
    else
      flash[:postal_code_alert] = "郵便番号を入力して下さい"
      flash[:area_alert] = "都道府県を入力して下さい"
      flash[:city_alert] = "市町区村を入力して下さい"
      flash[:address_alert] = "番地を入力して下さい"
      render '/signup/step4' unless @delivery.valid?
    end
  end

  private

  def user_params
    if params[:user]["birthday(1i)"] != nil
      year = params[:user]["birthday(1i)"].to_s
      month = params[:user]["birthday(2i)"].to_s
      day = params[:user]["birthday(3i)"].to_s

      @@birthday = "#{year}/#{month}/#{day}"
    end

    params.require(:user).permit(
      :name,
      :email,
      :password,
      :birthday,
      :tel_number,
      :last_name,
      :first_name,
      :last_name_kana,
      :first_name_kana
  )
  end

  def delivery_params
    params.require(:delivery).permit(
      :last_name,
      :first_name,
      :last_name_kana,
      :first_name_kana,
      :postal_code,
      :area,
      :city,
      :address,
      :building
  )
  end

  def validates_step4
    @user = User.new(
    last_name: delivery_params[:last_name],
    first_name: delivery_params[:first_name],
    last_name_kana: delivery_params[:last_name_kana],
    first_name_kana: delivery_params[:first_name_kana],
    postal_code: delivery_params[:postal_code],
    area: delivery_params[:area],
    city: delivery_params[:city],
    address: delivery_params[:address],
    building: delivery_params[:building]
    )
    # 仮で作成したインスタンスのバリデーションチェックを行う
    render '/signup/step4' unless @user.valid?
  end 

end