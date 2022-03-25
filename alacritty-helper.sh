# Helper for updating, building etc Alacritty

LATEST_RELEASE=0
BUILD_DIRECTORY="/path/to/alacritty"
get_latest_release() {
	github_url="https://github.com/alacritty/alacritty/"
	github_latest=$(basename $(curl -fs -o/dev/null -w %{redirect_url} $github_url"releases/latest"))
	if [ $? -ne 0 ]; then
		echo "Unable to get version, see output:"
		echo $github_latest
	else
		LATEST_RELEASE=$github_latest
	fi
}

check_deps(){
	# Ensure Rust is usable
	type rustc >/dev/null 2>&1 || {
		echo >&2 "Could not find rustc try using rustup.rs"; 
		exit 1
	}
}
