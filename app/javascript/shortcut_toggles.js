// app/javascript/shortcut_toggles.js
// 穩定版：行動用 matchMedia 判斷；click/pointerup/touchend 全綁；capture=true；支援遮罩/ESC/resize。
(function shortcutToggles() {
  var MQ = '(max-width: 991.98px)';
  function isMobile() { return window.matchMedia && window.matchMedia(MQ).matches; }

  function toggleBy(btn) {
    var html = document.documentElement;
    if (isMobile()) {
      html.classList.toggle('mobile-nav-on');
    } else {
      var k = btn.dataset.class;             // nav-function-hidden|minify|fixed
      var t = btn.dataset.target || 'html';
      var el = document.querySelector(t);
      if (el && k) el.classList.toggle(k);
    }
  }

  function bindButtons() {
    var btns = document.querySelectorAll('.dropdown-icon-menu [data-action="toggle"]');
    btns.forEach(function (btn) {
      if (btn.__saBound) return;
      var handler = function (e) { e.preventDefault(); toggleBy(btn); };
      // 多事件 + 捕獲階段，手機更穩
      btn.addEventListener('click',     handler, true);
      btn.addEventListener('pointerup', handler, true);
      btn.addEventListener('touchend',  handler, true);
      btn.__saBound = true;
    });
    console.log('[shortcut] bound', btns.length);
  }

  function bindOverlayClose() {
    var ov = document.querySelector('.page-content-overlay');
    if (ov && !ov.__saBound) {
      ov.__saBound = true;
      ov.addEventListener('click', function () {
        document.documentElement.classList.remove('mobile-nav-on');
      }, true);
    }
  }

  function bindEsc() {
    if (document.__saEsc) return;
    document.__saEsc = true;
    document.addEventListener('keydown', function (e) {
      if (e.key === 'Escape') document.documentElement.classList.remove('mobile-nav-on');
    });
  }

  function bindResizeGuard() {
    if (window.__saResize) return;
    window.__saResize = true;
    var t;
    window.addEventListener('resize', function () {
      clearTimeout(t);
      t = setTimeout(function () {
        if (!isMobile()) document.documentElement.classList.remove('mobile-nav-on');
      }, 120);
    });
  }

  function init() { bindButtons(); bindOverlayClose(); bindEsc(); bindResizeGuard(); }
  document.addEventListener('DOMContentLoaded', init);
  document.addEventListener('turbolinks:load', init);
  document.addEventListener('turbo:load',     init);
})();
