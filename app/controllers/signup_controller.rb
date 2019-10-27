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
    # session.clear
    # binding.pry
    # step1で入力された値をsessionに保存
    session[:name] = user_params[:name]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    # session[:password_confirmation] = user_params[:password_confirmation]
    session[:last_name] = user_params[:last_name]
    session[:first_name] = user_params[:first_name]
    session[:last_name_kana] = user_params[:last_name_kana]
    session[:first_name_kana] = user_params[:first_name_kana]
    session[:birthday] = user_params[:birthday]
    @user = User.new # 新規インスタンス作成

  end

  def step3
    # step2で入力された値をsessionに保存(step3のフォームの urlで指定したパス(=ここ) で、ページを読み込む際に行って欲しいアクション)
    session[:tel_number] = user_params[:tel_number]
    @user = User.new # 新規インスタンス作成

  end

  def step4
    @delivery = Delivery.new # 新規インスタンス作成
    # if @user = User.user_id
    #   Delivery.update(user_id: @user.id)
    # end
  end


  def step5
    # step4で入力された値をsessionに保存
    # @user = User.new # 新規インスタンス作成
  end

  # 最後にcreate
  def create
    @user = User.new(
      name: session[:name], # sessionに保存された値をインスタンスに渡す
      email: session[:email],
      password: session[:password],
      birthday: session[:birthday],
      tel_number: session[:tel_number],
      last_name: session[:last_name],
      first_name: session[:first_name],
      last_name_kana: session[:last_name_kana],
      first_name_kana: session[:first_name_kana])
      # binding.pry
    if @user.save
      # ログインするための情報を保管
      SnsCredential.update(user_id: @user.id)
      # Delivery.update(user_id: @user.id)
      session.clear
      session[:id] = @user.id
      sign_in User.find(session[:id]) unless user_signed_in?

      @@user_id = current_user.id
      # binding.pry
      redirect_to step4_signup_index_path
    # else
    #   render '/signup/' #ログインできなかった場合の遷移
    end
  end

  def create_step4

# binding.pry
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

      # binding.pry

      if @delivery.save

        redirect_to step5_signup_index_path
      end

  end

  private

    def user_params
      # binding.pry
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
        # :profile
    )
    end

    def delivery_params
# binding.pry
      params.require(:delivery).permit(
        # :user_id,
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
end