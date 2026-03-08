# 10-Minute Smoke Test Checklist

1. Launch + persistence
- Cold launch app.
- Force-close app.
- Reopen and confirm existing data is still present.

2. Coffee CRUD
- Create coffee with: name, roaster, country, region, varietal, process, altitude text, roast date, tasting notes, tags.
- Edit coffee (change roaster + process only).
- Confirm "Recently updated" sort did not move due to metadata-only edit.
- Delete a test coffee (if disposable).

3. Coffee list UI consistency
- Verify chips show only: `Region, Country`, `Varietal`, `Process`.
- Verify altitude appears as plain text.
- Verify tasting notes appear above tags and are larger text.
- Verify sort label says `Origin` (not Country).

4. Entry creation flow
- Open a coffee -> tap `Entry` FAB.
- Confirm choices: `Blank entry` and `From template`.
- Create a blank entry with no steps, save, reopen edit (no crash).
- Confirm fields keep focus while typing.

5. Recipe steps
- Add 3+ steps, drag reorder, edit one, delete one, save.
- In detail screen, verify timeline renders and end time tile appears.
- Confirm step order persisted after reopen.

6. Template flow
- From entry menu, create template from entry.
- Open Settings -> Recipe templates.
- Open template, edit name/step, save.
- Create a new entry from that template; verify method/dose/water/steps prefilled.

7. Entry list behaviors
- Star/unstar entry and verify starred-first default sort.
- Toggle method filter and sort options from top controls.
- Confirm metadata header format matches home style.

8. Formatting checks
- Temperature shows `° C`/`° F`.
- Weights show ` g` with space.
- Time shows `mm:ss`.
- Grinder shows `GrindSize (Grinder)`.
- Blank fields are suppressed in detail.

9. Settings
- Toggle dark mode and restart app; verify it persists.
- Toggle metric/imperial and verify entry list/detail values update.

10. Backup sanity
- Export JSON.
- Confirm file created and non-empty.
- (Optional) Import into fresh install/profile and spot-check one coffee + one entry.

If any step fails, capture: screen, exact action sequence, and error text.
