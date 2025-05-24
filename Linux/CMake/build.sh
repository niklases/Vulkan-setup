# sudo apt install glslang-tools
glslangValidator -V shaders/shader.vert -o shaders/vert.spv
glslangValidator -V shaders/shader.frag -o shaders/frag.spv
mkdir build
cd build
cmake ..
make
