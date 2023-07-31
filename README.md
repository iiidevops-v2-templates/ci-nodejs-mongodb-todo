# Node Todo App
A Node app built with MongoDB and Angular. For demonstration purposes and a tutorial.
Node provides the RESTful API. Angular provides the frontend and accesses the API. MongoDB stores like a hoarder.

## 專案資料夾與檔案格式說明
檔案可按照需求做修改，`postman_collection_local.json`是要快速部屬時進行Postman collection測試的的檔案，測試結果會自動產生`newman-report.xml`。`openapi_local.yaml`主要是透過owasp ZAP來進行安全掃描，測試報告會自動產生`owasp-report.md`，內包含詳細的掃描內容與建議。  

| 型態 | 名稱 | 說明 | 路徑 |
| --- | --- | --- | --- |
| 資料夾 | app | 專案主要程式碼 | 根目錄 |
| 檔案 | Dockerfile.local | (可調整)本地端部屬使用 | 根目錄 |
| 檔案 | docker-compose.yaml | (可調整)本地端快速部屬使用 | 根目錄 |
| 檔案 | postman_collection_local.json | (可調整)本地端快速部屬使用(Postman collection) | 在app資料夾內 |
| 檔案 | openapi_local.yaml | (可調整)本地端快速部屬使用(openAPI文件) | 在app資料夾內 | 
| 檔案 | newman-report.xml | (自動產生)Postman collection本地端測試報告 | 在app資料夾內 |
| 檔案 | owasp-report.md | (自動產生)owasp ZAP-本地端掃描測試報告 | 在app資料夾內 |
| 資料夾 | iiidevops | :warning: devops系統測試所需檔案 | 在根目錄 |
| 檔案 | .rancher-pipeline.yml | :warning: (不可更動)devops系統測試所需檔案 | 在根目錄 |
| 檔案 | pipeline_settings.json | :warning: (不可更動)devops系統測試所需檔案 | 在iiidevops資料夾內 |
| 檔案 | postman_collection.json | (可調整)devops newman部屬測試檔案 | iiidevops/postman資料夾內 |
| 檔案 | postman_environment.json | (可調整)devops newman部屬測試檔案 | iiidevops/postman資料夾內 |
| 檔案 | app.env | (可調整)devops newman部屬測試檔案 | 在iiidevops資料夾內 |
| 檔案 | Dockerfile | (可調整)devops k8s環境部屬檔案 | 根目錄 |

## 開發者注意事項
:warning: 若專案建立後程式碼Pull到local端下來無法執行, 此狀況為正常現象
* 要在local端測試部屬提供兩種方式，透過安裝docker來進行專案快速專案部屬或直接修改我您作業系統的環境變數
* 若非用docker快速部屬想直接採用原本安裝在作業系統上的資料庫的話，請設定環境變數
```env
`db_host`: 指向到您的資料庫，例如localhost或是其他IP
`db_name`: 指向到您的資料庫名稱
`db_username`: 指向到您的資料庫使用者名稱
`db_password`: 指向到您的資料庫密碼
```

## 修改程式碼注意事項
1. 修改資料庫連線  
由於系統採用固定獨特的環境變數作為資料庫連線方法，因此專案的資料庫連線部分請勿更動`config/server.js`內的  
或是自行將程式碼修改為讀取相同的環境變數方式也可
```
var db_username = process.env.db_username
var db_password = process.env.db_password
var db_host = process.env.db_host
var db_name = process.env.db_name
var database_url = 'mongodb://'+db_username+':'+db_password+'@'+db_host+':27017/'+db_name
mongoose.connect(database_url)
```
2. 修改環境版本  
而環境版本若非node:12.21， 想要更換環境版本請至`Dockefile`修改為自己想要的版本(如需要本機上做測試則須一併連同`Dockerfile.local`去做修改)
3. 部屬環境額外環境變數
若開發需求上可能有針對專案需要的特別環境變數，可在`iiidevops/app.env`將自行想要使用的環境變數輸入進入，系統就自動會在部屬時將環境變數增加到前端網站部屬的環境之中
```
環境變數名稱1=值1
環境變數名稱2=值2
環境變數名稱3=值3
```

## iiidevops
* 專案內`.rancher-pipeline.yml`請勿更動，產品系統設計上不支援pipeline修改
* 目前系統pipeline限制，因此寫的服務請一定要在port:`8080`，資料庫類型無法更改。
* `iiidevops`資料夾內`pipeline_settings.json`請勿更動
* `postman`資料夾內則是您在devops管理網頁上的Postman-collection(newman)自動測試檔案，devops系統會以`postman`資料夾內檔案做自動測試
* `Dockerfile`內可能會看到很多本地端`Dockerfile.local`都加上前墜dockerhub，此為必須需求，為使image能從harbor上擷取出Docker Hub的image來源

## Reference
https://github.com/scotch-io/node-todo
