import os
from jinja2 import Environment, FileSystemLoader, select_autoescape

version = os.environ.get('RELEASE_VERSION', '0.0.0')
env = Environment(
    loader=FileSystemLoader('.'),
    autoescape=select_autoescape()
)
template = env.get_template("maxiconda.sh.in")
out = template.render(version=version)

with open(f'maxiconda-{version}.sh', 'w') as f:
    f.write(out)
