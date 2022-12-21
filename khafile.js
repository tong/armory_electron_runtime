const project = new Project('electron-runtime');
if (platform !== Platform.HTML5) {
    resolve(project);
    return;
}
(async function main() {
    process.stdout.write('   \n');
    if(process.argv.indexOf('--electron-pack') != -1) {
        project.addLibrary('electron');
        project.addDefine("electron_renderer");
        project.addSources("Sources");
        project.addAssets('armory-electron-runtime-linux-x64/**', { notinlist: true });
    }
    if(project.defines.indexOf('arm_patch')) {
        //project.addParameter("armory.trait.internal.LivePatch");
    }
    resolve(project);
})();

