import express from 'express';

const app = express();

app.get('/', (req, res) => {
  res.json({
    message: 'Matrix Build Example',
    nodeVersion: process.version,
    timestamp: new Date().toISOString()
  });
});

const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Server running on Node ${process.version}`);
  console.log(`Listening on port ${PORT}`);
});
