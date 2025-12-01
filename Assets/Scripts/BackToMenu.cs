using UnityEngine;
using UnityEngine.SceneManagement;

public class BackToMenu : MonoBehaviour
{
    public string nombreDeLaEscenaMenu = "MainMenu";

    void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("Player"))
        {   
            Time.timeScale = 1f;

            SceneManager.LoadScene(nombreDeLaEscenaMenu);
        }
    }
}
