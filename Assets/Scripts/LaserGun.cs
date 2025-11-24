using System.Collections;
using UnityEngine;

public class LaserGun: MonoBehaviour
{
    public Camera playerCamera;
    public Transform laserOrigin;
    public float gunRange = 50f;

    LineRenderer laserLine;

    public float holdDistance = 3f;   
    public float moveSpeed = 10f;     
    public LayerMask pickupMask;      
    private Rigidbody heldObject;     

    public bool laserActive = false; 

    void Awake()
    {
        laserLine = GetComponent<LineRenderer>();
        laserLine.enabled = false;
    }

    void Update()
    {
        if (Input.GetKeyDown(KeyCode.Z))
        {
            laserActive = !laserActive; 
            laserLine.enabled = laserActive;

            if (!laserActive && heldObject != null)
                DropObject();
        }

        if (laserActive)
        {
            RenderLaser();
            TryPickupObject();
        }

        if (heldObject != null)
            MoveObject();
    }

    void RenderLaser()
    {
        laserLine.SetPosition(0, laserOrigin.position);

        Ray ray = playerCamera.ViewportPointToRay(new Vector3(0.5f, 0.5f, 0));
        RaycastHit hit;

        if (Physics.Raycast(ray, out hit, gunRange))
            laserLine.SetPosition(1, hit.point);
        else
            laserLine.SetPosition(1, ray.origin + ray.direction * gunRange);
    }

    void TryPickupObject()
    {
        if (heldObject != null)
            return;

        Ray ray = playerCamera.ViewportPointToRay(new Vector3(0.5f, 0.5f, 0));
        RaycastHit hit;

        if (Physics.Raycast(ray, out hit, gunRange, pickupMask))
        {
            Rigidbody rb = hit.collider.GetComponent<Rigidbody>();
            if (rb != null)
            {
                heldObject = rb;
                heldObject.useGravity = false;
                heldObject.drag = 10f;
            }
        }
    }

    void MoveObject()
    {
        Vector3 targetPos = playerCamera.transform.position + playerCamera.transform.forward * holdDistance;
        Vector3 direction = targetPos - heldObject.position;
        heldObject.velocity = direction * moveSpeed;
    }

    void DropObject()
    {
        if (heldObject == null) return;

        heldObject.useGravity = true;
        heldObject.drag = 1f;
        heldObject = null;
    }
}
