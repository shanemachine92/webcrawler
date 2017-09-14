### Morrigan, the Dragon Age Wikia Web Crawler

This web crawler collects all of the internal links for www.dragaonage.wikia.com and writes the links and contents of each page to a SQLite3 database.

If a url is valid, the crawler will collect all the links on the page and store them in the databse with a state of 'uncrawled'. Once a page has been visited the state is updated to 'crawled'. This ensures that the crawler only visits each page once and if interrupted, will not recrawl pages visted in previous sessions.

If the url is invalid, the state is updated to 'error' and the crawler continues to the next uncrawled link.

To use, clone the repo: ``` git clone git@github.com:shanemachine92/webcrawler.git ```

and then run the crawler via the command line: ```ruby script.rb```
