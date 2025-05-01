(
  cd ~/.development-environment && \
  git pull && \
  stow .
) 2>&1 | tee ~/.development-environment/synchronization/update-dotfiles.log

