---
permalink: /
title: "Welcome to mmd's Homepage"
author_profile: true
redirect_from: 
  - /about/
  - /about.html
---

## About Me

Hello! I'm 萌萌哒mmd, an incoming postgraduate student in Computer Science at the University of Science and Technology of China (USTC). Welcome to my personal academic website!

## What You'll Find Here

- **[Academic Works](/academic-works/)**: My research publications, talks, and teaching experience
- **[Blog Posts](/blog-posts/)**: Thoughts on technology, research, and academia
- **[Personal Interests](/interests/)**: My hobbies and side projects
- **[Course Materials](/course-materials/)**: Teaching resources and educational content
- **[Useful Links](/links/)**: Curated resources for students and researchers
- **[Curriculum Vitae](/cv/)**: My academic and professional background

## Recent Updates

{% assign posts = site.posts | limit: 3 %}
{% if posts.size > 0 %}
### Latest Blog Posts
{% for post in posts %}
- [{{ post.title }}]({{ post.url }}) - {{ post.date | date: "%B %d, %Y" }}
{% endfor %}
{% endif %}

{% assign publications = site.publications | reverse | limit: 2 %}
{% if publications.size > 0 %}
### Recent Publications
{% for pub in publications %}
- [{{ pub.title }}]({{ pub.url }})
{% endfor %}
{% endif %}

## Contact

Feel free to reach out to me at [ly382965@mail.ustc.edu.cn](mailto:ly382965@mail.ustc.edu.cn) or connect with me on [GitHub](https://github.com/ly382965).

---

*This website is built with Jekyll and hosted on GitHub Pages.*
