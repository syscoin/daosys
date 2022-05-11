import fs from 'fs'

interface InjectContractItem {
    [key: string]: string;
}

export const InjectFrontend = async (contracts: InjectContractItem, frontendPath: string) => {
    fs.readFile(frontendPath, "r", (err, contents)   => {
        if (err) {
            throw new Error("Can not read file.")
        }

        const _contracts = JSON.parse(contents);
        const _newContracts = {};


        for (const item of _contracts) {
            
        }


    });



    fs.writeFile(frontendPath, JSON.stringify(contracts, null, 4), (results) => {
        console.log(`Save files result. ${results}`);
    });
}