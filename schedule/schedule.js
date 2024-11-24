function calculateDayOfWeek(year, month, day) {
  const baseYear = 2000;
  const baseMonth = 1;
  const baseDay = 1;
  const baseWeekday = 6;
  const date1 = new Date(baseYear, baseMonth - 1, baseDay);
  const date2 = new Date(year, month - 1, day);
  const diffDays = Math.floor((date2 - date1) / (1000 * 60 * 60 * 24));
  return (baseWeekday + (diffDays % 7) + 7) % 7;
}

function renderCalendar(year, month) {
  const calendarBody = document.getElementById("calendar-body");
  calendarBody.innerHTML = "";
  const totalDays = new Date(year, month, 0).getDate();
  const firstDayOfWeek = calculateDayOfWeek(year, month, 1);
  let row = document.createElement("tr");
  for (let i = 0; i < firstDayOfWeek; i++) {
    const emptyCell = document.createElement("td");
    row.appendChild(emptyCell);
  }
  for (let day = 1; day <= totalDays; day++) {
    const cell = document.createElement("td");
    cell.textContent = day;
    cell.onclick = () => alert(`${year}-${month}-${day}`);
    row.appendChild(cell);
    if ((day + firstDayOfWeek) % 7 === 0) {
      calendarBody.appendChild(row);
      row = document.createElement("tr");
    }
  }
  if (row.children.length > 0) {
    calendarBody.appendChild(row);
  }
}

let currentYear = 2024;
let currentMonth = 12;

document.addEventListener("DOMContentLoaded", () => {
  renderCalendar(currentYear, currentMonth);
});

function prevMonth() {
  if (currentMonth === 1) {
    currentMonth = 12;
    currentYear -= 1;
  } else {
    currentMonth -= 1;
  }
  updateCalendar();
}

function nextMonth() {
  if (currentMonth === 12) {
    currentMonth = 1;
    currentYear += 1;
  } else {
    currentMonth += 1;
  }
  updateCalendar();
}

function updateCalendar() {
  document.getElementById("calendar-year").textContent = currentYear;
  document.getElementById("calendar-month").textContent = currentMonth;
  renderCalendar(currentYear, currentMonth);
}

function logout() {
  alert("로그아웃 되었습니다.");
  window.location.href = "../login/index.html";
}
