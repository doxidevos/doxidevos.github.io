document.addEventListener('DOMContentLoaded', function () {
  // Toggle fields based on submission type
  const submissionTypeRadios = document.getElementsByName('vm_submission_type');
  const liveAccessFields = document.getElementById('live-access-fields');
  const fileUploadField = document.getElementById('file-upload-field');

  function toggleSubmissionFields() {
    let selectedValue;
    submissionTypeRadios.forEach(radio => {
      if (radio.checked) {
        selectedValue = radio.value;
      }
    });
    if (selectedValue === 'live') {
      liveAccessFields.style.display = 'block';
      // Make live access info required
      document.getElementById('access_info').setAttribute('required', 'required');
      fileUploadField.style.display = 'none';
      document.getElementById('vm_file').removeAttribute('required');
    } else {
      liveAccessFields.style.display = 'none';
      document.getElementById('access_info').removeAttribute('required');
      fileUploadField.style.display = 'block';
      document.getElementById('vm_file').setAttribute('required', 'required');
    }
  }

  submissionTypeRadios.forEach(radio => {
    radio.addEventListener('change', toggleSubmissionFields);
  });
  toggleSubmissionFields(); // initial toggle

  // Load VM list (simulate fetching from data/vms.json)
  fetch('data/vms.json')
    .then(response => response.json())
    .then(data => {
      const vmListDiv = document.getElementById('vm-list');
      if (vmListDiv) {
        if (data.length === 0) {
          vmListDiv.innerHTML = "<p>No VMs submitted yet.</p>";
        } else {
          const list = document.createElement('ul');
          data.forEach(vm => {
            const li = document.createElement('li');
            let accessDetails = vm.submission_type === "live" ? `Live Access: ${vm.access_info}` : `File: ${vm.file_path}`;
            li.innerHTML = `<strong>${vm.vm_name}</strong> (${vm.vm_type}, ${vm.submission_type}) - ${accessDetails} <br><em>${vm.vm_description}</em>`;
            list.appendChild(li);
          });
          vmListDiv.appendChild(list);
        }
      }
    })
    .catch(err => console.error("Error loading VM list:", err));

  // Handle form submission if on submit.html page
  const form = document.getElementById('vm-submission-form');
  if (form) {
    form.addEventListener('submit', function (e) {
      e.preventDefault();
      // For this prototype, simulate a successful submission.
      document.getElementById('submission-message').innerHTML = "<p>Your VM has been submitted! (This is a prototype simulation; in a real app, the data would be processed on the server.)</p>";
      form.reset();
      toggleSubmissionFields();
    });
  }
});
