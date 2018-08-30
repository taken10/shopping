<%@ page import="java.util.ArrayList"%>
<%@ page import="shopping.ItemBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<%-- Java入門 商品一覧画面 --%>
<!DOCTYPE html>
<html>
	<head>
		<title>Java入門</title>
		<link href="/shop/contents/css/shopping.css" rel="stylesheet" type="text/css" />
	</head>
	<body>
		<jsp:include page="header.jsp"/>
		<h1>商品一覧</h1>
		<form action="./CategoryServlet">
			<div align="right">
				<select name= category>
					<option value=全て>全て</option>
					<option value=食品>食品</option>
					<option value=文房具>文房具</option>
					<option value=おもちゃ>おもちゃ</option>
				</select>
				<input class="common_button" type="submit" value="選択" name="選択">
			</div><br>
			</form>

		<%-- リクエストスコープからBeanクラスの配列を取得（eclipseの警告が出ても今回は大丈夫です） --%>
		<% ArrayList<ItemBean> itemList = (ArrayList<ItemBean>)request.getAttribute("itemList"); %>
		<form action="./BuyItemServlet_ans">
			<table class="table_list">
				<tbody>
					<tr>
						<th>商品ID</th>
						<th>商品名</th>
						<th>価格</th>
						<th>在庫数</th>
						<th>数量</th>
						<th></th>
						<th>評価</th>
					</tr>

					<%-- Beanの要素数分（商品の種類分）テーブルを作成 --%>

					<% for(ItemBean bean : itemList) { %>
					<tr>
						<%-- 商品ID --%>
						<td><%= bean.getItemId() %></td>
						<%-- 商品名 --%>
						<td><%= bean.getItemName() %></td>
						<%-- 価格 --%>
						<td class="int"><%= bean.getPrice() %></td>
						<%-- 数量（在庫） --%>
						<td class="int"><%= bean.getQuantity() %></td>


						<% if(bean.getQuantity() != 0) { %>
						<%-- 数量（在庫）がある場合はリストボックスをと購入ボタンを表示 --%>
						<td>
							<select class="list" name="<%= bean.getItemId() %>list">


							<%-- 在庫の数 リストボックス「1～」表示 --%>
								<% for(int i = 0; i <= bean.getQuantity(); i++) { %>
									<option value=<%= i %>><%= i %></option>
								<% } %>
							</select>
						</td>

						<td class="button">
							<input class="common_button" type="submit" value="購入" name="<%= bean.getItemId() %>">
						</td>

						<%-- 数量（在庫）がない場合は「売り切れ！」と表示 --%>
						<% } else { %>
						<td></td>
						<td class="button">売り切れ！</td>
						<% } %>

						<td>
						<input type = text name="text1" size=5>
						</td>

					</tr>
				<% } %>

				</tbody>
			</table>
			<input class="common_button" type="button" onclick="location.href='./contents/login.jsp'" value="戻る">
		</form>
	</body>
</html>