# Analyzing DGAs with Frida

## General Information
* Author: Leron Gray
* Description: This presentation covers the use of Frida to intercept DGA blocks of code and generate the domains using known values.
* Video Link: https://youtu.be/tgnINzKXV0U


## Why You Should Care
Domain Generation Algorithms (DGAs) can be extremely complex. It could take a significant amount of time to reverse engineer a DGA. Notorious families of malware such as Conficker or Ranbyus have demonstrated that it's possible to generate and register a large number of domains every day and the attacker would only need to ensure that at least one of them has been successfully registered. 

Therefore, more time analyzing the specifics of DGAs means that the malware has more time to function as intended and the number of infected machines can increase by the second.

## Three Main Ideas
1. DGAs are typically **values go in** and **domains come out**. Anything that happens in between, although important to understand how the DGA works, can be determined at later time in order to ensure a timely analysis of generated domains.
2. [Frida](https://frida.re/), a dynamic analysis tool, allows for extracting and/or manipulating the arguments provided to a function in a process and can extract the results of the function. This makes it the perfect tool for a "**values go in** and **domains come out**" mindset.
3. By determining where the functionality for the DGA lives in the binary using a disassembler such as IDA/Ghidra/Binary Ninja, Frida can easily intercept the values being used to generate the domains and return the domains once generated. Additionally, with some light scripting, the values for input can be changed dynamically, allowing for easy analysis of deterministic algorithms.

## Future Direction
While this presentation focuses on DGAs, Frida can be used to intercept any function call, making it useful for additional defensive capabilities. For example, if the malware injects shellcode into memory, Frida is capable of determine when calls such as VirtualProtect are made and can read the memory to dump the shellcode to a file. This makes some automation possible of malware possible and can be instrumental in furthering dynamic analysis of binaries.

## Additional Resources
* [Netlab DGA Analysis Presentation](https://www.youtube.com/watch?v=Fy2UHawpZaQ)
* [Frida](https://frida.re/)
* [Blackberry Blog - Malware Analysis with Dynamic Binary Instrumentation Frameworks](https://blogs.blackberry.com/en/2021/04/malware-analysis-with-dynamic-binary-instrumentation-frameworks)

