using BinDeps

@BinDeps.setup

libglut = library_dependency("libglut", aliases = ["libglut", "freeglut"])

@windows_only begin
	using WinRPM
	provides(WinRPM.RPM, "freeglut", libglut, os = :Windows)
end

@osx_only begin
	if Pkg.installed("Homebrew") === nothing
		error("Hombrew package not installed, please run Pkg.add(\"Homebrew\")")
	end
	using Homebrew
	provides(Homebrew.HB, "freeglut", libglut, os = :Darwin)
end

@linux_only begin
    provides(AptGet, {"freeglut3-dev" => libglut})
    provides(Yum, {"freeglut-devel" => libglut})
end

@BinDeps.install [:libglut => :libglut]
