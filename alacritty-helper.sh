# Helper for updating, building etc Alacritty
LATEST_RELEASE=0
BUILD_DIRECTORY="${ALACRITTY_DIRECTORY:=~/alacritty}"
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
	type rustc > /dev/null 2>&1 || {
		printf '%s\n' "Could not find rustc try using rustup.rs \n"; 
		exit 1
	}
	# Deps for debian, adjust for other distros (gzip for man page)
	deps=("cmake" "pkg-config" "libfreetype6-dev" "libfontconfig1-dev" "libxcb-xfixes0-dev" "libxkbcommon-dev" "python3" "gzip")
	dpkg -s "${deps[@]}" >/dev/null 2>&1 || {
		echo "Deps not installed, need: ${deps[*]}"
		exit 1
	}
}

dentry() {
	local target_bin=$BUILD_DIRECTORY"/target/release/alacritty"
	if [ -f $target_bin ]; then
		sudo cp $target_bin /usr/local/bin
		if [ ! -f /usr/share/pixmaps/Alacritty.svg ]; then
			sudo cp $BUILD_DIRECTORY"/extra/logo/alacritty-term.svg" /usr/share/pixmaps/Alacritty.svg
		fi
		sudo desktop-file-install $BUILD_DIRECTORY"/extra/linux/Alacritty.desktop"
		sudo update-desktop-database
		printf "Done."
	else
		printf "%s not found \n" $target_bin
	fi
}

terminfo() {
	if infocmp alacritty >/dev/null 2>&1; then
		:
	elif [[ $EUID -ne 0 ]]; then
		echo "terminfo compiler needs sudo, run this as sudo."
		exit 1
	else
		sudo tic -xe alacritty,alacritty-direct $BUILD_DIRECTORY"/extra/alacritty.info"
	fi
}

_build() {
	[ -d $BUILD_DIRECTORY ] || return 1
	cd $BUILD_DIRECTORY
	cargo build --release
}

build() {
	# Check for Dependencies first
	check_deps
	# Build release
	_build || {
		echo "_Build Function Failed. Aborting"
		exit 1
	}
	# Deal with terminal info db
	terminfo
}

hwto() {
cat 1>&2 <<EOF
USAGE: $0 [OPTIONS]
	
OPTIONS:
	-d,	Set build directory, (default: ~/alacritty or \$ALACRITTY_DIRECTORY if set)
	-b,	Build. Runs a cargo release build.
	-e,	Add desktop entry, must be specified after build to use updated binary.
EOF
}

if [ $# -lt 1 ]; then
	printf "Invalid number of options; \n"
	hwto
	exit 1
fi

while getopts ":d:eb" opts; do
	case $opts in
		d)
			BUILD_DIRECTORY="${OPTARG}"
			printf "Build Directory: %s \n" $BUILD_DIRECTORY;;
		e)
			dentry
			exit 0 ;;
		b)
			build
			exit 0 ;;
		\?)
			printf "Invalid option. \n"
			hwto
			exit 1 ;;
		:)
			printf "Expected argument but got \"$OPTARG.\"\n"
			hwto 
			exit 1 ;;
	esac
done
