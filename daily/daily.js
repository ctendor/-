function addSchedule() {
  const date = document.getElementById("schedule-date").value;
  const startTime = document.getElementById("start-time").value;
  const endTime = document.getElementById("end-time").value;
  const details = document.getElementById("schedule-details").value;
  if (!date || !startTime || !endTime || !details) {
    alert("모든 정보를 입력하세요.");
    return;
  }
  alert(`일정 추가됨: ${date}, ${startTime} ~ ${endTime}, ${details}`);
}

function mergeTeamSchedules() {
  alert("팀원의 일정이 팀장 일정에 합쳐졌습니다.");
}

document.addEventListener("DOMContentLoaded", () => {
  updateCalendar();
});
