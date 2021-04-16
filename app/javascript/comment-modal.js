if (location.pathname.match('trainings')){
  document.addEventListener('DOMContentLoaded', () => {
    // 関数宣言
    const joinTraining = document.getElementById('join-training-path');
    const commentModal = document.getElementById('comment-modal-window');
    const closeBtn = document.getElementById('comment-cancel-btn');
    joinTraining.addEventListener('click', () => {
      commentModal.setAttribute('style', 'display: block');
    });
    closeBtn.addEventListener('click', () => {
      commentModal.removeAttribute('style', 'display: block');
    });
  });
}