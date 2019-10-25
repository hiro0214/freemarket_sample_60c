class SignupController < ApplicationController

  skip_before_action :authenticate_user!

  # コメントアウトしている箇所は、userテーブルに保存するカラム名を作成したら外していきます。無い状態だとエラーがでるため
  # ウィザードフォーム用コントローラー
  # 各アクションごとに新規インスタンスを作成します
  # 各アクションごとに、遷移元のページのデータをsessionに保管していきます

  def step1
    @user = User.new # 新規インスタンス作成
  end

  def step2
    # step1で入力された値をsessionに保存
    session[:name] = user_params[:name]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:password_confirmation] = user_params[:password_confirmation]
    # session[:last_name] = user_params[:last_name]
    # session[:first_name] = user_params[:first_name]
    # session[:last_name_kana] = user_params[:last_name_kana]
    # session[:first_name_kana] = user_params[:first_name_kana]
    @user = User.new # 新規インスタン作成
  end


  def step3
    # step2で入力された値をsessionに保存
    @user = User.new # 新規インスタンス作成
  end

  def step4
    # step2で入力された値をsessionに保存
    # session[:birthday] = user_params[:birthday]
    @user = User.new # 新規インスタンス作成
  end


  def step5
    # step2で入力された値をsessionに保存

    # session[:birthday] = user_params[:birthday]
    @user = User.new # 新規インスタンス作成
  end

  # 最後にcreate
  def create
    @user = User.new(
      name: session[:name], # sessionに保存された値をインスタンスに渡す
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      # last_name: session[:last_name],
      # first_name: session[:first_name],
      # last_name_kana: session[:last_name_kana],
      # first_name_kana: session[:first_name_kana],
    )
    if @user.save
      # ログインするための情報を保管
      session[:id] = @user.id
      sign_in User.find(session[:id]) unless user_signed_in?
      SnsCredential.update(user_id: @user.id)
      redirect_to step4_signup_index_path
    # else
    #   render '/signup/' #ログインできなかった場合の遷移
    end
  end

  def create_step4
  end





  private
    def user_params
      params.require(:user).permit(
        :name,
        :email,
        :password,
        :password_confirmation,
        # :last_name,
        # :first_name,
        # :last_name_kana,
        # :first_name_kana,
        # :gender
        # :birthday
        # :tel_number
        # :profile
        # :avatar
    )
    end
end