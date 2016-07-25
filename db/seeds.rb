

User.delete_all
user = User.new username: "ecarralt", password: "12345678", email: "ecarralt@gmail.com", first_name: "Enrique", last_name: "Carral", usertype: "student"
user.save!
user2 = User.new username: "george", password: "12345678", email: "george@gmail.com", first_name: "George", last_name: "Clooney", usertype: "student"
user2.save!
user3 = User.new username: "harry", password: "12345678", email: "harry@gmail.com", first_name: "Harry", last_name: "Potter", usertype: "teacher"
user3.save!

Lesson.delete_all

lesson = Lesson.new title: "Introduction to HTML", released: "1", user_id: user.id, author: "© 2005-2016 Mozilla Developer Network and individual contributors", content: "Most fundamentally, when you look at a webpage in a Web browser, you see words. But most of the time webpages contain styled text rather than plain text.  Nowadays, webpage designers have access to hundreds of different fonts, font sizes, colors, and even alphabets (e.g. Spanish, Japanese, Russian), and browsers can for the most part display them accurately. Webpages may also contain images, video clips, and background music. They may include drop-down menus, search boxes, or links you can follow to access other pages (whether on the same site or another site). Some websites even let visitors customize the page display to accommodate their preferences and challenges (e.g., sight challenges, deafness, or color blindness). Often a page contains content boxes that move (scroll) while the rest of the page remains static.

A typical webpage depends on several technologies (such as CSS, JavaScript, AJAX, JSON) to control what the end-user sees, but most fundamentally, developers write webpages in HTML, without which there can be no webpages. To display the page on the client-side device, a browser starts out by reading the HTML.

The W3C (World Wide Web Consortium) and the WHATWG (Web Hypertext Application Technology Working Group) maintains the HTML international standards and specifications. The WHATWG treats HTML as a constantly evolving 'living standard', whereas the W3C works both on HTML evolution (HTML 5.1) and on 'snapshots' of HTML (of which the most recent is HTML5).

The HTML specification defines a single language that can be written either with the relaxed HTML syntax or the stricter XML syntax (Extensible Markup Language). HTML also addresses the needs of Web apps. HTML only describes the meaning of the content, not style and formatting. To define appearance and layout, please use CSS, not explicit presentational HTML.

This article provides an Introduction to HTML. If you've ever wondered what goes on behind the scenes in your web browser, this article is the place to start learning."

lesson.save!

lesson2 = Lesson.new title: "History of HTML", released: "1", user_id: user.id, author: "© 2005-2016 Mozilla Developer Network and individual contributors", content: "Tim Berners-Lee, physicist at CERN (the European Organization for Nuclear Research), devised a way in the late 1980s for scientists to share documents over the Internet. Before that, Internet communication had been limited to plain text, using technologies such as email, FTP (File Transfer Protocol), and Usenet-based discussion boards. HTML used a content model stored on a central server but transferrable to a local workstation and viewable in a browser, simplifying access to content and making 'rich' content possible (such as sophisticated text formatting and images). HTML is derived from SGML, which is a complex syntax for marking up or binding of content (text or graphics) in documents; as of HTML5, HTML no longer attempts to adhere to SGML syntax."
lesson2.save!

lesson3 = Lesson.new title: "What is HTML", released: "1", user_id: user.id, author: "© 2005-2016 Mozilla Developer Network and individual contributors", content: "HTML is a markup language. The word markup was used by editors who marked up manuscripts (usually with a blue pencil) when giving instructions for revisions. 'Markup' now means something slightly different: a language with specific syntax that instructs a Web browser how to display a page. Once again, HTML separates 'content' (words, images, audio, video, and so on) from 'presentation' (instructions for displaying each type of content). HTML uses a pre-defined set of elements to define content types. Elements contain one or more 'tags' that contain or express content. Tags are enclosed by angle brackets, and the closing tag begins with a forward slash.
The basic HTML code structure is shown below:
<html>
<head>
    <title>Page title here</title>
</head>
<body>
    This is sample text...
    <!-- We use this syntax to write comments -->
    <!-- Page content and rest of the tags here... -->
    <!-- This is the actual area that gets shown in the browser -->
</body>
</html>

he paragraph element consists of the start tag '<p>' and the closing tag '</p>'. The following example shows a paragraph contained within the HTML paragraph element. Remember that your browser will not display more than one space character in a row.

<p>You are beginning to learn HTML.</p>"
lesson3.save!

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
