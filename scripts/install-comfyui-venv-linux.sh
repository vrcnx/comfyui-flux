git clone https://github.com/comfyanonymous/ComfyUI
cd ComfyUI
cd custom_nodes
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
git clone https://github.com/vrcnx/comfyui-flux
python -m venv venv
source venv/bin/activate
python -m pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu121
python -m pip install -r requirements.txt
python -m pip install -r custom_nodes/ComfyUI-Manager/requirements.txt
python -m pip install -r comfyui-flux/requirements.txt
cd ..
echo "#!/bin/bash" > run_gpu.sh
echo "cd ComfyUI" >> run_gpu.sh
echo "source venv/bin/activate" >> run_gpu.sh
echo "python main.py --preview-method auto" >> run_gpu.sh
chmod +x run_gpu.sh

echo "#!/bin/bash" > run_cpu.sh
echo "cd ComfyUI" >> run_cpu.sh
echo "source venv/bin/activate" >> run_cpu.sh
echo "python main.py --preview-method auto --cpu" >> run_cpu.sh
chmod +x run_cpu.sh

https://github.com/vrcnx/comfyui-flux/blob/bfd5ab0046a7a1364aa59b07ef3a1a035999ebc3/install-comfyui-venv-linux.sh
