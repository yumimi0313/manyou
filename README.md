#task  
|column|data|  
|:---|---:|   
|id||  
|title|string|    
|content|text|    
|due_date||   
|status||   
|label||  
|priority||
|user_id||

#user  
|column|data|  
|:---|---:| 
|id||  
|name|string|  
|email||  
|password-digest||  

#task_label  
|column|data|  
|:---|---:|   
|id||  
|task_id||  
|label_id||  

#label  
|column|data|  
|:---|---:|  
|id||  
|content|| 

#Herokuへのデプロイ手順  
1.GemfileにGem追加  
- net-imap 0.3.4
- net-pop 0.1.2
- net-smtp 0.3.3 
1.Heroku buildpackを追加する 
1.Herokuにログインする、ターミナルにて%heroku login
1.heroku create  
1.自分のgitとHerokuが紐づいているか確認、%git remote -v  
1.デプロイするターミナルにて、%git push heroku master  
1.エラーが出る、platformの追加、ターミナルにて%bundle lock --add-platform x86_64-linux  
1.エラーが出る、Heroku stackのバージョンを下げる、ターミナルにて%heroku stack:set heroku-20  
1.再度Herokuへデプロイ%git push heroku master  
1.データベースの移行、ターミナルにて%heroku run rails db:migrate  
