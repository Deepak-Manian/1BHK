# THE 1BHK CHRONICLES (frontend prototype)

Open `index.html` in a browser. No build step, no backend, no database.

- Needs internet for Google Fonts (Pixelify Sans, Silkscreen, DM Sans). It falls back to monospace offline.
- State (meals, weights, photos) is saved in localStorage via the `store` object near the top of the script.
  Replace `store.get` / `store.set` to move to a real backend later.
- All numbers are SAMPLE DATA, generated relative to today's date on first load.
  Clear site data in your browser to reset.
- All characters, food, appliances and scenery are original pixel sprites drawn in code
  (string maps and canvas). Nothing is copied from MILK London.

Not included: Next.js / TypeScript port, Recharts, Framer Motion.
