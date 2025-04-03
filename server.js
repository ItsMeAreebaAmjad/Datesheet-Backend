const express = require("express");
const cors = require("cors");
const mysql = require("mysql2");
require("dotenv").config();

const app = express();
const PORT = process.env.PORT || 5000;

// Middleware
app.use(cors());
app.use(express.json());

// MySQL Connection
const db = mysql.createConnection({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
});


db.connect((err) => {
  if (err) {
    console.error("Database connection failed:", err);
  } else {
    console.log("Connected to MySQL database");
  }
});

// API Route: Get all sessions
app.get("/sessions", (req, res) => {
  const sql = "SELECT * FROM session"; 
  db.query(sql, (err, results) => {
    if (err) {
      return res.status(500).json({ error: "Database error" });
    }
    res.json(results); 
  });
});

// API Route: Add a new session
app.post("/sessions", (req, res) => {
  const { session_year } = req.body;
  if (!session_year) {
    return res.status(400).json({ error: "Session year is required" });
  }

  const sql = "INSERT INTO session (session_year) VALUES (?)";
  db.query(sql, [session_year], (err, result) => {
    if (err) {
      console.error("Database Insert Error:", err);
      return res.status(500).json({ error: "Database error" });
    }
    res.status(201).json({ id: result.insertId, session_year }); 
  });
});

// API Route: Delete a session
app.delete("/sessions/:id", (req, res) => {
  const { id } = req.params;
  const sql = "DELETE FROM session WHERE id = ?";

  db.query(sql, [id], (err, result) => {
    if (err) {
      console.error("Database Delete Error:", err);
      return res.status(500).json({ error: "Database error" });
    }
    if (result.affectedRows === 0) {
      return res.status(404).json({ error: "Session not found" });
    }
    res.json({ message: "Session deleted successfully" });
  });
});


// API Route: Insert review info
app.post("/reviewInfo", (req, res) => {
  const { selectedSession, selectedDiscipline, selectedSemester, selectedExamType } = req.body;

  if (!selectedSession || !selectedDiscipline || !selectedSemester || !selectedExamType) {
    return res.status(400).json({ error: "All fields are required" });
  }

  const sql = `
    INSERT INTO reviewInfo (session_year, discipline, semester, exam_type) 
    VALUES (?, ?, ?, ?)
  `;

  db.query(sql, [selectedSession, selectedDiscipline, selectedSemester, selectedExamType], (err, result) => {
    if (err) {
      console.error("Database Insert Error:", err);
      return res.status(500).json({ error: "Database error" });
    }
    res.status(201).json({ message: "Review info added successfully", id: result.insertId });
  });
});

// API Route: Get the latest review info
app.get("/latestReviewInfo", (req, res) => {
  const sql = "SELECT * FROM reviewInfo ORDER BY id DESC LIMIT 1"; 
  db.query(sql, (err, result) => {
    if (err) {
      console.error("Database Query Error:", err);
      return res.status(500).json({ error: "Database error" });
    }
    if (result.length === 0) {
      return res.status(404).json({ error: "No review info found" });
    }
    res.json(result[0]); 
  });
});


app.get("/rooms", (req, res) => {
  const sql = "SELECT DISTINCT room_number FROM rooms";

  db.query(sql, (err, results) => {
    if (err) {
      console.error("Database Query Error:", err);
      return res.status(500).json({ error: "Database error" });
    }
    const rooms = results.map((row) => row.room_number); 
    res.json(rooms);
  });
});

// API Route: Get all invigilators
app.get("/invigilators", (req, res) => {
  const sql = "SELECT * FROM invigilator"; 
  db.query(sql, (err, results) => {
    if (err) {
      console.error("Database Query Error:", err);
      return res.status(500).json({ error: "Database error" });
    }
    res.json(results); 
  });
});


// API Route: Get subjects based on discipline and semester
app.get("/subjects", (req, res) => {
  const { discipline, semester } = req.query;

  if (!discipline || !semester) {
    return res.status(400).json({ error: "Discipline and semester are required" });
  }

  // Determine which table to query
  const tableName = discipline === "Computer Science" ? "cs_courses" : "se_courses";

  const sql = `SELECT name FROM ${tableName} WHERE semester_id = ?`;

  db.query(sql, [semester], (err, results) => {
    if (err) {
      console.error("Database Query Error:", err);
      return res.status(500).json({ error: "Database error" });
    }
    res.json(results.map(row => row.name)); 
  });
});

app.post("/save-datesheet", (req, res) => {
  console.log("Received Request Body:", req.body);

  const { examType, discipline, semester, sessionYear, examSchedule } = req.body;

  if (!examType || !discipline || !semester || !sessionYear || !examSchedule) {
    return res.status(400).json({ message: "Missing required fields in request body" });
  }

  const formatDate = (dateString) => {
    const options = { weekday: "long", year: "numeric", month: "long", day: "numeric" };
    return new Date(dateString).toLocaleDateString("en-US", options);
  };

  // ✅ Clash Detection Query (Now Includes Exam Type)
  const checkClashQuery = `
    SELECT * FROM datesheet_data 
    WHERE (room = ? OR invigilator_name = ?) 
    AND exam_date = ? 
    AND NOT (end_time <= ? OR start_time >= ?) 
    AND session = ? AND exam_type = ? 
    AND NOT (subject = ? AND discipline = ? AND semester = ?)
  `;

  // ✅ Query to Check for Duplicate Entries (Now Includes Exam Type)
  const checkDuplicateQuery = `
    SELECT * FROM datesheet_data 
    WHERE session = ? AND exam_type = ? AND exam_date = ? AND exam_day = ? 
    AND subject = ? AND invigilator_name = ? 
    AND start_time = ? AND end_time = ? AND room = ? 
    AND discipline = ? AND semester = ?
  `;

  // ✅ Insert Query (No Change Needed)
  const insertQuery = `
    INSERT INTO datesheet_data 
    (session, exam_type, exam_date, exam_day, subject, invigilator_name, start_time, end_time, room, discipline, semester) 
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
  `;

  let allRoomClashes = [];
  let allInvigilatorClashes = [];

  const clashPromises = examSchedule.map((exam) => {
    return new Promise((resolve, reject) => {
      if (!exam.date || !exam.day || !exam.subject || !exam.invigilator || !exam.room || !exam.startTime || !exam.endTime) {
        return reject({ status: 400, message: "Invalid exam schedule data" });
      }

      db.query(
        checkClashQuery,
        [exam.room, exam.invigilator, exam.date, exam.startTime, exam.endTime, sessionYear, examType, exam.subject, discipline, semester],
        (clashErr, clashResults) => {
          if (clashErr) return reject({ status: 500, message: "Error checking clashes" });

          if (clashResults.length > 0) {
            clashResults.forEach((clash) => {
              const formattedDate = formatDate(clash.exam_date);
              if (clash.room === exam.room) {
                allRoomClashes.push(
                  `Room "${clash.room}" is occupied for ${clash.discipline} ${clash.semester} on ${formattedDate} from ${clash.start_time} to ${clash.end_time}`
                );
              }
              if (clash.invigilator_name === exam.invigilator) {
                allInvigilatorClashes.push(
                  `Invigilator "${clash.invigilator_name}" is assigned to ${clash.discipline} ${clash.semester} on ${formattedDate} from ${clash.start_time} to ${clash.end_time}`
                );
              }
            });
          }
          resolve();
        }
      );
    });
  });

  Promise.all(clashPromises)
    .then(() => {
      if (allRoomClashes.length > 0 || allInvigilatorClashes.length > 0) {
        return Promise.reject({
          status: 400,
          message: "Clash detected",
          roomClashes: allRoomClashes,
          invigilatorClashes: allInvigilatorClashes,
        });
      }
      return Promise.resolve();
    })
    .then(() => {
      const duplicateCheckPromises = examSchedule.map((exam) => {
        return new Promise((resolve, reject) => {
          db.query(
            checkDuplicateQuery,
            [sessionYear, examType, exam.date, exam.day, exam.subject, exam.invigilator, exam.startTime, exam.endTime, exam.room, discipline, semester],
            (err, results) => {
              if (err) return reject({ status: 500, message: "Error checking for duplicate data" });

              if (results.length > 0) {
                resolve("Duplicate");
              } else {
                resolve("New");
              }
            }
          );
        });
      });

      return Promise.all(duplicateCheckPromises);
    })
    .then((duplicateResults) => {
      const filteredExams = examSchedule.filter((_, index) => duplicateResults[index] === "New");

      if (filteredExams.length === 0) {
        return res.status(200).json({ message: "No Clash Detected ✅ (Already Saved)" });
      }

      const insertPromises = filteredExams.map((exam) => {
        return new Promise((resolve, reject) => {
          db.query(
            insertQuery,
            [sessionYear, examType, exam.date, exam.day, exam.subject, exam.invigilator, exam.startTime, exam.endTime, exam.room, discipline, semester],
            (err, result) => {
              if (err) return reject({ status: 500, message: "Failed to save datesheet" });
              resolve(result);
            }
          );
        });
      });

      return Promise.all(insertPromises);
    })
    .then(() => {
      return res.status(200).json({ message: "Datesheet saved successfully" });
    })
    .catch((error) => {
      if (!res.headersSent) {
        res.status(error.status || 500).json({
          message: error.message,
          roomClashes: allRoomClashes,
          invigilatorClashes: allInvigilatorClashes,
        });
      }
    });
});





// Start server
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
