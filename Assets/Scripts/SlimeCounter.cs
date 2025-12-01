using UnityEngine;
using System.Collections;

public class SlimeCollector : MonoBehaviour
{
    public int requiredSlimes = 3;     
    private int collectedSlimes = 0;
    public Animator animator;
    public GameObject finalObject;  
    private Animator finalAnimator;

    
    void Start()
    {
        animator = GetComponent<Animator>();
        finalAnimator = finalObject.GetComponent<Animator>();
    }
    private void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("PickUp"))
        {
            StartCoroutine(CollectSlime(other.gameObject));  
        }
    }

    IEnumerator CollectSlime(GameObject slime)
    {
        yield return new WaitForSeconds(2f); 
        
        collectedSlimes++;

        Animator slimeAnim = slime.GetComponent<Animator>();
        if (slimeAnim != null)
        {
            slimeAnim.SetTrigger("fallingInBox");
        }

        Destroy(slime, 1f);

        if (collectedSlimes >= requiredSlimes)
        {
            Debug.Log("Todos los slimes recolectados");
            finalAnimator.SetTrigger("openingGate");
        }
    }
}
