## How do I start

Add cybotranik library to the `<head>` tag of your page.

Use CDN 

```HTML
    <!-- Cybotranik WUI CDN-->
    <script src="https://unpkg.com/cybotranik-wui"></script>
```
or

Use library

[Download](https://github.com/cybotranik-wui/cybotranik-wui/archive/master.zip) the cybotranik project and use one of the distribution files.

```HTML
    <!-- Cybotranik WUI Library -->
    <script src="dist/cybotranik-wui.min.js"></script>
```

## Examples

```HTML
<!DOCTYPE html>
<html lang="en" dir="ltr">

<head>

    <!-- Google Analytics -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=UA-147146676-1"></script>
    <script>window.dataLayer = window.dataLayer || []; function gtag() { dataLayer.push(arguments); }; gtag('js', new Date()); gtag('config', '147146676-1');</script>

    <!-- Meta -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">

    <!-- Site Information -->
    <title>Cybotranik - WUI - Web User Interface</title>
    <meta name="description" content="Cybotranik WUI Web User Interface.">
    <meta name="keywords" content="Cybotranik, WUI, Web, User, Interface, HTML, framework, css" />

    <!-- The Open Graph protocol -->
    <meta property="og:title" content="Cybotranik - WUI - Web User Interface">
    <meta property="og:type" content="website" />
    <meta property="og:url" content="cybotranik-wui.github.io" />
    <meta property="og:site_name" content="cybotranik-wui">
    <meta property="og:description" content="Cybotranik - WUI - Web User Interface.">
    <meta property="og:image" content="https://cybotranik-wui.github.io/assets/theme/img/social.png" />
    <meta property="og:image:type" content="image/png" />
    <meta property="og:image:alt" content="Cybotranik Web User Interface" />

    <!-- Design-Development -->
    <meta name="author" content="azmisahin.com">
    <meta name="generator" content="cybotranik-wui.github.io">

    <!-- License -->
    <link rel="license" href="LICENSE">

    <!-- Favicon -->
    <link rel="apple-touch-icon" sizes="57x57" href="assets/theme/img/favicon/apple-icon-57x57.png">
    <link rel="apple-touch-icon" sizes="60x60" href="assets/theme/img/favicon/apple-icon-60x60.png">
    <link rel="apple-touch-icon" sizes="72x72" href="assets/theme/img/favicon/apple-icon-72x72.png">
    <link rel="apple-touch-icon" sizes="76x76" href="assets/theme/img/favicon/apple-icon-76x76.png">
    <link rel="apple-touch-icon" sizes="114x114" href="assets/theme/img/favicon/apple-icon-114x114.png">
    <link rel="apple-touch-icon" sizes="120x120" href="assets/theme/img/favicon/apple-icon-120x120.png">
    <link rel="apple-touch-icon" sizes="144x144" href="assets/theme/img/favicon/apple-icon-144x144.png">
    <link rel="apple-touch-icon" sizes="152x152" href="assets/theme/img/favicon/apple-icon-152x152.png">
    <link rel="apple-touch-icon" sizes="180x180" href="assets/theme/img/favicon/apple-icon-180x180.png">
    <link rel="icon" type="image/png" sizes="192x192" href="assets/theme/img/favicon/android-icon-192x192.png">
    <link rel="icon" type="image/png" sizes="32x32" href="assets/theme/img/favicon/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="96x96" href="assets/theme/img/favicon/favicon-96x96.png">
    <link rel="icon" type="image/png" sizes="16x16" href="assets/theme/img/favicon/favicon-16x16.png">
    <link rel="icon" href="assets/theme/img/favicon/favicon.ico">

    <!-- PWA -->
    <link rel="manifest" href="manifest.json">
    <meta name="msapplication-config" content="browserconfig.xml" />
    <meta name="theme-color" content="#ffffff">
    <meta name="msapplication-navbutton-color" content="#ffffff">
    <meta name="apple-mobile-web-app-status-bar-style" content="#ffffff">
    <meta name="apple-mobile-web-app-capable" content="yes">

    <!-- Cybotranik WUI -->
    <script async src="https://unpkg.com/cybotranik-wui"></script>
    <script>wui.Theme()</script>

</head>

<body>
    <header>
        <nav is="header-nav">
            <ul is="horizontal-menu">
                <li><a href="#home">Cybotranik</a></li>
            </ul>
        </nav>
    </header>
    <main is="article-page">
        <section is="article-section" id="home">
            <header is="section-header">
                <h1>Web User Interface</h1>
            </header>
            <p is="section-description">The all-in-one, user interface kit. This interface is suitable for use in many
                programming languages.</p>
        </section>
    </main>
    <footer>
        <p>
            <small>Copyright © <time datetime="2019">2019</time> | Cybotranik WUI</small>
        </p>
    </footer>

</body>

</html>
```