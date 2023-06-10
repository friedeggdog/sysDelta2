<style>
    body {
        background-color: #1e2124;
        color: rgb(187, 187, 187);
    }

    .maintable {
        margin: auto;
        width: 45%;
        background-color: #36393e;
        border: 2px #424549 solid;
        border-radius: 5px;
    }

    th, td {
        border: 1px #424549 solid;
    }

    a{
        margin-left: 47%;
        width: 5%;
    }

    button {
        border-radius: 3px;
        background-color: #7289da;
        width: 5%;
        height: 30px;
        padding: 10px;
        border:none;
        color: rgb(187, 187, 187) ;
        font-size: 15px;
        font-weight: bold;
        line-height: 6px;
        box-sizing: border-box
    }

    h1 {
       color: rgb(187, 187, 187);
       text-align: center;
    }

    
</style>

<?php
$host    = "172.25.0.1";
$user    = "root";
$pass    = "1234";
$db_name = "students";

$connection = mysqli_connect($host, $user, $pass, $db_name);

$username = $_POST['user'];
$password = $_POST['pass'];


$username = trim($username);
$password = trim($password);
$username = stripcslashes($username);
$password = stripcslashes($password);
$username = htmlspecialchars($username);
$username = htmlspecialchars($username);

$sql = "select * from uandp where Username = '{$username}' and Pass = '{$password}'";
$query = mysqli_query($connection, $sql);
$row = mysqli_fetch_array($query, MYSQLI_ASSOC);
$no = mysqli_num_rows($query);


if($no == 1){
    if($username == "HAD"){ 
        $sql = "SELECT * FROM Details";
        $query = mysqli_query($connection, $sql);
        $colname = array();
    }
    else{ 
        $sql = "SELECT * FROM Details where Name='{$username}' or Hostel='{$username}'";
        $query = mysqli_query($connection, $sql);
        $colname = array();
    }
    echo '<table class="maintable">
            <tr class="heading">';
    while ($prop = mysqli_fetch_field($query)) {#creates an object with column details and iterates over 
        echo '<td>' . $prop->name . '</td>';#display the name property of the column
        $colname[] = $prop->name;#add this name to colname
    }
    echo '</tr>';

    while ($row = mysqli_fetch_array($query)) {#iterates over every row in the data
        echo "<tr>";
        foreach ($colname as $head) {#all property consists of the headings of the columns
            echo '<td>' . $row[$head] . '</td>';#for each heading display the element in the row
        }
        echo '</tr>';
    }
    echo "</table>";
}
else{
    echo "<h1> WRONG USERNAME OR PASSWORD</h1>";
}
?>
<a id="btn" href="http://obser.er/">
    <button>BACK</button>
</a>