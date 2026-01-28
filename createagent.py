from azure.identity import DefaultAzureCredential
from azure.ai.projects import AIProjectClient
from azure.ai.projects.models import PromptAgentDefinition
import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

myEndpoint = os.getenv("AZURE_AI_PROJECT_ENDPOINT")
myModel = os.getenv("AZURE_AI_MODEL_DEPLOYMENT_NAME", "gpt-4o")

print(f"Project Endpoint: {myEndpoint}")
print(f"Model Deployment: {myModel}")


def createagent():
    myAgent = "cicdagenttest"
    
    # Create AIProjectClient for persistent agents
    project_client = AIProjectClient(
        endpoint=myEndpoint,
        credential=DefaultAzureCredential(),
    )
    
    # Check if agent already exists
    try:
        existing_agent = project_client.agents.get(agent_name=myAgent)
        print(f"Agent already exists: {existing_agent.name} (ID: {existing_agent.id})")
        return
    except Exception:
        print(f"Creating new agent: {myAgent}")
    
    # Create persistent agent with PromptAgentDefinition
    definition = PromptAgentDefinition(
        model=myModel,
        instructions="You are CICD Agent, an AI agent designed to assist with continuous integration and continuous deployment tasks."
    )
    
    agent = project_client.agents.create(
        name=myAgent,
        definition=definition
    )
    
    print(f"Agent created successfully!")
    print(f"  Name: {agent.name}")
    print(f"  ID: {agent.id}")


if __name__ == "__main__":
    createagent()
