#!/bin/bash

# Clone ComfyUI and navigate to custom_nodes
git clone https://github.com/comfyanonymous/ComfyUI || { echo "Failed to clone ComfyUI"; exit 1; }
cd ComfyUI/custom_nodes || { echo "Failed to navigate to ComfyUI/custom_nodes"; exit 1; }

# Clone required custom nodes
repos=(
    "https://github.com/ltdrdata/ComfyUI-Manager"
    "https://github.com/WASasquatch/was-node-suite-comfyui"
    "https://github.com/ltdrdata/ComfyUI-Impact-Pack"
    "https://github.com/SeargeDP/ComfyUI_Searge_LLM"
    "https://github.com/sipherxyz/comfyui-art-venture"
    "https://github.com/rgthree/rgthree-comfy"
    "https://github.com/chrisgoringe/cg-use-everywhere"
    "https://github.com/kijai/ComfyUI-KJNodes"
    "https://github.com/storyicon/comfyui_segment_anything"
    "https://github.com/chflame163/ComfyUI_LayerStyle"
    "https://github.com/yolain/ComfyUI-Easy-Use"
    "https://github.com/un-seen/comfyui-tensorops"
)

for repo in "${repos[@]}"; do
    git clone "$repo" || { echo "Failed to clone $repo"; exit 1; }
done

# Clone additional repositories
cd .. || exit
git clone https://github.com/vrcnx/comfyui-flux || { echo "Failed to clone comfyui-flux"; exit 1; }

# Setup Python virtual environment
python -m venv venv || { echo "Failed to create virtual environment"; exit 1; }
source venv/bin/activate || { echo "Failed to activate virtual environment"; exit 1; }

# Install dependencies
python -m pip install --upgrade pip
python -m pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu121 || { echo "Failed to install torch"; exit 1; }
python -m pip install -r requirements.txt || { echo "Failed to install requirements"; exit 1; }
python -m pip install -r custom_nodes/ComfyUI-Manager/requirements.txt || { echo "Failed to install Manager requirements"; exit 1; }
python -m pip install -r custom_nodes/comfyui-flux/requirements.txt || { echo "Failed to install Flux requirements"; exit 1; }

# Create GPU run script
cat << EOF > run_gpu.sh
#!/bin/bash
cd ComfyUI
source venv/bin/activate
python main.py --preview-method auto
EOF
chmod +x run_gpu.sh

# Create CPU run script
cat << EOF > run_cpu.sh
#!/bin/bash
cd ComfyUI
source venv/bin/activate
python main.py --preview-method auto --cpu
EOF
chmod +x run_cpu.sh

echo "Setup completed successfully!"
