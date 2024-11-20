#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Step 1: Clone ComfyUI Repository
if [ ! -d "ComfyUI" ]; then
    echo "Cloning ComfyUI repository..."
    git clone https://github.com/comfyanonymous/ComfyUI
fi

# Step 2: Clone Custom Nodes
cd ComfyUI/custom_nodes || { echo "Directory not found: ComfyUI/custom_nodes"; exit 1; }

declare -a custom_nodes=(
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

for node in "${custom_nodes[@]}"; do
    repo_name=$(basename "$node" .git)
    if [ ! -d "$repo_name" ]; then
        echo "Cloning $repo_name..."
        git clone "$node"
    else
        echo "$repo_name already exists, skipping..."
    fi
done

cd ../.. || { echo "Failed to return to ComfyUI root directory"; exit 1; }

# Step 3: Clone comfyui-flux Repository
if [ ! -d "comfyui-flux" ]; then
    echo "Cloning comfyui-flux repository..."
    git clone https://github.com/vrcnx/comfyui-flux
fi

# Step 4: Set Up Python Virtual Environment
if [ ! -d "venv" ]; then
    echo "Creating Python virtual environment..."
    python3 -m venv venv
fi

echo "Activating virtual environment..."
source venv/bin/activate

# Step 5: Install Dependencies
echo "Installing dependencies..."
python -m pip install --upgrade pip
python -m pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu121

if [ -f "requirements.txt" ]; then
    python -m pip install -r requirements.txt
fi

if [ -f "custom_nodes/ComfyUI-Manager/requirements.txt" ]; then
    python -m pip install -r custom_nodes/ComfyUI-Manager/requirements.txt
fi

if [ -f "custom_nodes/comfyui-flux/requirements.txt" ]; then
    python -m pip install -r custom_nodes/comfyui-flux/requirements.txt
fi

# Step 6: Create Run Scripts
echo "Creating run scripts..."

cat <<EOL > run_gpu.sh
#!/bin/bash
cd ComfyUI
source venv/bin/activate
python main.py --preview-method auto
EOL

chmod +x run_gpu.sh

cat <<EOL > run_cpu.sh
#!/bin/bash
cd ComfyUI
source venv/bin/activate
python main.py --preview-method auto --cpu
EOL

chmod +x run_cpu.sh

echo "Setup completed successfully."
