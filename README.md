# JSON API Exercise

I used the `jsonapi-utils` gem, which uses the `jsonapi-resources` gem that was explicitly required.

## API

The API has two endpoints, both requests and responses are JSON API compliant:
- `GET /pages` returns all pages
- `POST /pages` accepts a single `url` attribute, scrapes the given URL and returns the `page` object

### Examples

```
POST /pages/
{ "data": {
    "type":"posts",
    "attributes": {
      "url": "https://www.w3schools.com/htmL/html_headings.asp"
    }
  }
}
```

Returns:
```
{
    "data": {
        "id": "22",
        "type": "pages",
        "links": {
            "self": "http://localhost:3000/pages/22"
        },
        "attributes": {
            "h1": [
                "HTML Headings",
                "Heading 1"
            ],
            "h2": [
                "HTML5 Tutorial",
                (...)
                "Thank You For Helping Us!"
            ],
            "h3": [
                "HTML and CSS",
                (...)
                "Inspect an HTML Element:"
            ],
            "links": [
                "https://www.w3schools.com",
                (...)
                "https://www.w3schools.com"
            ],
            "url": "https://www.w3schools.com/htmL/html_headings.asp"
        }
    }
}
```

## Considerations

I intentionally implemented only the specification and didn't fill the project with features to show off. Doing that would increase the risks of something breaking and possibly violating the specification. I would rather present something simple that (hopefully!) works instead of adding more endpoints and features and having one of them fail.

The scraper handles invalid URLs and timeouts with proper error messages for each case.

For testing I made some integration tests using `webmock` to make sure that Nokogiri really made requests and parsed what it received correctly. More tests would be necessary to cover the whole spectrum of broken HTML etc.

I believe the code is readable and very simple. For example the whole scraper fits in just a few lines:
```
def scrape
  doc = Nokogiri::HTML(open(self.url))
  self.h1 = doc.css('h1').map { |el| el.text }
  self.h2 = doc.css('h2').map { |el| el.text }
  self.h3 = doc.css('h3').map { |el| el.text }
  self.links = doc.css('a[href]').map do |el|
    URI.join( self.url, el['href'] ).to_s
  end
end
```
