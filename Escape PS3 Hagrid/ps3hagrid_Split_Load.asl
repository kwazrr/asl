state("Escape PS3 Hagrid") {}

startup {
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.LoadSceneManager = true;
}

init {
  current.activeScene = "";
  current.loadingScene = "";
}

update {
    current.activeScene = vars.Helper.Scenes.Active.Name ?? current.activeScene;
    current.loadingScene = vars.Helper.Scenes.Loaded[0].Name ?? current.loadingScene;


    if(old.activeScene != current.activeScene) print(old.activeScene + "->" + current.activeScene);
    if(old.loadingScene != current.loadingScene) print(old.loadingScene + "->" + current.loadingScene);
}

start {
    return old.activeScene[0] == '0' && current.activeScene[0] == '1';
}

split {
    return old.activeScene[0] < current.activeScene[0];
}

isLoading {
    return current.activeScene != current.loadingScene;
}
