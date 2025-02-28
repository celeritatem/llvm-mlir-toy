build:
	clang++ \
		src/toyc.cpp src/parser/AST.cpp \
		-I include \
		-o toyc \
		-g -O3 -fuse-ld=lld \
		`llvm-config --cxxflags --ldflags --system-libs --libs core native`
			