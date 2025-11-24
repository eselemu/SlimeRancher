using UnityEngine;

public class ChestOpen : MonoBehaviour
{
    public Animator animator;
     public int requiredSlimes = 3;           // Cantidad necesaria
    private int collectedSlimes = 0;
    private bool chestOpened = false;
    public GameObject[] slime;

    void Start()
    {
        animator = GetComponent<Animator>();
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("Player"))
        {
            animator.SetBool("isOpened", true);
            animator.SetTrigger("getOpen");   // Abrir
            chestOpened = true;
        }

         if (other.CompareTag("PickUp") && chestOpened)

        {
            CollectSlime(other.gameObject);

        }
    }

    private void OnTriggerExit(Collider other)
    {
        if (other.CompareTag("Player"))
        {
            animator.SetBool("isOpened", false);
            animator.SetTrigger("getClosed");  // Cerrar
        }
    }

    void CollectSlime(GameObject slime)
    {
        collectedSlimes++;

        // OPCIÓN 1: el slime reproduce una animación antes de desaparecer
        Animator slimeAnim = slime.GetComponent<Animator>();
        if (slimeAnim != null)
        {
            slimeAnim.SetTrigger("fallingInBox");
        }


        // SI YA ENTRARON TODOS LOS SLIMES
        if (collectedSlimes >= requiredSlimes)
        {
            Debug.Log("listo");
        }
    }

}
