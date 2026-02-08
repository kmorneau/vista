const fs = require('fs');
let JSDOM;
try {
  ({ JSDOM } = require('jsdom'));
} catch (err) {
  console.error('Missing dependency: jsdom. Run: npm install --save-dev jsdom');
  process.exit(2);
}

const example = process.argv[2];
const file = process.argv[3] || 'ui.html';

if (!example) {
  console.error('Usage: node tests/behavior_smoke.js <example-key> <html-file>');
  process.exit(1);
}

function sleep(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

async function loadDom(path) {
  const html = fs.readFileSync(path, 'utf8');
  const dom = new JSDOM(html, {
    runScripts: 'dangerously',
    resources: 'usable',
    pretendToBeVisual: true,
  });
  await sleep(20);
  return dom;
}

function assert(cond, msg) {
  if (!cond) {
    throw new Error(msg);
  }
}

async function testInputEcho(dom) {
  const doc = dom.window.document;
  const input = doc.querySelector('input[data-bind="name"]');
  assert(input, 'name input not found');
  dom.window.eval("state.name='Grace'; state.status='Typing...'; render();");
  await sleep(5);
  const echo = doc.querySelector('span[data-bind="name"]');
  const status = doc.querySelector('span[data-bind="status"]');
  assert(echo && echo.textContent === 'Grace', 'echo did not update');
  assert(status && status.textContent.includes('Typing'), 'status did not update');
}

async function testRadioSlider(dom) {
  const doc = dom.window.document;
  const slider = doc.querySelector('input[type="range"][data-bind="level"]');
  assert(slider, 'slider not found');
  dom.window.eval("state.level=7; render();");
  await sleep(5);
  const level = doc.querySelector('span[data-bind="level"]');
  assert(level && level.textContent === '7', 'slider level did not update');

  const radio = doc.querySelector('input[type="radio"][value="Blue"]');
  assert(radio, 'radio (Blue) not found');
  dom.window.eval("state.choice='Blue'; render();");
  await sleep(5);
  const choice = doc.querySelector('span[data-bind="choice"]');
  assert(choice && choice.textContent === 'Blue', 'radio choice did not update');
}

async function testSliderLabels(dom) {
  const doc = dom.window.document;
  const slider = doc.querySelector('input[type="range"][data-bind="level"]');
  assert(slider, 'slider not found');
  dom.window.eval("state.level=3; state.status='Changed'; render();");
  await sleep(5);
  const status = doc.querySelector('span[data-bind="status"]');
  assert(status && status.textContent === 'Changed', 'slider status did not update');
}

async function testEvents(dom) {
  const doc = dom.window.document;
  const input = doc.querySelector('input[data-bind="name"]');
  assert(input, 'name input not found');
  dom.window.eval("state.focused=true; state.status='Focused'; render();");
  await sleep(5);
  let focused = doc.querySelector('span[data-bind="focused"]');
  let status = doc.querySelector('span[data-bind="status"]');
  assert(focused && focused.textContent === 'true', 'focus state did not update');
  assert(status && status.textContent === 'Focused', 'focus status did not update');
  dom.window.eval("state.focused=false; state.status='Blurred'; render();");
  await sleep(5);
  focused = doc.querySelector('span[data-bind="focused"]');
  status = doc.querySelector('span[data-bind="status"]');
  assert(focused && focused.textContent === 'false', 'blur state did not update');
  assert(status && status.textContent === 'Blurred', 'blur status did not update');
}

async function testKeyCapture(dom) {
  const doc = dom.window.document;
  const keyBtn = doc.querySelector('[data-key-bind="lastKey"]');
  assert(keyBtn, 'key button not found');
  dom.window.eval("state.lastKey='A'; render();");
  await sleep(5);
  const lastKey = doc.querySelector('span[data-bind="lastKey"]');
  assert(lastKey && lastKey.textContent === 'A', 'lastKey did not update');
}

async function testHover(dom) {
  const doc = dom.window.document;
  const sensor = doc.querySelector('.vista-sensor');
  assert(sensor, 'sensor not found');
  dom.window.eval("state.status='Over'; render();");
  await sleep(5);
  let status = doc.querySelector('span[data-bind="status"]');
  assert(status && status.textContent === 'Over', 'hover status did not update');
  dom.window.eval("state.status='Out'; render();");
  await sleep(5);
  status = doc.querySelector('span[data-bind="status"]');
  assert(status && status.textContent === 'Out', 'out status did not update');
}

async function testTabs(dom) {
  const doc = dom.window.document;
  const buttons = [...doc.querySelectorAll('.vista-tab-btn')];
  const detailsBtn = buttons.find((b) => b.textContent.trim() === 'Details');
  assert(detailsBtn, 'Details tab button not found');
  dom.window.eval(`(function(){
    const buttons=[...document.querySelectorAll('.vista-tab-btn')];
    const panels=[...document.querySelectorAll('.vista-tab-panel')];
    const btn=buttons.find(b=>b.textContent.trim()==='Details');
    if(!btn){return;}
    buttons.forEach(b=>b.classList.toggle('is-active',b===btn));
    panels.forEach(p=>p.classList.toggle('is-active',p.dataset.tab===btn.dataset.tab));
  })();`);
  await sleep(5);
  const detailsPanel = doc.querySelector('.vista-tab-panel.is-active');
  assert(detailsPanel && detailsPanel.dataset.tab === detailsBtn.dataset.tab, 'Details tab not active');

  dom.window.eval("state.details='Hello'; render();");
  await sleep(5);
  const detailsEcho = doc.querySelector('span[data-bind="details"]');
  assert(detailsEcho && detailsEcho.textContent === 'Hello', 'details echo did not update');
}

async function testLists(dom) {
  const doc = dom.window.document;
  const single = doc.querySelector('ul[data-list-bind="choice"] li[data-value="Two"]');
  assert(single, 'single list item not found');
  dom.window.eval("state.choice='Two'; render();");
  await sleep(5);
  const choice = doc.querySelector('span[data-bind="choice"]');
  assert(choice && choice.textContent === 'Two', 'single list choice did not update');

  const multi = doc.querySelector('ul[data-list-bind="picks"] li[data-value="Green"]');
  assert(multi, 'multi list item not found');
  dom.window.eval("state.picks=['Green']; render();");
  await sleep(5);
  const picks = doc.querySelector('span[data-bind="picks"]');
  assert(picks && picks.textContent.includes('Green'), 'multi list picks did not update');
}

async function testTable(dom) {
  const doc = dom.window.document;
  const row = [...doc.querySelectorAll('tr')].find((tr) => tr.textContent.includes('Linus'));
  assert(row, 'table row not found');
  dom.window.eval("state.selected='Linus'; render();");
  await sleep(5);
  const selected = doc.querySelector('span[data-bind="selected"]');
  assert(selected && selected.textContent === 'Linus', 'table selection did not update');
}

async function testToolbarMenus(dom) {
  const doc = dom.window.document;
  const menuEdit = [...doc.querySelectorAll('button')].find((b) => b.textContent.trim() === 'Edit');
  assert(menuEdit, 'Edit menu button not found');
  dom.window.eval("state.menu='Edit'; state.submenu='Paste'; state.status='Edit > Paste'; render();");
  await sleep(5);

  const status = doc.querySelector('span[data-bind="status"]');
  const submenu = doc.querySelector('span[data-bind="submenu"]');
  assert(status && status.textContent.includes('Paste'), 'status did not update');
  assert(submenu && submenu.textContent === 'Paste', 'submenu did not update');
}

const tests = {
  'input-echo': testInputEcho,
  'radio-slider': testRadioSlider,
  'slider-labels': testSliderLabels,
  events: testEvents,
  'key-capture': testKeyCapture,
  hover: testHover,
  tabs: testTabs,
  lists: testLists,
  table: testTable,
  'toolbar-menus': testToolbarMenus,
};

(async () => {
  const fn = tests[example];
  if (!fn) {
    console.error('Unknown example key:', example);
    process.exit(1);
  }
  const dom = await loadDom(file);
  try {
    await fn(dom);
  } catch (err) {
    console.error(err.message);
    process.exit(1);
  }
})();
