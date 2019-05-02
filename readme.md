## OPCUAServerVariable
Creating OPC UA Server with readable/writable variable
### Description
 This sample is creating an OPC UA Server that listens on (default) port 4840.
It has a single integer variable in its address space, which can be read and
written by an OPC UA client. The server increments this variable periodically.  
### How to Run
To demo this sample any OPC UA client can be used. The description of this sample
is based on the free UaExpert which is offered from Automation GmbH.
After running this sample, connecting to the server (localhost or deviceIP) and
browsing the created address space is possible with the client. The created
variable "SampleVariable" can then be read or written.
To show this sample a device with OPC UA support is necessary. Alternatively
the emulator of AppStudio 2.2 and higher will support it

### Topics
System, Communication, Sample, SICK-AppSpace