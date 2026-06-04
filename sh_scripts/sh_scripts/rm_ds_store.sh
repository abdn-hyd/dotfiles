#!/bin/zsh

directories=("Documents" "AI/codes" ".config" "Pictures" "Wallpaper" "Downloads" "Music" "Desktop" ".cache" "Movies" ".local" "Public")

home_dir="$HOME"

rm $HOME/.DS_Store

for dir in "${directories[@]}"; do
	full_path="${home_dir}/${dir}"

	if [[ -d "${full_path}" ]]; then
		echo "Delete ${full_path} and its subdirectorie's .DS_Store files..."
		find "${full_path}" -name '.DS_Store' -type f -delete
	else
		echo "Warning: directorie ${full_path} does not exist"
	fi
done

library_caches="$HOME/Library/Caches"

echo "All .DS_Store and cache files have been deleted"
