---
draft: true
title: "Issues - Bug"
date: "2025-08-03"
tags: 
---

1. Pages Route on Sidebar:
	1. Evidence Page: 
		1. Todo:
			1. **Added function to call metric, card and visualization. - depending on task 4**
		2. Done:
			1. Added EditorJS into the mix.
			2. Added Evidence Node, and ensure align with Editor.
			3. Added Width function
			4. Added open a new page (relate to the content) - user should be able to open the evidence content into a whole new page.
			5. Added "place of evidence" - evidence should be contextual, whether evidence was created in relationshipSheet, we should the evidence context (relate to this relationship), if it's created in CardSettingSheet, we should be able to see (relate to this card or pegged into this card.). Some evidence can be created on canvas - standalone. This will be pegged as "General", user would can click a button at this data, to go to the canvas and see where the evidence live. (Will anchor to the evidence node if it's general, if there's pegged card or relationship, will then anchor to the relationship/card.)
			6. Added comment below editor (just like evidence node, user can comment about the content inside the editor, this comment can be seen visually in editor itself.)
	2. **Sources Page: Source setup per canvas.**
2. Canvas
	1. To-do:
		1. Ensuring we can use tools properly
	2. Done:
		1. Infinite scroll
		2. Layer Toggle: (gray out data, gray out category, etc) - later
		3. Excalidraw integration (Excalidraw integration) ![[Pasted image 20250806223132.png]]
		4. Top Toolbar
			1. Selector Tool
				1. Move
				2. Hand Tool
				3. Scale
	3. Nodes / Operation / Function
		1. To-do:
			1. Ensure data source is proper
			2. Operator can be use
			3. side panel etc
		2. Done:
			1. Nodes:
				1. Source/Data Node: v0 CHECK - can do SQL / Python transformation - Google Sheet / Motherduck 
				2. Visualization Node
			2. Operator Node:
				1. Operation (Date Picker, Boolean, etc ) - This operation can be "controlled" on the left tool function. - All relationship go through the operation controlled the same.
				2. Formula
				3. Boolean (Switch)
			3. Control System
				1. To-do:
				2. Done:
				3. Simulate
				4. Date Picker All
				5. Toggle
				6. Formula
				7. If statement
				8. Operator
				9. Dynamic Text
3. Grouping
	1. To-do:
		1.  Grouping to Dashboard - still issue
		2. Grouping to Slides
		3. Close Gouping (for works, like Canvas inside Canvas)
	2. Done:
4.  Organization and User Management:
	1. To-do:
		1.  We need to create organization function and personal function.
		2. Login as user with no organization (personal) 
		3. but then prompted to create organization (all must have organization) if wanted to share
	2. Done:
		1. WASM, etc
		2. WebSocket
		3. Supabase Realtime
5. Collaboration Function:
	1. To-do:
		1. Add button to the header, on left side button, after the title and description will be a button for collaboration:
			1. A button at the canvas header, to turn to a temporary full page (like a dialog), that opened up comments in threads threads, notification system and changelog. 
			2. Main thread comment on different page but can be navigate through comment on canvas
				1. Alerts systems
				2. notification system
			3. Changelog (group by daily) - system needed to be implement, we need to create a system to ensure changes can be track and attribute to changelog, grouped by daily.
			4. Make the dialog wider and bigger. There's a lot of ways user can use comment system:
				1. We have inside the evidence editor, we have inside the node sheet, we have on canvas standalone comment. These are places user can create comment, question is how can we manage this at the dialog?
		2. Button at the most right is for sharing: Growth machine here, user can share and public can view the canvas, but once they click they need to sign up.
			1. Share function ![[Pasted image 20250806225911.png]]
			2. Build grouping and framing to allow (Frame to present/slide.)
6. UI/Accessibility:
	1. To-do:
		1. Use skeletons shadcn component for better UI/UX.
		2. 
		3. Bottom Bar Refactor
	2. Done:
		1. Mini Toolbar Refactor
		2. Hold Space for Hold/Select
	3. 
7. Templates / Blueprint / System
8. AI suggestions etc
9. Once everything implemented properly, let's refactor Filter and Search function.


Important Task

---

Debug state only for Development environment.

---


Issues with our edges

We have three type of edge:
1. Dynamic Edges
2. Operative Edges
3. Simple Edge

Dynamic Edges are meant for nodes relationship that have properties, like causal, deterministic, composite and probabilistic. 

While operative edges is simply to pass data, and ensuring can use Operative Nodes in between (like Zapier) 

Any operative edges will have a blurred out button (if far) next to it to run test/run execute.

Simple edge is simply an edge to peg or connect something to a node. For an example, evidence to a node, this can't use Dynamic Edges and even Operative Edges. Same goes with Metric Card of Core/Value, Work/Action, Ideas/Hypothesis and Metadata. 

These type of nodes only yses simple edge (which why we need to refactor metricCard to separate it from Data/Metric Card)


Task List from this PRD:
1. Refactor Metric Card to separate it from Data/Metric Card
2. 

---


We're still unable to drag evidence around.




- Sync the view on toggle: when entering drawing, set Excalidraw scroll/zoom to match the current React Flow viewport; when exiting, optionally restore RF behavior. This prevents a jarring jump.

- Freeze graph interactions while drawing: disable RF pan/zoom/selection when the whiteboard is active (your pointer-events already blocks most input; also disable wheel zoom to avoid accidental RF transforms).

- Persist and restore drawings per canvas: debounce onChange from Excalidraw and save scene JSON keyed by canvas ID; load it in initialData.

- UX clarity: gray out RF shape tools during drawing; show a tiny “Drawing mode” badge; a keyboard toggle (e.g., D) helps.

- Theming and assets: ensure @excalidraw/excalidraw/index.css is loaded once, and pass viewBackgroundColor: 'transparent' (already done) for overlay use.

- Export/cleanup: add “Export as PNG/SVG” and “Clear drawing” actions; optionally “Convert selection to node(s)” later.

- Decide anchoring model: today drawings are screen‑anchored (they won’t move with auto‑layout). If you want them to move with the graph, you’ll need to sync Excalidraw’s transform with RF’s transforms continuously (map RF pan/zoom to Excalidraw appState), or implement “attach to node” behavior for specific elements.


Selector Tool both for Edit and Draw



---
Refactoring:
1. Metric Card separate value card from metric card



Pages








UI work

---

1. Canvas
2. Pages:
	1. Dashboard
	2. Assets
	3. Evidence
	4. Data
	5. Settings




From homepage to canvas and back, need - loading state:
![[Pasted image 20250810024245.png]]



Block mobile and tablet usage (said that Canvasm can only be use at Desktop)