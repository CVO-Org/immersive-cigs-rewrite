#!/usr/bin/env python3

"""
stringtableDeploy.py
Updated deploy script that:
- reads repo from GITHUB_REPOSITORY
- reads GH token from GH_TOKEN
- optionally uses TRANSLATION_ISSUE env var (issue number)
- searches for an issue titled "Translations" if TRANSLATION_ISSUE is not provided
- generates the markdown report by calling tools/stringtablediag.py --markdown
- updates the issue body only when different (adds a timestamp footer)
- logs sizes and actions for easier debugging
"""

import os
import sys
import traceback
import subprocess as sp
from datetime import datetime

# PyGithub modern auth
from github import Github, Auth

TRANSLATIONBODY = """**[Translation Guide](https://ace3.acemod.org/wiki/development/how-to-translate-ace3.html)**
{}
"""

def get_repo():
    """Authenticate and return the GitHub repository object."""
    try:
        token = os.environ["GH_TOKEN"]
    except KeyError:
        print("❌ Missing environment variable: GH_TOKEN")
        sys.exit(1)

    repo_path = os.environ.get("GITHUB_REPOSITORY")
    if not repo_path:
        print("❌ Missing environment variable: GITHUB_REPOSITORY (expected 'owner/repo')")
        sys.exit(1)

    try:
        github = Github(auth=Auth.Token(token))
        repo = github.get_repo(repo_path)
        print(f"✅ Connected to repository: {repo_path}")
        return repo
    except Exception:
        print("❌ Could not connect to GitHub repository.")
        print(traceback.format_exc())
        sys.exit(1)


def find_translation_issue(repo):
    """
    Determine which issue to update.
    1) If TRANSLATION_ISSUE env var exists and is a number, use it.
    2) Otherwise search open issues for one titled 'Translations' (case-insensitive).
    3) If none found, exit gracefully (soft success).
    """
    env_val = os.environ.get("TRANSLATION_ISSUE", "").strip()
    if env_val:
        try:
            issue_number = int(env_val)
            issue = repo.get_issue(issue_number)
            print(f"✅ Using translation issue #{issue_number} (from TRANSLATION_ISSUE env).")
            print(f"    {issue.html_url}")
            return issue
        except Exception:
            print(f"⚠️ TRANSLATION_ISSUE provided but invalid or not found: '{env_val}'")
            # fall through to search

    print("ℹ️ No valid TRANSLATION_ISSUE env var found. Searching for an open issue titled 'Translations'...")
    try:
        issues = repo.get_issues(state="open")
        for issue in issues:
            if issue.title and issue.title.strip().lower() == "translations":
                print(f"✅ Found translation issue #{issue.number} by title.")
                print(f"    {issue.html_url}")
                return issue
    except Exception:
        print("⚠️ Error while searching for issues (continuing to soft-exit if none found).")
        print(traceback.format_exc())

    print("⚠️ No 'Translations' issue found. Exiting gracefully (no failure).")
    sys.exit(0)


def generate_translation_report():
    """Run the diagnostic tool and return its markdown output."""
    diag_script = os.path.join(os.path.dirname(os.path.realpath(__file__)), "stringtablediag.py")
    if not os.path.isfile(diag_script):
        print("❌ Diagnostic script not found at tools/stringtablediag.py")
        sys.exit(1)

    try:
        # Use text=True to get str directly (py3.7+)
        diag_output = sp.check_output(["python3", diag_script, "--markdown"], text=True, stderr=sp.STDOUT)
        return diag_output
    except sp.CalledProcessError as e:
        print("❌ stringtablediag.py failed:")
        # print command output for debugging
        print(e.output)
        sys.exit(1)
    except Exception:
        print("❌ Unexpected error running stringtablediag.py.")
        print(traceback.format_exc())
        sys.exit(1)


def update_issue(issue, body):
    """Update the translation issue with the latest report, with logging & timestamp."""
    try:
        timestamp = datetime.utcnow().strftime("%Y-%m-%d %H:%M UTC")
        new_body = TRANSLATIONBODY.format(body) + f"\n\n_Last updated automatically: {timestamp}_"

        current_body = issue.body or ""

        # Log sizes
        print(f"ℹ️ Current issue body length: {len(current_body)} characters")
        print(f"ℹ️ New issue body length:     {len(new_body)} characters")

        # If identical, skip
        if new_body.strip() == current_body.strip():
            print("ℹ️ Issue body is already up to date — no changes made.")
            return

        print(f"📝 Updating issue #{issue.number} …")
        issue.edit(body=new_body)
        print(f"✅ Successfully updated issue #{issue.number}")

    except Exception:
        print("❌ Failed to update issue.")
        print(traceback.format_exc())
        sys.exit(1)


def main():
    repo = get_repo()
    issue = find_translation_issue(repo)
    # If find_translation_issue returns, we have an issue object.

    print("\n🧾 Generating translation report...")
    diag_body = generate_translation_report()

    print("\n✏️ Updating translation issue...")
    update_issue(issue, diag_body)


if __name__ == "__main__":
    main()
