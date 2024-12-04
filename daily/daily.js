function isValidTimeFormat(time) {
  const timeRegex = /^([01]?[0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9]$/;
  return timeRegex.test(time);
}

function validateTimeInput(inputElement) {
  const value = inputElement.value;
  if (!isValidTimeFormat(value)) {
    alert("시간을 HH:mm:ss 형식으로 입력해주세요.");
    inputElement.value = ""; // 입력칸 비우기
  }
}

function renderSchedules(schedules) {
  const scheduleContainer = document.getElementById("schedule-items");
  scheduleContainer.innerHTML = "";

  if (!schedules || schedules.length === 0) {
    const noScheduleMessage = document.createElement("p");
    noScheduleMessage.textContent = "일정이 없습니다.";
    scheduleContainer.appendChild(noScheduleMessage);
    return;
  }

  schedules.forEach((schedule) => {
    const scheduleDiv = document.createElement("div");
    scheduleDiv.classList.add("schedule-item");

    const scheduleDetails = document.createElement("span");
    scheduleDetails.textContent = `시간: ${schedule.startTime} - ${schedule.endTime} ${schedule.details}`;
    scheduleDiv.appendChild(scheduleDetails);

    const actionDiv = document.createElement("div");

    const editButton = document.createElement("button");
    editButton.classList.add("edit-btn");
    editButton.textContent = "수정";
    editButton.addEventListener("click", () => editSchedule(schedule.id));
    actionDiv.appendChild(editButton);

    const deleteButton = document.createElement("button");
    deleteButton.textContent = "삭제";
    deleteButton.addEventListener("click", () => deleteSchedule(schedule.id));
    actionDiv.appendChild(deleteButton);

    scheduleDiv.appendChild(actionDiv);
    scheduleContainer.appendChild(scheduleDiv);
  });
}

function addSchedule() {
  const startTime = document.getElementById("start-time").value;
  const endTime = document.getElementById("end-time").value;
  const details = document.getElementById("details").value;

  if (!isValidTimeFormat(startTime)) {
    alert("시작 시간을 HH:mm:ss 형식으로 입력해주세요.");
    document.getElementById("start-time").value = "";
    return;
  }

  if (!isValidTimeFormat(endTime)) {
    alert("종료 시간을 HH:mm:ss 형식으로 입력해주세요.");
    document.getElementById("end-time").value = "";
    return;
  }

  if (!startTime || !endTime || !details) {
    alert("모든 필드를 입력해주세요.");
    return;
  }

  if (startTime >= endTime) {
    alert("시작시간이 종료시간보다 이전이어야 합니다.");
    return;
  }

  const requestData = {
    type: "add",
    start_time: startTime,
    end_time: endTime,
    details: details,
  };

  fetch("dailyAction.jsp", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(requestData),
  })
    .then((response) => response.json())
    .then((data) => {
      if (data.success) {
        alert("일정이 생성되었습니다.");
        renderSchedules(data.schedules); // 갱신된 일정 렌더링
      } else {
        alert("일정 추가에 실패했습니다.");
      }
    })
    .catch((error) => {
      console.error("Error:", error);
      alert("서버 오류가 발생했습니다.");
    });
}

function deleteSchedule(id) {
  const confirmDelete = confirm("일정을 삭제하시겠습니까?");
  if (!confirmDelete) return;

  fetch(`dailyAction.jsp?type=delete&id=${id}`, { method: "POST" })
    .then((response) => response.json())
    .then((data) => {
      if (data.success) {
        alert("일정이 삭제되었습니다.");
        renderSchedules(data.schedules); // 갱신된 일정 렌더링
      } else {
        alert("일정 삭제에 실패했습니다.");
      }
    })
    .catch((error) => {
      console.error("Error:", error);
      alert("서버 오류가 발생했습니다.");
    });
}

function editSchedule(id) {
  const newStartTime = prompt("새로운 시작시간 (HH:mm:ss)");
  const newEndTime = prompt("새로운 종료시간 (HH:mm:ss)");
  const newDetails = prompt("새로운 일정 상세");

  if (!newStartTime || !newEndTime || !newDetails) {
    alert("모든 필드를 입력해주세요.");
    return;
  }

  if (!isValidTimeFormat(newStartTime)) {
    alert("시작 시간을 HH:mm:ss 형식으로 입력해주세요.");
    return;
  }

  if (!isValidTimeFormat(newEndTime)) {
    alert("종료 시간을 HH:mm:ss 형식으로 입력해주세요.");
    return;
  }

  if (newStartTime >= newEndTime) {
    alert("시작시간이 종료시간보다 이전이어야 합니다.");
    return;
  }

  const requestData = {
    type: "edit",
    id: id,
    start_time: newStartTime,
    end_time: newEndTime,
    details: newDetails,
  };

  fetch("dailyAction.jsp", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(requestData),
  })
    .then((response) => response.json())
    .then((data) => {
      if (data.success) {
        alert("일정이 수정되었습니다.");
        renderSchedules(data.schedules); // 갱신된 일정 렌더링
      } else {
        alert("일정 수정에 실패했습니다.");
      }
    })
    .catch((error) => {
      console.error("Error:", error);
      alert("서버 오류가 발생했습니다.");
    });
}

document.addEventListener("DOMContentLoaded", () => {
  fetch("dailyAction.jsp?type=fetch")
    .then((response) => response.json())
    .then((data) => renderSchedules(data.schedules))
    .catch((error) => {
      console.error("Error fetching schedules:", error);
      alert("서버에서 데이터를 불러오는 데 실패했습니다.");
    });

  // 시간 입력 필드 유효성 검사 이벤트 추가
  document.getElementById("start-time").addEventListener("change", function () {
    validateTimeInput(this);
  });
  document.getElementById("end-time").addEventListener("change", function () {
    validateTimeInput(this);
  });
});
