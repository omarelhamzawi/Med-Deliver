$(document).ready(function() {	
	const SERVER_URL = "http://localhost:8080";
	
	//Fix for double product getting added in pharmacy.html
	var clickedAddCart = false;
	
	jQuery.fn.extend({
		
		urlParam: function (name) {
			var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(window.location.href);
			return decodeURI(results[1]) || 0;
		},
		
		addItem: function (id, name, description, price, qty) {
			var cart = new Array();
					
			var product = {
				"id": id, 					
				"name": name, 					
				"description": description, 					
				"price": price, 					
				"qty": qty				
			};
						
			if (localStorage.getItem("cart") === null) {
				cart.push(product);	
				localStorage.setItem('cart', JSON.stringify(cart));
				console.log("Shopping Cart Created");
			} else {		
				cart = JSON.parse(localStorage.getItem('cart'));
				cart.push(product);		
				localStorage.setItem('cart', JSON.stringify(cart));			
				console.log("Added Item To Cart");
				console.log("Current Cart: " + localStorage.getItem('cart'));
			}
			
			alert("Added item to shopping basket");
		},
		
		clearCart: function () {
			console.log("Cart Cleared");
			localStorage.removeItem("cart");
			$('#totalPrice').text("£0.00");
		},
		
		populateTable: function (content) {
			$(content).appendTo("#data table tbody");
		},
		
		clearTable: function () {
			console.log("Table cleared");
			$('#data table tbody tr').remove();
		},
		
		showProduct: function(pharmacyId, productId) {
			$.ajax({
				dataType: "json",
				url: SERVER_URL,
				type: 'post',
				data: JSON.stringify( { "authKey": "1234", "requestType": "getProduct", "pharmacyId": pharmacyId, "productId": productId } ),
				success: function(data) {
					$().clearTable();

					content = '<tr>';
					content += '<span id="itemId" class="hidden">' + data.id + '</span>';

					content += '<td class="" id="itemName">';
					content += '<a href="product.html?pharmacyId=' + pharmacyId + "&productId=" + data.id + '">'  + data.name + '</a><br><br>';
					content += '<span id="itemDescription">' + data.description + '</span><br><br>';
					content += '<span id="itemPrice">' + '£' + data.price + '</span><br><br>';
					content += '<img src="' + data.imageURL + '" alt="image" width="150" height="150"><br><br>';
					content += '<strong><span><input type="number" value="1" style="width: 50px;" id="itemQty"></span></strong>';
					content += ' <button id="add-to-cart">Add to Cart</button> <br><hr>';
					content += '</td>';
				
					content += '</tr>';			
								
					$().populateTable(content);	
							
					$("#add-to-cart").click(function() {							
						var id = data.id;
						var name = data.name;
						var description = data.description;
						var price = data.price;
						var qty = $("#itemQty").val();	
						$().addItem(id, name, description, price, qty);
					});					
				},
				error: function(e) { console.log("Could not populate table:" + e); }
			});
		},
		
		getProducts: function(pharmacyId) {					
			$.ajax({
				dataType: "json",
				url: SERVER_URL,
				type: 'post',
				data: JSON.stringify( { "authKey": "1234", "requestType": "getProducts", "pharmacyId":  pharmacyId } ),
				success: function(data) {
					$().clearTable();
														
					$.each(data.products, function(i, products) {
						content = '<tr>';
						content += '<span class="hidden" id="itemId">' + products.id + '</span>';
						
						content += '<td class="" id="itemName">';
						content += '<a href="product.html?pharmacyId=' + pharmacyId + "&productId=" + products.id + '">'  + products.name + '</a><br><br>';
						content += '<span id="itemDescription">' + products.description + '</span><br><br>';
						content += '<span id="itemPrice">' + '£' + products.price + '</span><br><br>';
						content += '<span><input type="number" value="1" style="width: 50px;" id="itemQty"></span> ';
						content += ' <button class="add-to-cart">Add to Cart</button> <br><hr>';
						content += '</td>';
		
						content += '</tr>';
								
						$().populateTable(content);	
								
						$(".add-to-cart").one().click(function() {			
							if(clickedAddCart === true) {
								clickedAddCart = false;
								return;
							}
							clickedAddCart = true;
							var id = products.id;
							var name = products.name;
							var description = products.description;
							var price = products.price;
							var qty = $("#itemQty").val();	
							$().addItem(id, name, description, price, qty);
						});
								
					});
				},
				error: function(e) { console.log("Could not populate table:" + e); }
			});
		},
		
		searchForPharmacy: function(query) {
			$.ajax({
				dataType: "json",
				url: SERVER_URL,
				type: 'post',
				data: JSON.stringify( { "authKey": "1234", "requestType": "getPharmacies", "query": query } ),
				success: function(data) {
					if(data.pharmacies.length <= 0) {
						alert("No results found.")
					}
					
					$().clearTable();
					$.each(data.pharmacies, function(i, products) {
						content = '<tr>';
						content += '<td>';
						content += '<a href="pharmacy.html?id=' + products.id + '">' + products.name + '</a><br>';
						content += products.address;
						content += "</td>";
						content += '</tr>';			
						$().populateTable(content);	
					});
				},
				error: function(e) { console.log("Could not populate table:" + e); }
			});
		},
		
		showCart: function () {
			if (localStorage.getItem("cart") === null) {
				console.log("Shopping Cart Is Empty!")		
			} else {
				$().clearTable();
				var cart = JSON.parse(localStorage.getItem('cart'));
				
				var totalPrice = 0;
				
				$.each(cart, function(i, item) {
					console.log("loop");
					content = '<tr>';	
					content += '<td>';
					content += '<strong><span class="name">'  + item.name + '</span></strong><br>';
					
					content += '<span id="itemDescription">' + item.description + '</span><br><br>';
					content += '<span id="itemPrice">' + 'Price: £' + item.price + '</span><br>';
					content += '<span id="itemPrice">Qty:' + item.qty + '</span><br><hr>';
					content += '</td>';
					content += '</tr>';	
					
					totalPrice += (item.qty * item.price);
					
					$().populateTable(content);	
				});
				
				$('#totalPrice').text("£" + totalPrice);

				
				//Create checkout button
				paypal = "<form action='https://www.paypal.com/cgi-bin/webscr' method='POST'>";
				paypal += "<input type='hidden' name='cmd' value='_cart'>";
				paypal += "<input type='hidden' name='upload' value='1'>";
				paypal += "<input type='hidden' name='business' value='surajkumar.uk96@gmail.com'>";			
				paypal += "<input type='hidden' name='currency_code' value='GBP'>";

				var counter = 1;

				$.each(cart, function(i, item) {
					paypal += "<input type='hidden' name='item_name_" + counter + "' value='" + item.name + "'>";
					paypal += "<input type='hidden' name='item_number_" + counter + "' value='" + item.id + "'>";
					paypal += "<input type='hidden' name='amount_" + counter + "' value='" + item.price + "'>";
					paypal += "<input type='hidden' name='quantity_" + counter + "' value='" + item.qty + "'>";
					counter++;
				});
						
				paypal += "<input type='hidden' name='lc' value='GB'>";
				paypal += "<input type='hidden' name='rm' value='2'>";
				paypal += "<input type='hidden' name='return' value='success.html'>";
				paypal += "<input type='hidden' name='cancel_return' value='cancel.html'>";
				paypal += "<input type='hidden' name='notify_url' value='paypal.php'>";
				paypal += "<input type='hidden' name='charset' value='utf-8'>";
				paypal += "<input type='submit' value='Checkout' class='button1'>";
				paypal += "</form>";
						
				$(paypal).appendTo("#checkout-button");
			}
		}			
	});	
});