#!/bin/bash
# Install (Security): Unattended Upgrades

# Package List Update Question
package_update_question

# Install Package
subheader "Installing Package..."
package_install unattended-upgrades
