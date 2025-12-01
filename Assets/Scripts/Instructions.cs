using UnityEngine;

public class Instructions : MonoBehaviour
{
    public GameObject canvasInstrucciones;
    public MonoBehaviour movimientoJugador;
    public MonoBehaviour movimientoJugador1;



    bool activo = false;
    bool yaMostrado = false; 

    void Start()
    {
        if (canvasInstrucciones != null)
            canvasInstrucciones.SetActive(false);
    }

    void OnTriggerEnter(Collider other)
    {
        if (yaMostrado) return; 

        if (other.CompareTag("Player"))
        {
            activo = true;
            yaMostrado = true;  

            canvasInstrucciones.SetActive(true);

            if (movimientoJugador != null)
                movimientoJugador.enabled = false;
                movimientoJugador1.enabled = false;

        }
    }

    void Update()
    {
        if (activo)
        {
            if (Input.GetKeyDown(KeyCode.Space))
            {
                activo = false;
                canvasInstrucciones.SetActive(false);

                if (movimientoJugador != null)
                    movimientoJugador.enabled = true;
                    movimientoJugador1.enabled = true;

            }
        }
    }
}
