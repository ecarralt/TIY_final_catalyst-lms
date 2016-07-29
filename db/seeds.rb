

User.delete_all
user = User.new username: "ecarralt", password: "12345678", email: "ecarralt@gmail.com", first_name: "Enrique", last_name: "Carral", usertype: "student"
user.save!
user2 = User.new username: "george", password: "12345678", email: "george@gmail.com", first_name: "George", last_name: "Clooney", usertype: "student"
user2.save!
user3 = User.new username: "harry", password: "12345678", email: "harry@gmail.com", first_name: "Harry", last_name: "Potter", usertype: "teacher"
user3.save!

Lesson.delete_all

lesson = Lesson.new lesson_number: 1, title: "Introduction to HTML", released: "1", user_id: user3.id, author: "© 2005-2016 Mozilla Developer Network and individual contributors", content: "Most fundamentally, when you look at a webpage in a Web browser, you see words. But most of the time webpages contain styled text rather than plain text.  Nowadays, webpage designers have access to hundreds of different fonts, font sizes, colors, and even alphabets (e.g. Spanish, Japanese, Russian), and browsers can for the most part display them accurately. Webpages may also contain images, video clips, and background music. They may include drop-down menus, search boxes, or links you can follow to access other pages (whether on the same site or another site). Some websites even let visitors customize the page display to accommodate their preferences and challenges (e.g., sight challenges, deafness, or color blindness). Often a page contains content boxes that move (scroll) while the rest of the page remains static.

A typical webpage depends on several technologies (such as CSS, JavaScript, AJAX, JSON) to control what the end-user sees, but most fundamentally, developers write webpages in HTML, without which there can be no webpages. To display the page on the client-side device, a browser starts out by reading the HTML.

The W3C (World Wide Web Consortium) and the WHATWG (Web Hypertext Application Technology Working Group) maintains the HTML international standards and specifications. The WHATWG treats HTML as a constantly evolving 'living standard', whereas the W3C works both on HTML evolution (HTML 5.1) and on 'snapshots' of HTML (of which the most recent is HTML5).

The HTML specification defines a single language that can be written either with the relaxed HTML syntax or the stricter XML syntax (Extensible Markup Language). HTML also addresses the needs of Web apps. HTML only describes the meaning of the content, not style and formatting. To define appearance and layout, please use CSS, not explicit presentational HTML.

This article provides an Introduction to HTML. If you've ever wondered what goes on behind the scenes in your web browser, this article is the place to start learning."

lesson.save!

lesson2 = Lesson.new lesson_number: 2, title: "History of HTML", released: "1", user_id: user3.id, author: "© 2005-2016 Mozilla Developer Network and individual contributors", content: "Tim Berners-Lee, physicist at CERN (the European Organization for Nuclear Research), devised a way in the late 1980s for scientists to share documents over the Internet. Before that, Internet communication had been limited to plain text, using technologies such as email, FTP (File Transfer Protocol), and Usenet-based discussion boards. HTML used a content model stored on a central server but transferrable to a local workstation and viewable in a browser, simplifying access to content and making 'rich' content possible (such as sophisticated text formatting and images). HTML is derived from SGML, which is a complex syntax for marking up or binding of content (text or graphics) in documents; as of HTML5, HTML no longer attempts to adhere to SGML syntax."
lesson2.save!

lesson3 = Lesson.new lesson_number: 3, title: "What is HTML", released: "1", user_id: user3.id, author: "© 2005-2016 Mozilla Developer Network and individual contributors", content: "HTML is a markup language. The word markup was used by editors who marked up manuscripts (usually with a blue pencil) when giving instructions for revisions. 'Markup' now means something slightly different: a language with specific syntax that instructs a Web browser how to display a page. Once again, HTML separates 'content' (words, images, audio, video, and so on) from 'presentation' (instructions for displaying each type of content). HTML uses a pre-defined set of elements to define content types. Elements contain one or more 'tags' that contain or express content. Tags are enclosed by angle brackets, and the closing tag begins with a forward slash.
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

Assignment.delete_all

assignment = Assignment.new assignment_number: 1, title: "Basic HTML Display Features", released: "1", user_id: user3.id, author: "American University", content: "A basic page needs only a bare minimum of programming. Graphics are an important part of Web pages but so too are words. I look upon the Web as a medium for ideas and the use of new technologies, but not the other way around. A Web page tells a great story with great graphical and analytical presentation.

Using the 'View' option look at the source code for this document. The background color and the text declared in the body refer to a coding system that combines a system of numbers and letters to create thousands of possible color choices. The body color indicates white and the text as being black. I could have just written in 'white' and 'black' instead of these codes.

Here is an example of a horizontal rule:

To begin, we can change the
header size
and color of letters seen on the screen. The font sizecan be changed as well, and actually gives more choices.

We can also change the appearance of words on the screen. This shows some differing word types in a blocked quote.

    Now is the time for all good people to come to the aid of their country.

That was also an example of a nested command."
assignment.save!

assignment2 = Assignment.new assignment_number: 2, title: "Create a website", released: "1", user_id: user3.id, author: "Harry Potter", content: "Your job is to create a web site that shows the following elements.  Make sure all of your code is arranged properly and cleanly.  This is comparable to a test so I will NOT be giving very much help if any. For this first assignment you will have the tutorial to use for help, so it will be your main tool.


-ALL of this information can be found in HTML Chapters 1-7
-Make sure your page has some kind of common theme/topic, not just random stuff!

Your page must contain the following:

1. Basic Tags: Make sure you have your document set as HTML and have a body of the page defined.

2. Background: Set a background color or a background image

3. Font = Font in bold, italics and underlined as well as showing different types of fonts and different font colors and sizes.  You can do this as you fill out your page content.

4. Headings: Your page should have at least TWO different headings of different types. The main heading should be aligned to the center of the page.

5. Images: You need a MINIMUM of 4 images. For the first 3, align one left, one center and one right.  Use the image size tags to resize your images as needed. The fourth image needs to be turned into a link.

6. Pre-format Text: Use the <Pre> tag too set up some text to appear exactly as it does in your code.

7. Links: Have at least THREE links on your page.

8. Lists: You need ONE of each type of list on your page.  Ordered, unordered, and definition list.

8. Misc: I want to see at least TWO different horizontal dividing lines. Also use line breaks <Br> when necessary."

assignment2.save!


Assignmentrecord.delete_all

arecord = Assignmentrecord.new user_id: user.id, assignment_id: assignment2.id, comments: "This is my 1st assingment submission. Looking forward to my feedback!", url_link: "https://www.linkedin.com/in/ecarralt"
File.open("#{Rails.root}/app/assets/others/20160726_AssignmentSubmit_ecarralt.docx", "rb") do |file|
  arecord.contentfile = file
end
arecord.save!

arecord2 = Assignmentrecord.new user_id: user2.id, assignment_id: assignment.id, comments: "This is the 2nd submission. Looking forward to my feedback!", url_link: "https://www.youtube.com"
File.open("#{Rails.root}/app/assets/others/20160728_AssignmentSubmit_george.doc", "rb") do |file|
  arecord2.contentfile = file
end
arecord2.save!


Lessonrecord.delete_all


# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
