state("Escape PS2 Hagrid", "1.2") {
    float BossHealth : "UnityPlayer.dll", 0x019FF440, 0x20, 0x0, 0x130, 0x88, 0x30, 0x18, 0x48;
}

startup {
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.LoadSceneManager = true;
    settings.Add("Version", true, "End split on V1.2");
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
    if(old.BossHealth != current.BossHealth) print(old.BossHealth + "-" + current.BossHealth);
}

start {
    return old.activeScene == "MainMenu" && current.activeScene == "Azkaban";
}

split { 
    return ((old.activeScene != current.activeScene) && 
        (old.activeScene != "MainMenu") && 
        (current.activeScene != "HagridBoss") && 
        (current.activeScene != "AstronomyTower") && 
        (current.activeScene != "MainMenu")) ||
        (current.BossHealth <= 0 && old.BossHealth > 0);
}

reset {
    return old.activeScene == "MainMenu" && current.activeScene == "Azkaban";
}

isLoading {
    return current.activeScene != current.loadingScene;
}