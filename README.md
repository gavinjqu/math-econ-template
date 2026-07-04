# math-econ-template

A LaTeX template repo for **mathematics & theoretical economics** — lecture notes,
research papers, beamer slides, problem sets, and exams — preconfigured for
**VSCode on macOS**.

Every document shares one set of math/econ macros and theorem environments, and a
single option flips the bibliography between **biblatex** (modern, the default) and
**natbib** (for older journal requirements).

---

## 1. Your LaTeX setup (read this once)

Your Mac has **two** TeX distributions:

| Distribution | Location | On your `PATH`? | Has biblatex/exam/metropolis? |
|---|---|---|---|
| **TinyTeX** (minimal) | `~/Library/TinyTeX` | yes (default) | ❌ no |
| **MacTeX 2026** (full) | `/Library/TeX/texbin` | after TinyTeX | ✅ yes |

TinyTeX (used by R / Quarto) is missing several packages these templates need. So
this repo is wired to compile with **MacTeX 2026** instead — via
[.vscode/settings.json](.vscode/settings.json) and [latexmkrc](latexmkrc), which put
`/Library/TeX/texbin` first on `PATH`. **You don't need to install anything**, and
your global TinyTeX is left untouched.

> Want MacTeX to be your default everywhere (not just this repo)? Open **TeX Live
> Utility** or run `sudo tlmgr path add`, or reorder `PATH` in your shell profile.
> Not required for this repo.

---

## 2. Repository layout

```
math-econ-template/
├── styles/                 ← shared packages (edit these to change macros everywhere)
│   ├── mathmacros.sty      ← general math notation
│   ├── econ.sty            ← economics notation
│   ├── theorems.sty        ← theorem/definition/assumption environments
│   ├── mathprelude.sty     ← one-line preamble for articles (loads the above + hyperref/cleveref)
│   ├── meconbib.sty        ← bibliography toggle: biblatex (default) or natbib
│   └── homework.sty        ← problem/solution scaffolding
├── notes/                  ← lecture / study notes        (article + biblatex)
├── paper/                  ← research paper skeleton       (article + bib toggle)
├── slides/                 ← presentation                  (beamer + Metropolis)
├── homework/               ← problem set + separate answer key
├── exam/                   ← exam + separate answer key    (exam class)
├── .vscode/settings.json   ← build recipe (MacTeX 2026, styles path)
└── latexmkrc               ← same settings for terminal builds
```

The `styles/` folder is made visible to every subfolder automatically (via
`TEXINPUTS`), so any document can `\usepackage{mathmacros}` etc. with no path fuss.

---

## 3. Quick start in VSCode

1. **Open the folder** (not just a file): `File → Open Folder…` → pick
   `math-econ-template`. *(The build settings are per-folder, so this matters.)*
2. Open a template, e.g. [notes/notes-template.tex](notes/notes-template.tex).
3. **Build:** press **⌘⌥B**, or click the TeX badge in the left sidebar →
   *Build LaTeX project* (the ▶ icon). It also rebuilds every time you **save (⌘S)**.
4. **View the PDF:** **⌘⌥V** (opens beside your source).
5. **Jump around (SyncTeX):** **⌘-click** in the PDF → jumps to that line in the
   source; **⌘-click** in the source → scrolls the PDF there.
6. Errors/warnings appear in the **Problems** panel and the *LaTeX Workshop* output.

That's it — the green arrow does pdfLaTeX + biber and opens the PDF.

---

## 4. Building from the terminal

Run from the **repo root**, with `-cd` so output lands next to the source:

```bash
latexmk -cd notes/notes-template.tex          # build
latexmk -cd exam/final-solutions.tex          # build the answer key
latexmk -c -cd notes/notes-template.tex       # clean aux files (keep the PDF)
latexmk -C -cd notes/notes-template.tex       # clean everything (incl. PDF)
```

[latexmkrc](latexmkrc) prepends MacTeX to `PATH` and points `TEXINPUTS` at `styles/`,
so this matches the VSCode build exactly.

---

## 5. The document types

### 📓 Notes — [notes/notes-template.tex](notes/notes-template.tex)
Article with the full macro/theorem set and citations. Start a new set by copying the
file (e.g. `notes/game-theory.tex`) and editing.

### 📄 Research paper — [paper/paper-template.tex](paper/paper-template.tex)
Economics paper skeleton: title/`\thanks`, abstract, **JEL codes**, sections, an
`\appendix` for proofs, and the bibliography toggle. Uncomment `\doublespacing` for a
submission draft.

### 🖥️ Slides — [slides/slides-template.tex](slides/slides-template.tex)
Beamer with the **Metropolis** theme (compiles with pdfLaTeX here). Use `\section{}`
for section slides and beamer's built-in `theorem`/`block` environments. The math/econ
macros work on slides too.

### 📝 Homework — [homework/](homework/) (problems + **separate** answer key)
Three files, one source of truth:
- [hw01-content.tex](homework/hw01-content.tex) — the problems, each with a
  `\begin{solution}…\end{solution}` block.
- [hw01.tex](homework/hw01.tex) — the **assignment** (solutions hidden). → `hw01.pdf`
- [hw01-solutions.tex](homework/hw01-solutions.tex) — the **answer key**
  (`\showsolutions`). → `hw01-solutions.pdf`

Write each problem once; compile two PDFs. New set: copy the three files to `hw02*`
and change the `\input{hw02-content}` line.

### 🧪 Exam — [exam/](exam/) (uses the `exam` document class)
Same content + two wrappers pattern, but with the `exam` class (automatic points,
grading table, "page *x* of *N*"):
- [final-content.tex](exam/final-content.tex) — `\question`s with `\begin{solution}`.
- [final.tex](exam/final.tex) — the blank exam.
- [final-solutions.tex](exam/final-solutions.tex) — adds `\printanswers` for the key.

---

## 6. Macro cheat-sheet

Defined in [styles/mathmacros.sty](styles/mathmacros.sty) and
[styles/econ.sty](styles/econ.sty). Edit those files to add your own.

**Sets & delimiters**

| Macro | Output | | Macro | Output |
|---|---|---|---|---|
| `\R \Z \Q \N \C \F` | ℝ ℤ ℚ ℕ ℂ 𝔽 | | `\Rplus \Rpp` | ℝ₊  ℝ₊₊ |
| `\abs{x} \norm{x}` | \|x\|  ‖x‖ | | `\floor{x} \ceil{x}` | ⌊x⌋ ⌈x⌉ |
| `\set{...}` | {…} | | `\setb{x \given x>0}` | {x \| x>0} (bar scales) |
| `\inner{x}{y}` | ⟨x,y⟩ | | `\parens* \bracks*` | auto-sized ( ) [ ] |

*(Add `*` to any delimiter to auto-size: `\abs*{\frac{a}{b}}`.)*

**Operators** `\argmax \argmin \esssup \supp \dom \rank \tr \diag \sgn \spann \conv \dist \proj \diam \intr \relint`

**Probability** `\E[X]` `\Prob(A)` `\Var \Cov \Corr \plim` `\Ind\{·\}` (indicator) `\Normal` `\indep` `\iid` `\dto \pto \asto` (converges in dist./prob./a.s.)

**Calculus / linear algebra** `\dd` (upright d) `\dv{f}{x}` `\pdv{f}{x}` `\grad` · `\vect{x} \mat{A}` `A\T` (transpose) `A\inv`

**Shorthand** `\eps \ph` (var-epsilon/phi) `\ol \ul \wt \wh` (over/under-line, wide tilde/hat) `\defeq` (≔) `\st` (s.t.)

**Economics** `\pref \prefstr \dpref` (⪰ ≻ ⪯) · `\Lag` (Lagrangian) `\maximize \minimize` · `\BR` (best response) `x\eqm` (equilibrium ⋆) `\simplex{A}` `s_{\negi}` (−i) · `\MRS \MRT \MU \MC \MB \MR`

---

## 7. Theorem environments

From [styles/theorems.sty](styles/theorems.sty). `theorem`, `lemma`, `proposition`,
`corollary`, `claim`, `conjecture`, `fact`, `definition`, `example`, `exercise`,
`remark`, `note`, `notation`, and `proof`. `assumption` has its own counter
(Assumption 1, 2, …), the usual econ convention.

Reference them with **cleveref** — it prints the type for you:

```latex
\begin{theorem}\label{thm:main} ... \end{theorem}
By \Cref{thm:main} and \Cref{as:reg}, ...   % → "By Theorem 1 and Assumption 2, ..."
```

---

## 8. Bibliography — and the natbib toggle

Default is **biblatex + biber** (modern author–year). To satisfy an **older journal
that requires bibtex/natbib**, change **one line** in your document's preamble:

```latex
\usepackage{meconbib}            % DEFAULT: biblatex + biber
\usepackage[natbib]{meconbib}    % TOGGLE:  natbib + bibtex
```

**Nothing else changes** — the citation commands are identical either way:

```latex
\bibresource{references}         % your .bib file (without the .bib extension)
...
\citet{akerlof1970}      % → Akerlof (1970)
\citep{akerlof1970}      % → (Akerlof 1970)
\textcite{...} \parencite{...}   % biblatex-style aliases also work in both modes
...
\printrefs                       % prints the bibliography
```

Under `[natbib]` you can pick a journal style (put its `.bst` on your path first):

```latex
\usepackage[natbib]{meconbib}
\setbibstyle{aer}                % e.g. aer, ecta, econometrica, chicago; default plainnat
```

Just rebuild after switching — latexmk automatically runs **biber** (biblatex) or
**bibtex** (natbib) as appropriate. Defined in [styles/meconbib.sty](styles/meconbib.sty).

---

## 9. Customizing

- **Add/edit macros:** edit [styles/mathmacros.sty](styles/mathmacros.sty) or
  [styles/econ.sty](styles/econ.sty). Every document picks up the change on the next build.
- **Change margins/fonts globally:** edit [styles/mathprelude.sty](styles/mathprelude.sty)
  (e.g. the `geometry` margin, or link colors `LinkNavy`/`CiteGreen`).
- **New document:** copy the closest template file/folder and rename. Give notes/papers
  their own `references.bib` in the same folder (each folder already has one).

---

## 10. Troubleshooting

| Symptom | Fix |
|---|---|
| `LaTeX Error: File 'biblatex.sty' not found` (or `exam.cls`, `metropolis`) | You're compiling with TinyTeX. Make sure you **opened the repo folder** in VSCode so its `.vscode/settings.json` applies; in a terminal, build from the **repo root**. |
| `File 'mathmacros.sty' not found` | Open the **repo root** as the workspace folder (so `%WORKSPACE_FOLDER%`/`TEXINPUTS` resolves), or run `latexmk` from the repo root. |
| Citations show as `[?]` / `(author?)` | Build again — the first pass runs before biber/bibtex. LaTeX Workshop's recipe handles the extra passes automatically. |
| Aux files cluttering a folder | `latexmk -c -cd <folder>/<file>.tex`, or just save again (auto-clean on failure is on). |
| Metropolis looks plain | It uses default fonts under pdfLaTeX. For the signature Fira look, compile that file with LuaLaTeX + the `fira` package (optional). |

---

*Built for macOS + VSCode (LaTeX Workshop) + MacTeX 2026.*
