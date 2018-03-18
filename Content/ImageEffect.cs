using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class ImageEffect : MonoBehaviour 
{

	public Material mat;
	public DepthTextureMode mode;

	void OnRenderImage (RenderTexture src, RenderTexture dst)
	{	
		if (mat != null)
			Graphics.Blit (src, dst, mat);
	}

	void Update ()
	{
		GetComponent<Camera>().depthTextureMode = mode;
	}
}