using UnityEngine;
using UnityEngine.SceneManagement;

public class SceneChanger : MonoBehaviour
{   
    public GameObject TeamPanel;
    public GameObject MainMenuPanel;
    public GameObject ObjectivePanel;

   

    public void LoadSceneByIndex(int sceneIndex)
    {
        SceneManager.LoadScene(sceneIndex);
    }

    public void ReloadCurrentScene()
    {
        Scene currentScene = SceneManager.GetActiveScene();
        SceneManager.LoadScene(currentScene.name);
    }

    public void ShowPanel(GameObject panel)
    {   
        if (panel.name == "ObjectivePanel")
        {
            MainMenuPanel.SetActive(false);
            ObjectivePanel.SetActive(true);
        }
        else if (panel.name == "TeamPanel")
        {
            MainMenuPanel.SetActive(false);
            TeamPanel.SetActive(true);
        }
    }
}
