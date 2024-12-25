import sys
from pathlib import Path

# Add the server directory to Python path
server_dir = str(Path(__file__).parent.parent)
if server_dir not in sys.path: sys.path.append(server_dir)


from src.main import app_forge
from fastapi.testclient import TestClient

# ? Test App ---------------------------------------------------------------------------------------

client = TestClient(app_forge.app)

def test_metadata():
    """Test the metadata endpoint"""
    response = client.get("/dt/")

    assert response.status_code == 200
    assert response.json() == app_forge.info.to_dict(), \
    "Metadata response does not match Forge info"
    
    print("\nMetadata Test Results:")
    print("Response status:", response.status_code)
    print("Metadata content:", response.json())


if __name__ == '__main__':
    test_metadata()
