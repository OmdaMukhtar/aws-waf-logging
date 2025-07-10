<?php

header('Content-Type: text/html');

function log_request() {
    $ip = $_SERVER['REMOTE_ADDR'];
    $method = $_SERVER['REQUEST_METHOD'];
    $uri = $_SERVER['REQUEST_URI'];
    $query = $_SERVER['QUERY_STRING'];
    $user_agent = $_SERVER['HTTP_USER_AGENT'] ?? 'N/A';
    $log_line = date('c') . " | $ip | $method | $uri?$query | $user_agent\n";
    file_put_contents('/var/www/html/access.log', $log_line, FILE_APPEND);
}

log_request();

// simulate dynamic output
echo "<h1>Simple PHP Media App</h1>";
echo "<p>Welcome! Uploads and image previews coming soon.</p>";

// SQL Injection test input (should be blocked)
if (isset($_GET['search'])) {
    $search = $_GET['search'];
    echo "<p>Search results for: <strong>" . htmlspecialchars($search) . "</strong></p>";
}

// Path traversal simulation (should be blocked)
if (isset($_GET['file'])) {
    $file = $_GET['file'];
    echo "<p>Trying to open file: <strong>" . htmlspecialchars($file) . "</strong></p>";
}

// XSS test input (should be blocked)
if (isset($_GET['comment'])) {
    $comment = $_GET['comment'];
    echo "<p>Comment: <strong>" . htmlspecialchars($comment) . "</strong></p>";
}
?>
