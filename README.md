# MCP Server for Milvus with NeMo Agent Toolkit Integration

Complete integration package for Milvus vector database with NVIDIA's NeMo Agent Toolkit (NAT) using Model Context Protocol (MCP).

## 🚀 Quick Start

```bash
# Clone the repository with submodules
git clone --recurse-submodules https://github.com/PicoNVIDIA/meow.git
cd mcp-server-milvus

# Set environment variables
export MILVUS_URI="your-milvus-uri"
export MILVUS_TOKEN="your-milvus-token"
export NVIDIA_API_KEY="your-nvidia-api-key"

# Run setup
./setup.sh

# Start everything
./start_all.sh
```

Open http://localhost:3000 to access the UI.

## 📋 Prerequisites

- Python 3.10+
- Node.js 18+
- Milvus/Zilliz Cloud account
- NVIDIA API key for NeMo models

## 🏗️ Architecture

This package includes:
- **MCP Server for Milvus**: Provides natural language access to Milvus vector database
- **NeMo Agent Toolkit**: NVIDIA's agent framework for building AI applications
- **NAT UI**: Web interface for interacting with your AI agent

```
┌─────────────┐     ┌──────────────┐     ┌─────────────┐
│   NAT UI    │────▶│  NAT Server  │────▶│ MCP Server  │
│  Port 3000  │     │  Port 8000   │     │  Port 9902  │
└─────────────┘     └──────────────┘     └─────────────┘
                                                 │
                                          ┌──────▼──────┐
                                          │   Milvus    │
                                          │   Database  │
                                          └─────────────┘
```

## 🔧 Installation

### 1. Get API Keys

- **Milvus/Zilliz Cloud**: Get credentials from [cloud.zilliz.com](https://cloud.zilliz.com)
- **NVIDIA API Key**: Get from [build.nvidia.com](https://build.nvidia.com)

### 2. Clone Repository

```bash
git clone --recurse-submodules https://github.com/PicoNVIDIA/meow.git
cd mcp-server-milvus
```

### 3. Configure Environment

Create a `.env` file:

```bash
# Milvus Configuration
MILVUS_URI=your-milvus-uri-here
MILVUS_TOKEN=your-milvus-token-here

# NVIDIA API Key
NVIDIA_API_KEY=your-nvidia-api-key-here
```

### 4. Run Setup Script

```bash
./setup.sh
```

This will:
- Install MCP server dependencies
- Set up NeMo Agent Toolkit
- Configure the integration
- Create startup scripts

## 🎯 Usage

### Start All Services

```bash
./start_all.sh
```

This starts:
- MCP Server on port 9902
- NAT Server on port 8000
- UI on port 3000

### Start Services Individually

```bash
./start_mcp_server.sh  # MCP Server only
./start_nat.sh         # NAT Server only
./start_ui.sh          # UI only
```

## 💬 Example Interactions

Once running, you can ask natural language questions about your Milvus database:

### List Collections
```
User: What databases do we have available?
Bot: Found 2 collection(s) in Milvus:
1. warehouse_inventory
2. documents
```

### Query Data
```
User: Show me all electronics in the warehouse
Bot: Found 46 electronics items including laptops, smartphones...
```

### Vector Search
```
User: Find products similar to wireless headphones
Bot: [Shows similar products based on vector similarity]
```

## 🛠️ Available MCP Tools

The integration provides these Milvus tools:

- **warehouse_query** - Natural language queries about inventory
- **milvus_list_collections** - List all collections
- **milvus_get_collection_info** - Get collection schema
- **milvus_query** - Query with filters
- **milvus_text_search** - Text similarity search
- **milvus_vector_search** - Vector similarity search
- **milvus_hybrid_search** - Combined text and vector search
- **milvus_load_collection** - Load collection to memory
- **milvus_release_collection** - Release from memory
- **milvus_insert_data** - Insert new data
- **milvus_create_collection** - Create new collection
- **milvus_delete_entities** - Delete data

## 📁 Project Structure

```
mcp-server-milvus/
├── src/mcp_server_milvus/    # MCP server implementation
│   └── server.py              # Main server with Milvus tools
├── NeMo-Agent-Toolkit/        # NAT submodule
│   ├── configs/               # NAT configurations
│   └── external/nat-ui/       # Web UI
├── nat_configs/               # Milvus-specific NAT configs
├── examples/                  # Example configurations
├── setup.sh                   # One-click setup script
└── start_all.sh              # Start all services
```

## 🔍 Troubleshooting

### Connection Issues
- Verify Milvus instance is running
- Check URI and token are correct
- Ensure ports 3000, 8000, 9902 are available

### Missing Tools in UI
- Restart NAT server
- Check MCP server is running on port 9902
- Verify configuration points to correct MCP server

### Environment Variables Not Set
```bash
source .env
```

## 🚀 Demo Capabilities

This integration showcases:
1. **Natural Language Database Access** - Query Milvus using plain English
2. **Vector Search** - Find similar items using embeddings
3. **Hybrid Search** - Combine text and vector search
4. **Real-time Data Management** - Insert, update, delete operations

## 📚 Documentation

- [Milvus Documentation](https://milvus.io/docs)
- [NeMo Agent Toolkit](https://github.com/NVIDIA/NeMo-Agent-Toolkit)
- [Model Context Protocol](https://modelcontextprotocol.io)

## 🤝 Contributing

Contributions welcome! Please submit pull requests or open issues.

## 📄 License

Apache 2.0 - See LICENSE file

## 🆘 Support

- **Issues**: Open an issue in this repository
- **NeMo Agent Toolkit**: [NVIDIA's NAT repository](https://github.com/NVIDIA/NeMo-Agent-Toolkit)
- **Milvus**: [Milvus documentation](https://milvus.io/docs)