using UnityEngine;

public class PrintMeshData : MonoBehaviour
{
    // Start is called once before the first execution of Update after the MonoBehaviour is created
    void Start()
    {
        Mesh currentMesh = GetComponent<MeshFilter>().mesh;
        Vector3[] vertices = currentMesh.vertices;
        foreach (Vector3 v in vertices)
        {
            Debug.Log(v);
        }
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
