const express = require('express');
const path = require('path');
const cors = require('cors')
const app = express()
const port = process.env.BACKEND_PORT ?? 4545;
const { resolve } = require('path');
const { fstat } = require('fs');
const { readdir,readFile } = require('fs').promises;

app.use(cors())

async function getFiles(dir) {
    const dirents = await readdir(dir, { withFileTypes: true });
    const files = await Promise.all(dirents.map((dirent) => {
      const res = resolve(dir, dirent.name);
      return dirent.isDirectory() ? getFiles(res) : res;
    }));
    return Array.prototype.concat(...files);
  }

app.get('/abi/contracts', async (req, res) => {
    const _files = await getFiles("./../artifacts/contracts/")
    const response = [];
    for (const _file of _files) {
        const basename = path.basename(_file);
        const fullPath = _file;


        if (String(fullPath).endsWith('.dbg.json')) {
            continue;
        }

        /**
         * Check for interface or library.
         */

        const json = JSON.parse((await readFile(fullPath)).toString());
        
        if (json.bytecode === '0x' || json.deployedBytecode === '0x') {
            // interface skip
            continue;
        }
         
        if (json.abi.length === 0) {
            // library
            continue;
        }


        response.push({basename, fullPath});

    }

    res.json(response);
})

app.get("/abi/read", async (req, res) => {
    const contents = await readFile(req.query.fullPath);

    res.write(contents);
    res.end()
});

app.listen(port, () => {
    console.log("Contracts playground backend started at port: "+ port);
});