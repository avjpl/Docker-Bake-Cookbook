import express from 'express';

const app = express();

app.get('/', (req, res) => {
  res.json({
    service: 'backend',
    status: 'running',
    timestamp: new Date().toISOString(),
  });
});

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
  console.log(`Backend server listening on port ${PORT}`);
});
