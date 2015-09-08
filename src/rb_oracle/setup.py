from reviewboard.extensions.packaging import setup

PACKAGE = "rb_oracle_extension"
VERSION = "0.1"

setup(
    name=PACKAGE,
    version=VERSION,
    description='Oracle datbase extension for Review Board.',
    author='Mike Leonard',
    packages=['rb_oracle_extension'],
    entry_points={
        'reviewboard.extensions':
            '%s = rb_oracle_extension.extension:DiffViewMethodNamesExtension' % PACKAGE,
    },
)
