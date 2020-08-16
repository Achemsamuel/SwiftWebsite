import Foundation
import Publish
import Plot

// This type acts as the configuration for your website.
struct MySwiftBlogWebsite: Website {
    enum SectionID: String, WebsiteSectionID {
        // Add the sections that you want your website to contain here:
        case posts
    }
    
    struct ItemMetadata: WebsiteItemMetadata {
        // Add any site-specific metadata that you want to use here.
    }
    
    // Update these properties to configure your website:
    var url = URL(string: "https://arch.com")!
    var name = "Arch"
    var description = "This website is my first website sorely developed in Swift. Ofcourse there's a bit of Javascript and CSS to make this look as amazing as it should be. However, I am really happy about this, and S/O to John Sundell, this could be a real game changer for those that feel they are restricted to developing mobile apps alone and are not into Vapor."
    var language: Language { .english }
    var imagePath: Path? { "Resources/Images/mother.png" }
}

private extension Node where Context == HTML.BodyContext {
    static func wrapper(_ nodes: Node...) -> Node {
        .div(.class("wrapper"), .group(nodes))
    }
    
    static func itemList<T: Website>(for items: [Item<T>], on site: T) -> Node {
           return .ul(
               .class("item-list"),
               .forEach(items) { item in
                   .li(.article(
                       .h1(.a(
                           .href(item.path),
                           .text(item.title)
                       )),
                       .p(.text(item.description))
                   ))//li
               }//forEach
           )//ul
       }
    
    static func footer<T: Website>(for site: T) -> Node {
           return .footer(
               .p(
                   .text("© Achem Samuel 2020."),
                   .a(
                       .text("Github"),
                       .href("https://github.com/achemsamuel")
                   )
            )
               /*.p(.a(
                   .text("RSS feed"),
                   .href("/feed.rss")
               ))*/
           )
       }
}

struct MyHTMLFactory<Site: Website>: HTMLFactory {
    func makeIndexHTML(for index: Index, context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .head(for: index, on: context.site),
            
            .body(
                .header(
                    .wrapper(
                        .nav(
                            //.class("site-name"),
                            //.text(context.site.name)
                            .ul(
                                .class("site-sections"),
                                .li(
                                    .style("font-weight: bold"),
                                    .a(
                                            .style("color:red"),
                                            .text("Motherhood")
                                    )
                                ),//li
                                
                                .li(
                                    .style(" padding-left:300px"),
                                    .a(
                                         .style("color:#bfbfbf"),
                                        .text("Menu")
                                    ) //a
                                ), //li
                                
                                .li(
                                    .style(" padding-left:40px"),
                                    .a(
                                        .style("color:#bfbfbf"),
                                        .text("Supermom")
                                    ) //a
                                ), //li
                                .li(
                                    .style(" padding-left:40px"),
                                    .a(
                                        .style("color:#bfbfbf"),
                                        .text("Contact")
                                    ) //a
                                ),
                                
                                .li(
                                    .style("float: right"),
                                    .a(
                                        .class("but"),
                                        .text("Sign In")
                                    )//a
                                )//li
                            )//ul
                        )//nav
                    )//wrapper
                ), //header
                .wrapper(
                    .div(
                        .h1(
                            .img(
                                .class("image"),
                                .alt("Mother feeding baby"),
                                .src("https://res.cloudinary.com/dyuuulmg0/image/upload/v1587387299/mother.png")
                            ),
                            .text("Experience the"),
                            .br(),
                            .h2(
                                .style(""),
                                .text("Joys of Motherhood")
                            )//h2
                        ), //h1
                        .button(
                            .text("I want a Baby")
                        )//button
                    ) //div
                )//wrapper
            )//body
        )//html
    }
    
    func makeSectionHTML(for section: Section<Site>, context: PublishingContext<Site>) throws -> HTML {
          HTML(
            .head(for: section, on: context.site),
            .body(
                .header(
                    .wrapper(
                        .nav(
                        .class("Blueberries on the roillsite-name"),
                        .text("")
                        )
                    )
                )
            )
        )//html
    }
    
    func makeItemHTML(for item: Item<Site>, context: PublishingContext<Site>) throws -> HTML {
          HTML(
            .head(for: item, on: context.site)
        ) //html
    }
    
    func makePageHTML(for page: Page, context: PublishingContext<Site>) throws -> HTML {
        try makeIndexHTML(for: context.index, context: context)
    }
    
    func makeTagListHTML(for page: TagListPage, context: PublishingContext<Site>) throws -> HTML? {
        return nil
    }
    
    func makeTagDetailsHTML(for page: TagDetailsPage, context: PublishingContext<Site>) throws -> HTML? {
        return nil
    }
    
    
}

extension Theme {
    static var myTheme: Theme {
        Theme(htmlFactory: MyHTMLFactory(), resourcePaths: ["Resources/MyTheme/styles.css"])
    }
}

// This will generate your website using the built-in Foundation theme:
try MySwiftBlogWebsite().publish(withTheme: .myTheme)
