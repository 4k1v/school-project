import jester,htmlgen,std/random,std/strformat,strutils

settings:
  staticDir = "/home/user/sw/schproj"
routes:

  get "/":
    randomize()
    var 
      tasknumber = rand(100)
      s = readFile(&"list/task{tasknumber}")
      words = s.split()
    setCookie("test",s, daysForward(5))  
    var 
      page = readFile("main.html")
      newpage = page.replace("""<div id="task" >word</div> """,&"""<div id="task" >{words[0]}</div>""")
    resp h1(newpage)
  post "/form/submit":
    echo request.cookies["test"]
    var 
      global = request.cookies["test"].split()
      answer = readFile("answer.html")
      newanswer:string
      word1 = request.params["num1"]
      word2 = request.params["num2"]
      color:string
      color2:string
    if word1 != global[1]:
      color = "#FF0000"
    else:
      color = "#4CBB17"
    if word2 != global[2]:
      color2 = "#FF0000"
    else:
      color2 = "#4CBB17"
    newanswer = answer.replace( """<div>Ответ1</div>""",&"""<div id="ts1">Ваш ответ:<div  style="color:{color}"">{word1}</div> Правильный ответ: {global[1]}</div> """)
    newanswer = newanswer.replace( """<div>Ответ2</div>""",&"""<div id="ts1">Ваш ответ:<div  style="color:{color2}"">{word2}</div> Правильный ответ: {global[2]}</div> """)
    resp h1(newanswer)

    
