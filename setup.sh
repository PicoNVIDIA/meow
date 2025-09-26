#!/bin/bash

# Complete setup script for Milvus MCP Server with NeMo Agent Toolkit

echo "🚀 Setting up Milvus MCP Server with NeMo Agent Toolkit..."

# Check for required environment variables
if [ -z "$MILVUS_URI" ] || [ -z "$MILVUS_TOKEN" ] || [ -z "$NVIDIA_API_KEY" ]; then
    echo "⚠️  Please set the following environment variables:"
    echo "   export MILVUS_URI='your-milvus-uri'"
    echo "   export MILVUS_TOKEN='your-milvus-token'"
    echo "   export NVIDIA_API_KEY='your-nvidia-api-key'"
    echo ""
    echo "   Get Milvus credentials from: https://cloud.zilliz.com"
    echo "   Get NVIDIA API key from: https://build.nvidia.com"
    exit 1
fi

# Step 1: Install Python dependencies for MCP server
echo "📦 Installing MCP server dependencies..."
if ! command -v uv &> /dev/null; then
    echo "Installing uv..."
    pip install uv
fi

echo "Setting up MCP server virtual environment..."
uv venv
source .venv/bin/activate
uv pip install -e .

# Step 2: Initialize git submodule for NAT
echo "📚 Initializing NeMo Agent Toolkit submodule..."
git submodule init
git submodule update

# Step 3: Setup NAT
echo "🤖 Setting up NeMo Agent Toolkit..."
cd NeMo-Agent-Toolkit

# Create virtual environment for NAT
python -m venv .venv
source .venv/bin/activate

# Install NAT dependencies
pip install -e .

# Copy Milvus config to NAT configs
echo "📝 Copying Milvus configuration..."
cp ../nat_configs/milvus_warehouse_config.yml configs/

# Step 4: Setup NAT UI
echo "🎨 Setting up NAT UI..."
cd external/nat-ui
npm install

cd ../../..

# Step 5: Create run scripts
echo "📄 Creating run scripts..."

# Create MCP server start script
cat > start_mcp_server.sh << 'EOF'
#!/bin/bash
source .venv/bin/activate
echo "Starting MCP Server on port 9902..."
python src/mcp_server_milvus/server.py --sse --port 9902
EOF
chmod +x start_mcp_server.sh

# Create NAT start script
cat > start_nat.sh << 'EOF'
#!/bin/bash
cd NeMo-Agent-Toolkit
source .venv/bin/activate
echo "Starting NeMo Agent Toolkit on port 8000..."
nat serve --config_file configs/milvus_warehouse_config.yml --host 0.0.0.0 --port 8000
EOF
chmod +x start_nat.sh

# Create UI start script
cat > start_ui.sh << 'EOF'
#!/bin/bash
cd NeMo-Agent-Toolkit/external/nat-ui
echo "Starting NAT UI on port 3000..."
npm run dev
EOF
chmod +x start_ui.sh

# Create all-in-one start script
cat > start_all.sh << 'EOF'
#!/bin/bash

echo "🚀 Starting complete Milvus-NAT system..."

# Check environment variables
if [ -z "$MILVUS_URI" ] || [ -z "$MILVUS_TOKEN" ] || [ -z "$NVIDIA_API_KEY" ]; then
    echo "⚠️  Missing environment variables!"
    echo "Please run: source .env"
    exit 1
fi

# Start MCP server in background
echo "1️⃣  Starting MCP Server..."
./start_mcp_server.sh &
MCP_PID=$!
sleep 3

# Start NAT in background
echo "2️⃣  Starting NeMo Agent Toolkit..."
./start_nat.sh &
NAT_PID=$!
sleep 5

# Start UI in background
echo "3️⃣  Starting UI..."
./start_ui.sh &
UI_PID=$!

echo ""
echo "✅ All services started!"
echo "   MCP Server: http://localhost:9902"
echo "   NAT API: http://localhost:8000"
echo "   UI: http://localhost:3000"
echo ""
echo "Press Ctrl+C to stop all services..."

# Wait and cleanup on exit
trap "echo 'Stopping services...'; kill $MCP_PID $NAT_PID $UI_PID; exit" INT
wait
EOF
chmod +x start_all.sh

echo ""
echo "✅ Setup complete!"
echo ""
echo "📋 Next steps:"
echo "1. Source your environment variables:"
echo "   source .env"
echo ""
echo "2. Start all services:"
echo "   ./start_all.sh"
echo ""
echo "3. Open the UI at http://localhost:3000"
echo ""
echo "Or start services individually:"
echo "   ./start_mcp_server.sh  # MCP Server on port 9902"
echo "   ./start_nat.sh         # NAT on port 8000"
echo "   ./start_ui.sh          # UI on port 3000"