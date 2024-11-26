const schedules = [];

function renderSchedules() {
  const scheduleContainer = document.getElementById("schedule-items");
  scheduleContainer.innerHTML = "";

  if (schedules.length === 0) {
    scheduleContainer.innerHTML = "<p>일정이 없습니다.</p>";
    return;
  }

  schedules.sort((a, b) => a.startTime.localeCompare(b.startTime));

  schedules.forEach((schedule, index) => {
    const scheduleDiv = document.createElement("div");
    scheduleDiv.classList.add("schedule-item");
    scheduleDiv.innerHTML = `
      <span>시간: ${schedule.startTime} - ${schedule.endTime} ${schedule.details}</span>
      <div>
        <button class="edit-btn" onclick="editSchedule(${index})">수정</button>
        <button onclick="deleteSchedule(${index})">삭제</button>
      </div>
    `;
    scheduleContainer.appendChild(scheduleDiv);
  });
}

function addSchedule() {
  const startTime = document.getElementById("start-time").value;
  const endTime = document.getElementById("end-time").value;
  const details = document.getElementById("details").value;

  if (!startTime || !endTime || !details) {
    alert("모든 필드를 입력해주세요.");
    return;
  }

  if (startTime >= endTime) {
    alert("시작시간이 종료시간보다 이전이어야 합니다.");
    return;
  }

  schedules.push({ startTime, endTime, details });
  renderSchedules();
  alert("일정이 생성되었습니다.");
}

function deleteSchedule(index) {
  const confirmDelete = confirm("일정을 삭제하시겠습니까?");
  if (confirmDelete) {
    schedules.splice(index, 1);
    renderSchedules();
  }
}

function editSchedule(index) {
  const schedule = schedules[index];
  const newStartTime = prompt("새로운 시작시간 (HH:MM)", schedule.startTime);
  const newEndTime = prompt("새로운 종료시간 (HH:MM)", schedule.endTime);
  const newDetails = prompt("새로운 일정 상세", schedule.details);

  if (!newStartTime || !newEndTime || !newDetails) {
    alert("모든 필드를 입력해주세요.");
    return;
  }

  if (newStartTime >= newEndTime) {
    alert("시작시간이 종료시간보다 이전이어야 합니다.");
    return;
  }

  schedules[index] = {
    startTime: newStartTime,
    endTime: newEndTime,
    details: newDetails,
  };
  renderSchedules();
  alert("일정이 수정되었습니다.");
}

function logout() {
  alert("로그아웃 되었습니다.");
  window.location.href = "../login/index.html";
}

document.addEventListener("DOMContentLoaded", () => {
  renderSchedules();
});
