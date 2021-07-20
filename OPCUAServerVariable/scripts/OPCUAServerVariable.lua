
--Start of Global Scope---------------------------------------------------------

-- Create OPC UA server instance
-- luacheck: globals gServer
gServer = OPCUA.Server.create()
--The server can be bound to a specific interface, using the following line.
--OPCUA.Server.setInterface(server, "ETH2")
OPCUA.Server.setApplicationName(gServer, 'SampleOPCUAServer')

--Creation of namespace and adding it the server.
--Namespaces are organizing the address space.
--Each server can have one or more user defined namespaces.
local namespace = OPCUA.Server.Namespace.create()
OPCUA.Server.setNamespaces(gServer, namespace)
--Every namespace has an index. 0 and 1 are reserved for OPC UA standard namespaces
OPCUA.Server.Namespace.setIndex(namespace, 2)

--Creation of folder that will be used as root node for the namespace.
--Every namespace needs a root node.
local allNodes = {}
local rootNode = OPCUA.Server.Node.create('OBJECT')
OPCUA.Server.Node.setID(rootNode, 'STRING', 'SampleRoot')
OPCUA.Server.Node.setTypeDefinition(rootNode, 'FOLDER_TYPE')
OPCUA.Server.Namespace.setRootNode(namespace, rootNode)
table.insert(allNodes, rootNode)

-- Creation of variable node
local variableNode = OPCUA.Server.Node.create('VARIABLE')
OPCUA.Server.Node.setID(variableNode, 'STRING', 'SampleVariable')
OPCUA.Server.Node.setDataType(variableNode, 'INT32')
OPCUA.Server.Node.setAccessLevel(variableNode, 'READ_WRITE') -- default is read only
table.insert(allNodes, variableNode)

-- Adding the variable node to the folder rootNode
OPCUA.Server.Node.addReference(rootNode, 'ORGANIZES', variableNode)

-- Adding all created nodes to the namespace
OPCUA.Server.Namespace.setNodes(namespace, allNodes)

-- Starting the server
OPCUA.Server.start(gServer)

-- Creation of periodic timer and registration of "gIncrementVariable" function
-- luacheck: globals gTimer
gTimer = Timer.create()
Timer.setExpirationTime(gTimer, 1000)
Timer.setPeriodic(gTimer, true)
Timer.register(gTimer, 'OnExpired', 'gIncrementVariable')
Timer.start(gTimer)

--End of Global Scope-----------------------------------------------------------

--Start of Function and Event Scope---------------------------------------------

-- Function is called periodically by timer and increments sample variable
-- luacheck: globals gIncrementVariable
function gIncrementVariable()
  local currentValue = OPCUA.Server.Node.getValue(variableNode)
  print('Current variable value is: ' .. currentValue)
  OPCUA.Server.Node.setValue(variableNode, currentValue + 1)
end

--End of Function and Event Scope------------------------------------------------
