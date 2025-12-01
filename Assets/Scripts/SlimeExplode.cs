using UnityEngine;
using System.Collections;

public class SlimeExplode : MonoBehaviour
{
    public float extrudeSpeed = 5f;
    public float finalExtrudeAmplitude = 50f;
    public float destroyDelay = 0.2f;

    Material mat;
    float initialAmplitude;
    bool exploding = false;

    void Start()
    {
        Renderer r = GetComponentInChildren<Renderer>();
        if (r == null)
        {
            Debug.LogError("No se encontró Renderer en el objeto o sus hijos.");
            return;
        }

        mat = Instantiate(r.material);
        r.material = mat;

        if (mat.HasProperty("_ExtrudeAmplitude"))
            initialAmplitude = mat.GetFloat("_ExtrudeAmplitude");
        else
            Debug.LogWarning("El material no tiene la propiedad _ExtrudeAmplitude. Asegúrate de usar ACG/ExtrudeShader.");
    }

    public void Explode()
    {
        if (!exploding)
            StartCoroutine(ExplodeRoutine());
    }

    IEnumerator ExplodeRoutine()
    {
        exploding = true;

        // Detener cualquier animación de respiración del shader
        mat.SetFloat("_ExtrudeSpeed", 0f);

        float t = 0;
        while (t < 1)
        {
            t += Time.deltaTime * extrudeSpeed;
            float newValue = Mathf.Lerp(initialAmplitude, finalExtrudeAmplitude, t);
            mat.SetFloat("_ExtrudeAmplitude", newValue);
            yield return null;
        }

        // Esperar un momento antes de destruir para ver el efecto
        yield return new WaitForSeconds(destroyDelay);
        Destroy(gameObject);
    }

    // Opcional: Para debug
    void OnMouseDown()
    {
        Explode();
    }
}