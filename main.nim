import jester
import htmlgen
var page = readFile("main.html")
routes:
  get "/":
    resp h1(page)
