# Clone main repo
git clone https://github.com/comfyanonymous/ComfyUI
cd ComfyUI
cd custom_nodes

# Clone custom nodes
git clone https://github.com/ltdrdata/ComfyUI-Manager
git clone https://github.com/WASasquatch/was-node-suite-comfyui
git clone https://github.com/ltdrdata/ComfyUI-Impact-Pack
git clone https://github.com/SeargeDP/ComfyUI_Searge_LLM
git clone https://github.com/sipherxyz/comfyui-art-venture
git clone https://github.com/rgthree/rgthree-comfy
git clone https://github.com/chrisgoringe/cg-use-everywhere
git clone https://github.com/kijai/ComfyUI-KJNodes
git clone https://github.com/storyicon/comfyui_segment_anything
git clone https://github.com/chflame163/ComfyUI_LayerStyle
git clone https://github.com/yolain/ComfyUI-Easy-Use
git clone https://github.com/un-seen/comfyui-tensorops
cd ..

# Clone additional repos
git clone https://github.com/vrcnx/comfyui-flux

# Setup virtual environment
python3 -m venv venv
source venv/bin/activate
python3 -m pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu121
python3 -m pip install -r requirements.txt

# Install requirements for custom nodes
python3 -m pip install -r custom_nodes/ComfyUI-Manager/requirements.txt
pip install -r ComfyUI/custom_nodes/ComfyUI-KJNodes/requirements.txt
pip install -r ComfyUI/custom_nodes/comfyui_segment_anything/requirements.txt
pip install -r ComfyUI/custom_nodes/ComfyUI_LayerStyle/requirements.txt
pip install -r ComfyUI/custom_nodes/ComfyUI-Easy-Use/requirements.txt
pip install -r ComfyUI/custom_nodes/comfyui-tensorops/requirements.txt

# Create models directories if not present
mkdir -p models/unet models/vae models/clip

# Download required model files
cd models/unet
wget https://huggingface.co/camenduru/FLUX.1-dev/resolve/main/flux1-dev.sft

cd ../vae
wget https://huggingface.co/camenduru/FLUX.1-dev/resolve/main/ae.sft

cd ../clip
wget https://huggingface.co/camenduru/FLUX.1-dev/resolve/main/clip_l.safetensors
wget https://huggingface.co/camenduru/FLUX.1-dev/resolve/main/t5xxl_fp16.safetensors

# Create run scripts
cd ../..
echo "#!/bin/bash" > run_gpu.sh
echo "cd ComfyUI" >> run_gpu.sh
echo "source venv/bin/activate" >> run_gpu.sh
echo "python3 main.py --preview-method auto" >> run_gpu.sh
chmod +x run_gpu.sh

echo "#!/bin/bash" > run_cpu.sh
echo "cd ComfyUI" >> run_cpu.sh
echo "source venv/bin/activate" >> run_cpu.sh
echo "python3 main.py --preview-method auto --cpu" >> run_cpu.sh
chmod +x run_cpu.sh
