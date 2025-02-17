<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.util.List"%>
    <%@page import="com.web.domain.CertVO" %>
    <%@page import="com.web.domain.SiteVO" %>
    <% CertVO cert = (CertVO) request.getAttribute("getCert");%>
    <% List<SiteVO> siteList = (List<SiteVO>) request.getAttribute("getSiteList");%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	
	<title>Register</title>
	<link rel="stylesheet" href="/webjars/bootstrap/4.1.0/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="/css/Home.css">
</head>

<body class="my-Home-page">
	<section class="h-100">
		<div class="container h-100">
			<div class="row justify-content-md-center h-100">
				<div class="card-wrapper">
					<div class="brand">
						<img src="/img/logo.png">
					</div>
					<div class="card fat">
						<div class="card-body">
							<h4 class="card-title text-center text-dark">
							인증서 수정
							<p></p>
							</h4>
							<form method="POST">
								<div class="form-group has-feedback">
									<label class="control-label" for="co_name">성명(영문)</label>
									<input class="form-control" type="text" id="co_name" name="co_name" value = "<%=cert.getCo_name()%>"/>
								</div>
								<div class="form-group has-feedback">
									<label class="control-label" for="co_cert_pw">인증서 비밀번호</label>
									<input class="form-control" type="password" id="co_cert_pw" name="co_cert_pw" value = "<%=cert.getCo_cert_pw()%>"/>
								</div>
								<div class="form-group has-feedback" id="certs">
									<label class="control-label" for="co_cert_der">인증서</label>
									<input type="radio" name="cert_type" value="der/key" checked="checked"/> der/key
									<input type="radio" name="cert_type" value="pfx"  /> pfx
									<div>
										<label class="control-label" for="co_cert_der">der</label>
										<input class="form-control" type="file" id="co_cert_der" name="co_cert_der" accept=".der" />
										<label class="control-label" for="co_cert_key">key</label>
										<input class="form-control" type="file" id="co_cert_key" name="co_cert_key" accept=".key" /></div></div>
								<div class="form-group has-feedback">
									<label class="control-label" for="account">계정</label>
								<div id ="sites"><%int i = 0;for(SiteVO site : siteList) { %><div>
										<input class="form-control" type="text" name="co_domain" value="<%=site.getCo_domain() %>" placeholder="url" />
										<input class="form-control" type="text" name="co_id" value="<%=site.getCo_id() %>" placeholder="id"/>
										<input class="form-control" type="text" name="co_pw" value="<%=site.getCo_pw() %>" placeholder="pw"/>
									</div><%i++;}%></div>
									<input type ="button" value="+"  onclick="addSite()" style="WIDTH: 30pt; margin-bottom: 10px"/>
								<div class="form-group has-feedback">
										<input type="button" value="수정" class="btn btn-info btn-block" onclick="modify(); window.open('/');"/>
								</div>
							</form>
						</div>
					</div>
					<div class="footer">
						Copyright © <a href="https://www.flyhigh-x.com/" class="badge badge-info">FLYHIGH</a> 2020
					</div>
				</div>
			</div>
		</div>
	</section>
	<script type="text/javascript">
		function addButton(button) {
			button.addEventListener('click',function() {deleteSite(button)});
			console.log(button);
		}
		
		window.onload = function () {
			var sites = document.getElementById("sites");
			var childs = sites.childNodes;
			console.log(sites.childElementCount);
			buttons = new Array();
			for(var i = 0; i < childs.length ;i++) {
				console.log(childs[i]);
				var button = document.createElement("input");
				var border= document.createElement("hr");
				
				button.setAttribute('type',"button");
				button.setAttribute('value',"-");
				button.setAttribute('style',"WIDTH: 30pt;");
				addButton(button);
				
				childs[i].appendChild(button);
				childs[i].appendChild(border);
			}
			
		};
		var isDer = true;
		var rad = document.getElementsByName("cert_type");
		console.log(rad);
		
		rad[0].addEventListener('change',function () {
			console.log("der/key!");
			var certs = document.getElementById("certs");
			
			if(certs.childElementCount > 3){
				console.log("certs" + certs.childElementCount);
				console.log("certs" + certs.lastChild);
				certs.removeChild(certs.lastChild);
			}
				
			var pickerContainer = document.createElement("div");
			
			var derLabel = document.createElement("label");
			derLabel.setAttribute('class',"control-label");
			derLabel.setAttribute('for',"co_cert_der");
			derLabel.innerHTML = "der";
			
			var derPicker = document.createElement("input");
			derPicker.setAttribute('class',"form-control");
			derPicker.setAttribute('type',"file");
			derPicker.setAttribute('id',"co_cert_der");
			derPicker.setAttribute('name',"co_cert_der");
			derPicker.setAttribute('accept',".der");
			
			var keyLabel = document.createElement("label");
			keyLabel.setAttribute('class',"control-label");
			keyLabel.setAttribute('for',"co_cert_key");
			keyLabel.innerHTML = "key";
			
			var keyPicker = document.createElement("input");
			keyPicker.setAttribute('class',"form-control");
			keyPicker.setAttribute('type',"file");
			keyPicker.setAttribute('id',"co_cert_key");
			keyPicker.setAttribute('name',"co_cert_key");
			keyPicker.setAttribute('accept',".key");
			
			pickerContainer.appendChild(derLabel);
			pickerContainer.appendChild(derPicker);
			pickerContainer.appendChild(keyLabel);
			pickerContainer.appendChild(keyPicker);
			certs.appendChild(pickerContainer);
			isDer = true;
		
		});
		rad[1].addEventListener('change',function () {
			console.log("pfx!");
			var certs = document.getElementById("certs");
			if(certs.childElementCount > 3) {
				console.log("certs" + certs.childElementCount);
				console.log("certs" + certs.lastChild);
				certs.removeChild(certs.lastChild);
			}
			var pickerContainer = document.createElement("div");
			
			var pfxLabel = document.createElement("label");
			pfxLabel.setAttribute('class',"control-label");
			pfxLabel.setAttribute('for',"co_cert_pfx");
			pfxLabel.innerHTML = "pfx";
			
			var pfxPicker = document.createElement("input");
			pfxPicker.setAttribute('class',"form-control");
			pfxPicker.setAttribute('type',"file");
			pfxPicker.setAttribute('id',"co_cert_pfx");
			pfxPicker.setAttribute('name',"co_cert_pfx");
			pfxPicker.setAttribute('accept',".pfx");
			
			pickerContainer.appendChild(pfxLabel);
			pickerContainer.appendChild(pfxPicker);
			certs.appendChild(pickerContainer);
			isDer = false;
		});
		
		function readFile(file, callback) {
			return new Promise((resolve,reject) =>  {
				const derMaxSize = 4096;
				const pfxMaxSize = 8192;
				
				if(file.files[0] == null) {
					resolve();
				}
				
				if(file.files[0].size == 0) {
					reject(new Error("[msg : file size is 0] [code : ]"));
				}
				if(isDer) {
					if(file.files[0].size > derMaxSize) {
						reject(new Error("[msg : Der/key File size bigger than 4kb] [code : ]"));
					}
				} else {
					if(file.files[0].size > pfxMaxSize) {
						reject(new Error("[msg : pfx File size bigger than 8kb] [code : ]"));
					}
				}
				var fileReader = new FileReader();
				 fileReader.onload = () => {
					callback(fileReader.result);
					resolve();// promise는 resolve가 호출될때까지 기다린다.(resolve();가 promise에선 return;과 같다.)
				} 
				fileReader.onError = reject;
				
				fileReader.readAsBinaryString(file.files[0]);
			});
		}
		
		async function modify() {
			//jsonBody
			var co_name = document.getElementById("co_name").value;
			var co_cert_pw = document.getElementById("co_cert_pw").value;
			var co_cert_type = ((isDer) ? (1) : (2));
			var co_cert_der = null;
			var co_cert_key = null;
			var co_certification = null;
			console.log("name : " +co_name);
			console.log("pw : " +co_name);
			console.log("type : " +co_cert_type);
			
			
			var onload = false;
			if(isDer) {
				try {
					await readFile(document.getElementById("co_cert_der"),function(e) {
						co_cert_der = btoa(e);
						//console.log("co_cert_der : " +co_cert_der);
					});
				} catch(err) {
					alert('err : ${err.name}: ${err.message}');
				}
				
				await readFile(document.getElementById("co_cert_key"),function(e) {
					co_cert_key = btoa(e);
					//console.log("co_cert_key : " +co_cert_key);
				});
				console.log("co_cert_der : " +co_cert_der);
				console.log("co_cert_key : " +co_cert_key);
			} else {
				try {
				await readFile(document.getElementById("co_cert_pfx"),function(e) {
					co_certification = btoa(e);
				});
				} catch(err) {
					alert('err : ${err.name}: ${err.message}');
				}
				console.log("co_certification : " +co_certification);
			}
			
			var urls = document.getElementsByName("co_domain");
			var ids = document.getElementsByName("co_id");
			var pws = document.getElementsByName("co_pw");
			
			
			for(var i = 0 ; i < urls.length;i++) {
				console.log("url" + "[" + i + "] : " +urls[i].value);
				console.log("id" + "[" + i + "] : " +ids[i].value);
				console.log("pw" + "[" + i + "] : " +pws[i].value);
			}
			
			var json = new Object();
			json.subject = co_name;
			json.cert_pw = co_cert_pw;
			json.cert_type = co_cert_type;
			
			var certification = new Object();
			certification.der = co_cert_der;
			certification.key = co_cert_key;
			certification.pfx = co_certification;
			json.certification = certification;
			
			var account = new Array();
			for(var i = 0; i < urls.length;i++) {
				var element = new Object();
				element.site = urls[i].value;
				element.id = ids[i].value;
				element.pw = pws[i].value;
				account.push(element);
			}
			json.account = account;
			json.count = urls.length;
			
			console.log("request: \n" + JSON.stringify(json));
			
			var request = json;

			//fetch
			fetch('/private/modify',{
		        method: 'POST', // *GET, POST, PUT, DELETE, etc.
		        mode: 'cors', // no-cors, cors, *same-origin
		        cache: 'no-cache', // *default, no-cache, reload, force-cache, only-if-cached
		        credentials: 'same-origin', // include, *same-origin, omit
		        headers: {
		            'Content-Type': 'application/json'
		        },
		        redirect: 'follow', // manual, *follow, error
		        referrer: 'no-referrer', // no-referrer, *client
		        body: JSON.stringify(request) // body data type must match "Content-Type" header
		    }) // private/register로 request 보냄
			  .then(function(response) {
			    return response.json(); //response를 json객체로
			  })
			  .then(function(myJson) {
				  //do something with json
			    console.log("response: \n" + JSON.stringify(myJson));
			  });
			
			
			//href
		}
		
		function addSite() {
			var sites = document.getElementById("sites");
			var newDomain = document.createElement("div");
			var urlNode = document.createElement("input");
			var idNode = document.createElement("input");
			var pwNode = document.createElement("input");
			var button = document.createElement("input");
			var border= document.createElement("hr");
			
			console.log(sites.childElementCount);
			
			urlNode.name = "co_domain";
			urlNode.className = "form-control"
			urlNode.placeholder = "url";
			
			idNode.name = "co_id";
			idNode.className = "form-control"
			idNode.placeholder = "id";
			
			pwNode.name = "co_pw"
			pwNode.className = "form-control"
			pwNode.placeholder = "pw";
			//<input type ="button" value="+"  onclick="addSite()" style="WIDTH: 30pt;"/>
			
			
			button.setAttribute('type',"button");
			button.setAttribute('value',"-");
			button.setAttribute('style',"WIDTH: 30pt;");
			var x = sites.childElementCount;
			button.addEventListener('click',function() {deleteSite(button)});
			
			newDomain.appendChild(urlNode);
			newDomain.appendChild(idNode);
			newDomain.appendChild(pwNode);
			newDomain.appendChild(button);
			newDomain.appendChild(border);
			
			sites.appendChild(newDomain);
			console.log(sites.lastChild);
		}
		function deleteSite(node) {
			var sites = document.getElementById("sites");
			console.log(sites.childElementCount);
			console.log(node);
			console.log(node.parentElement);
	        if (sites.childElementCount > 1)
	        	node.parentElement.remove();
		}
	</script>

	<script src="/webjars/jquery/3.3.1/jquery.min.js"></script>
	<script src="/webjars/bootstrap/4.1.0/js/bootstrap.min.js"></script>

</body>
</html>