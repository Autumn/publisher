# publisher

Simple website generator. Opens your base layout and injects content into #content. Requires marked.js to render Markdown into HTML on the client.

# Use

- Configure your site with the `config` file.
 - `Published file:template file` tuple.
- Write markdown content to the template files.
- `publish.rb build` to generate HTML pages.
- `publish.rb publish file` to add a dated post. Creates a file `year-month-day-title.html`.

```ruby
# ruby publish.rb
publisher - dead simple website generator

build - builds pages listed in the config file
publish file - adds file to the site
link url description commentary? - add a link
#
```






