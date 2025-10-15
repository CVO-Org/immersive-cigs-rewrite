#!/usr/bin/env python3

###################################
# ZEN automatic deployment script #
# =============================== #
# This is not meant to be run     #
# directly!                       #
###################################

import os
import sys
import traceback
import subprocess as sp
from github import Github

TRANSLATIONBODY = """**[Translation Guide](https://ace3.acemod.org/wiki/development/how-to-translate-ace3.html)**
{}
"""

def get_repo():
    """Authenticate and return the GitHub repository object."""
    try:
        token = os.environ["GH_TOKEN"]
        repo_path = os.environ["GITHUB_REPOSITORY"]  # e.g. "User/Repo"
        github = Github(token)
        repo = github.get_repo(repo_path)
        print(f"✅ Connected to repository: {repo_path}")
        return repo
    except KeyError as e:
        print(f"❌ Missing environment variable: {e}")
        sys.exit(1)
    except Exception:
        print("❌ Could not connect to GitHub repository.")
        print(traceback.format_exc())
        sys.exit(1)

def get_translation_issue(repo):
    """Get the translation issue by env var or by title lookup."""
    issue_number = os.environ.get("TRANSLATION_ISSUE")
    if issue_number:
        try:
            issue = repo.get_issue(int(issue_number))
            print(f"✅ Using translation issue #{issue_number}")
            return issue
        except Exception:
            print(f"⚠️ Issue #{issue_number} not found.")
            return None

    print("ℹ️ No TRANSLATION_ISSUE env var found. Searching for issue titled 'Translations'...")
    issues = repo.get_issues(state="open")
    for issue in issues:
        if issue.title.lower().strip() == "translations":
            print(f"✅ Found translation issue #{issue.number}")
            return issue

    print("⚠️ No issue titled 'Translations' found. Exiting gracefully.")
    sys.exit(0)

def generate_translation_report():
    """Run the diagnostic tool and return its markdown output."""
    try:
        diag_output = sp.check_output(
            ["python3", "tools/stringtablediag.py", "--markdown"],
            text=True
        )
        return diag_output
    except sp.CalledProcessError as e:
        print("❌ Failed to run stringtablediag.py:")
        print(e.output)
        sys.exit(1)
    except Exception:
        print("❌ Unexpected error running stringtablediag.py.")
        print(traceback.format_exc())
        sys.exit(1)

def update_issue(issue, body):
    """Update the issue with the latest translation report."""
    try:
        issue.edit(body=TRANSLATIONBODY.format(body))
        print(f"✅ Successfully updated issue #{issue.number}")
    except Exception:
        print("❌ Failed to update issue.")
        print(traceback.format_exc())
        sys.exit(1)

def main():
    repo = get_repo()
    issue = get_translation_issue(repo)
    if issue is None:
        sys.exit(0)  # graceful exit

    print("\n🧾 Generating translation report...")
    diag_body = generate_translation_report()

    print("\n✏️ Updating translation issue...")
    update_issue(issue, diag_body)

if __name__ == "__main__":
    main()
