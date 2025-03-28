def get_exclusion_patterns():
    """
    Regex patterns, which will be compared against directory and file names
    case-sensitively. https://docs.python.org/3/library/re.html#re.search is the
    matching function and scans the whole string to find any pattern match. Used
    with the https://pypi.org/project/regex/ module.

    Additional remarks for pattern creation:
    - The compared paths will be always in POSIX format.
    - Each directory path will have a / at the end to allow to distinguish them
      from files.
    - Patterns for dynamic or custom paths like Virtual Environments (venv) or
      build site directories are created during plugin runtime.
    """
    return [
        r"/__pycache__/",               # Python cache directory

        r"/\.DS_Store$",                # macOS

        r"/[^/]+\.zip$",                # Generated files and folders

        r"/[^/]*\.cache($|/)",          # .cache files and folders

        r"/\.vscode/",                  # Common autogenerated IDE directories
        r"/\.vs/",
        r"/\.idea/",
    ]
