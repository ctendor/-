var currentYear;
var currentMonth;

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
  if (!calendarBody) {
    console.error("Element with id 'calendar-body' not found.");
    return;
  }

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
    cell.onclick = () => {
      location.href = `../daily/dailyPage.jsp?date=${year}-${String(
        month
      ).padStart(2, "0")}-${String(day).padStart(2, "0")}`;
    };
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

function highlightSelectedMonth() {
  const monthElements = document.querySelectorAll(".month-pagination span");
  monthElements.forEach((element, index) => {
    if (index + 1 === currentMonth) {
      element.classList.add("selected");
    } else {
      element.classList.remove("selected");
    }
  });
}

function setCurrentDate() {
  const today = new Date();
  currentYear = today.getFullYear();
  currentMonth = today.getMonth() + 1;
}

function prevYear() {
  currentYear -= 1;
  updateCalendar();
}

function nextYear() {
  currentYear += 1;
  updateCalendar();
}

function selectMonth(month) {
  currentMonth = month;
  updateCalendar();
}

function updateCalendar() {
  document.getElementById("calendar-year").textContent = currentYear;
  renderCalendar(currentYear, currentMonth);
  highlightSelectedMonth();
}

function logout() {
  alert("로그아웃 되었습니다.");
  window.location.href = "../login/loginPage.jsp";
}

function mergeTeamSchedules() {
  alert("팀원 일정 합치기 기능이 준비 중입니다.");
}

document.addEventListener("DOMContentLoaded", () => {
  setCurrentDate();
  document.getElementById("calendar-year").textContent = currentYear;
  renderCalendar(currentYear, currentMonth);
  highlightSelectedMonth();
});
