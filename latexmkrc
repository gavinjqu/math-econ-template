# latexmkrc -- defaults for compiling from the TERMINAL.
# (VSCode uses .vscode/settings.json; this keeps `latexmk` in a shell consistent.)
#
# Run from the REPO ROOT, using -cd so output lands next to the source, e.g.:
#     latexmk -cd notes/notes-template.tex
#     latexmk -cd exam/final-solutions.tex
#     latexmk -c  -cd notes/notes-template.tex     # clean aux files

# 1) Use the full MacTeX 2026 distribution (your global default is TinyTeX,
#    which is missing biblatex/exam/metropolis/etc.).
$ENV{'PATH'} = '/Library/TeX/texbin:' . $ENV{'PATH'};

# 2) pdfLaTeX; latexmk auto-runs biber for biblatex documents.
$pdf_mode = 1;

# 3) Make the shared styles/ folder resolvable from any subfolder (absolute
#    path, so it survives -cd). References.bib is found in each doc's folder.
use Cwd;
my $root = getcwd();
ensure_path('TEXINPUTS', "$root/styles//", '');

# 4) Extra files for `latexmk -c` to remove (biblatex + beamer intermediates).
$clean_ext = 'bbl run.xml bcf nav snm vrb';
