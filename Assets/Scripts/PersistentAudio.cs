using UnityEngine;

public class PersistentAudio : MonoBehaviour
{
    private static PersistentAudio instance;

    void Awake()
    {
        if (instance == null)
        {
            instance = this;
            DontDestroyOnLoad(gameObject);
        }
        else
        {
            Destroy(gameObject);
        }
    }
}