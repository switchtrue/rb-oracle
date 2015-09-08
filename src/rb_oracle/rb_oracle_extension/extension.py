from __future__ import unicode_literals

from reviewboard.extensions.base import Extension
from reviewboard.diffviewer.filetypes import HEADER_REGEXES, HEADER_REGEX_ALIASES

from pygments.lexers._mapping import LEXERS

import re

PLSQL_HEADER_REGEX = [
    re.compile(
        r'^\s*((FUNCTION|PROCEDURE)\s+)+'
        r'[a-zA-Z_][a-zA-Z0-9_]*'                  # function/procedure name
    ),
]

PLPGSQL_LEXER = ('pygments.lexers.sql', 'PL/pgSQL', ('plpgsql',), (), ('text/x-plpgsql',))


class DiffViewMethodNamesExtension(Extension):
    def initialize(self):
        HEADER_REGEXES['.plsql'] = PLSQL_HEADER_REGEX

        HEADER_REGEX_ALIASES['.pks'] = '.plsql'
        HEADER_REGEX_ALIASES['.pkb'] = '.plsql'

        LEXERS['PlPgsqlLexer'] = PLPGSQL_LEXER
