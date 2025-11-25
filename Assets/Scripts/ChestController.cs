using UnityEngine;

public class ChestOpen : MonoBehaviour
{
    public Animator animator;
   

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


}
