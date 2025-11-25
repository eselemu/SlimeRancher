using UnityEngine;

public class SlimeCollector : MonoBehaviour
{
    public int requiredSlimes = 3;     
    private int collectedSlimes = 0;
    public Animator animator;

    void Start()
    {
        animator = GetComponent<Animator>();
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("PickUp"))
        {
            CollectSlime(other.gameObject);   
        }
    }

    void CollectSlime(GameObject slime)
    {
        collectedSlimes++;

        Animator slimeAnim = slime.GetComponent<Animator>();
        if (slimeAnim != null)
        {
            slimeAnim.SetTrigger("fallingInBox");
        }

        Destroy(slime, 1f);

        if (collectedSlimes >= requiredSlimes)
        {
            Debug.Log("todos los slimes recolectados");
        }
    }
}
