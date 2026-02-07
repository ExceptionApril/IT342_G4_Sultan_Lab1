import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { fetchMe } from "../api.js";

export default function Dashboard() {
  const navigate = useNavigate();
  const [user, setUser] = useState(null);
  const [error, setError] = useState("");

  useEffect(() => {
    let mounted = true;
    fetchMe()
      .then((data) => {
        if (mounted) {
          setUser(data);
        }
      })
      .catch(() => {
        localStorage.removeItem("token");
        setError("Session expired. Please log in again.");
        navigate("/login");
      });

    return () => {
      mounted = false;
    };
  }, [navigate]);

  const onLogout = () => {
    localStorage.removeItem("token");
    navigate("/login");
  };

  return (
    <div className="page">
      <div className="card">
        <h1>Dashboard</h1>
        {error && <p className="error">{error}</p>}
        {user ? (
          <div className="profile">
            <p><strong>Username:</strong> {user.username}</p>
            <p><strong>Email:</strong> {user.email}</p>
          </div>
        ) : (
          <p>Loading...</p>
        )}
        <button onClick={onLogout}>Logout</button>
      </div>
    </div>
  );
}
