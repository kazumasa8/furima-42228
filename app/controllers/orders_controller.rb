class OrdersController < ApplicationController
  before_action :authenticate_user! # ← ③ ログアウト状態ならログインページへ
  before_action :set_item           # @item を準備（index / create 両方で使う）
  before_action :redirect_if_invalid_user # ← ①②に対応するチェック！


  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @order_form = OrderForm.new
  end

 def create

    @order_form = OrderForm.new(order_params)

  if @order_form.valid?
    pay_item
   

    @order_form.save
    redirect_to root_path  # 購入完了後、トップページへリダイレクト
  else
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    render :index,status: :unprocessable_entity # 保存に失敗した場合は購入ページを再表示
    
  end
 end

 private

def order_params
  params.require(:order_form).permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number, :price).merge(token: params[:token], user_id: current_user.id, item_id: params[:item_id])
end

def pay_item
  Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
Payjp.api_key = "sk_test_4dfc6b239b763c04259c87d1"  # 自身のPAY.JPテスト秘密鍵を記述しましょう
Payjp::Charge.create(
  amount: @item.price,  # 商品の値段
  card: order_params[:token],    # カードトークン
  currency: 'jpy'                 # 通貨の種類（日本円）
)
end

def set_item
  @item = Item.find(params[:item_id])
end

# 🚫①② 購入できない条件のときはトップページへ
def redirect_if_invalid_user
  # 売り切れてる or 自分の商品なら → トップページに戻す
  if @item.order.present? || @item.user == current_user
    redirect_to root_path
end
end
end