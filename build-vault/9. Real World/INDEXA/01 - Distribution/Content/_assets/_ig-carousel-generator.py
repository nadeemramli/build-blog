PAPER="#F4F1E9"; INK="#16181D"; INDIGO="#3D34C9"; MIST="#E4DFD2"; LINE="#CFC9B8"; SUB="#5B5C57"
W,H=1080,1350
SERIF="DejaVu Serif"; SANS="Liberation Sans, DejaVu Sans"; MONO="Liberation Mono, DejaVu Sans Mono"

def frame(idx):
    return f'''
  <rect width="{W}" height="{H}" fill="{PAPER}"/>
  <rect x="48" y="48" width="{W-96}" height="{H-96}" fill="none" stroke="{LINE}" stroke-width="2"/>
  <g font-family="{MONO}" font-size="26" letter-spacing="6" fill="{INK}">
    <text x="84" y="120">INDEXA</text>
    <text x="84" y="158" fill="{SUB}" font-size="22" letter-spacing="4">RESEARCH NOTES</text>
    <text x="{W-84}" y="120" text-anchor="end">{idx} / 03</text>
  </g>
  <line x1="84" y1="190" x2="{W-84}" y2="190" stroke="{LINE}" stroke-width="2"/>
'''

def footer(extra=""):
    return f'''
  <line x1="84" y1="{H-150}" x2="{W-84}" y2="{H-150}" stroke="{LINE}" stroke-width="2"/>
  <g font-family="{MONO}" font-size="22" letter-spacing="3" fill="{SUB}">
    <text x="84" y="{H-110}">@indexalabs</text>
    <text x="{W-84}" y="{H-110}" text-anchor="end">{extra}</text>
    <text x="84" y="{H-78}" font-size="18" letter-spacing="1">FOR RESEARCH &amp; EDUCATIONAL USE ONLY — NOT MEDICAL ADVICE</text>
  </g>
'''

def chain(cx,cy,n=4,r=26,gap=78,col=INDIGO):
    x0=cx-(n-1)*gap/2
    line=f'<line x1="{x0}" y1="{cy}" x2="{x0+(n-1)*gap}" y2="{cy}" stroke="{INK}" stroke-width="3"/>'
    dots="".join(f'<circle cx="{x0+i*gap}" cy="{cy}" r="{r}" fill="{col}" stroke="{INK}" stroke-width="3"/>' for i in range(n))
    return f'<g>{line}{dots}</g>'

# ---------- Slide 1: cover ----------
s1=f'''<svg xmlns="http://www.w3.org/2000/svg" width="{W}" height="{H}" viewBox="0 0 {W} {H}">
  {frame("01")}
  <text x="84" y="330" font-family="{MONO}" font-size="22" letter-spacing="3" fill="{INDIGO}">RESEARCH COMPOUNDS · 01</text>
  <g font-family="{SERIF}" font-weight="bold" fill="{INK}">
    <text x="80" y="500" font-size="116">What is it,</text>
    <text x="80" y="620" font-size="116">really?</text>
  </g>
  <text x="84" y="710" font-family="{SANS}" font-size="40" fill="{SUB}">A 60-second primer, minus the hype.</text>
  {chain(540,960,5,36,120)}
  <text x="84" y="{H-200}" font-family="{SANS}" font-size="34" font-style="italic" fill="{INDIGO}">swipe →</text>
  {footer("THE PRIMER")}
</svg>'''

# ---------- Slide 2: definition ----------
s2=f'''<svg xmlns="http://www.w3.org/2000/svg" width="{W}" height="{H}" viewBox="0 0 {W} {H}">
  {frame("02")}
  <text x="84" y="300" font-family="{MONO}" font-size="22" letter-spacing="3" fill="{INDIGO}">01 — SIMPLE VERSION</text>
  <g font-family="{SERIF}" font-weight="bold" font-size="64">
    <text x="80" y="410" fill="{INK}">A</text>
    <text x="152" y="410" fill="{INDIGO}">short chain</text>
    <text x="80" y="490" fill="{INK}">of amino acids.</text>
  </g>
  <!-- diagrams -->
  <text x="84" y="640" font-family="{MONO}" font-size="22" letter-spacing="3" fill="{SUB}">SHORT CHAIN — a signal</text>
  {chain(250,700,4,22,70,INDIGO)}
  <text x="84" y="820" font-family="{MONO}" font-size="22" letter-spacing="3" fill="{SUB}">LONG CHAIN — a protein</text>
  <g>
    <line x1="120" y1="880" x2="900" y2="880" stroke="{INK}" stroke-width="3"/>
    {''.join(f'<circle cx="{120+i*52}" cy="880" r="16" fill="{INK}"/>' for i in range(15))}
  </g>
  <g font-family="{SANS}" font-size="32" fill="{SUB}">
    <text x="84" y="990">Long chains are proteins. The short ones are</text>
    <text x="84" y="1035">different — and your body already makes thousands</text>
    <text x="84" y="1080">of them as signaling molecules.</text>
  </g>
  {footer("DEFINITION")}
</svg>'''

# ---------- Slide 3: why it matters + CTA ----------
s3=f'''<svg xmlns="http://www.w3.org/2000/svg" width="{W}" height="{H}" viewBox="0 0 {W} {H}">
  {frame("03")}
  <text x="84" y="300" font-family="{MONO}" font-size="22" letter-spacing="3" fill="{INDIGO}">02 — WHY RESEARCHERS CARE</text>
  <g font-family="{SERIF}" font-weight="bold" fill="{INK}">
    <text x="80" y="410" font-size="60">They're precise</text>
    <text x="80" y="480" font-size="60">signals.</text>
  </g>
  <g font-family="{SANS}" font-size="34" fill="{SUB}">
    <text x="84" y="580">It tells a cell what to do — and only that.</text>
    <text x="84" y="628">That specificity is why they're studied across</text>
    <text x="84" y="676">recovery, metabolism, skin and longevity.</text>
  </g>
  <rect x="84" y="760" width="{W-168}" height="190" fill="#FFFFFF" stroke="{LINE}" stroke-width="2"/>
  <text x="116" y="828" font-family="{MONO}" font-size="22" letter-spacing="4" fill="{INDIGO}">THE INDEXA STANDARD</text>
  <g font-family="{SANS}" font-size="32" fill="{INK}">
    <text x="116" y="884">Every compound ships with a third-party COA.</text>
    <text x="116" y="926" font-weight="bold">Verify the batch before you trust it.</text>
  </g>
  <text x="84" y="1060" font-family="{SERIF}" font-weight="bold" font-size="44" fill="{INK}">Read the full primer →</text>
  <text x="84" y="1110" font-family="{SANS}" font-size="32" fill="{INDIGO}">link in bio · indexalabs</text>
  {footer("WHY IT MATTERS")}
</svg>'''

for name,svg in [("ig_v2_01.svg",s1),("ig_v2_02.svg",s2),("ig_v2_03.svg",s3)]:
    open(name,"w").write(svg)
print("written")
