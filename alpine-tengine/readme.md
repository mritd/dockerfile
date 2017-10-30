## Alpine-Tengine Usage
## Version Tengine 2.2.1
### 1. Download the source file to Dir /install
```bash
wget http://tengine.taobao.org/download/tengine-2.2.1.tar.gz 
```
### 2. Decompression the file
```bash
cd install
tar -zxC . -f tengine-2.2.1.tar.gz
```
### 3.build
```
docker build --no-cache -t alpine:tengine .
```
