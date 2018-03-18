Shader "Unlit/Cel Shader"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}

		_Edge ("Edge", Range(0, 1)) = 0

		_EdgeColor ("Edge Color", Color) = (1, 1, 1, 1)
		_InnerColor ("Inner Color", Color) = (1, 1, 1, 1)

		_Shades ("Shades", Int) = 5
		_OccludedShades ("Occluded Shades", Int) = 3
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
				float4 normal : NORMAL;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
				float scale : FLOAT;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;

			half _Edge;
			half _Shades;
			half _OccludedShades;

			half4 _InnerColor;
			half4 _EdgeColor;
		
			
			v2f vert (appdata v)
			{
				v2f o;
								
				v.vertex = mul(unity_ObjectToWorld, v.vertex);
				
				float3 viewDir = mul(unity_WorldToObject, normalize(WorldSpaceViewDir(v.vertex)));

				float fCos = dot(v.normal, viewDir);

				o.scale = fCos;
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				v.vertex = mul(unity_WorldToObject, v.vertex);
				o.vertex = UnityObjectToClipPos(v.vertex);

				return o;
			}

			fixed4 frag (v2f i) : SV_Target
			{
				float4 color;

				float scale = i.scale;

				int scaleFactor = floor(i.scale * _Shades);
				scale = scaleFactor / _Shades;

				if (scale < _OccludedShades / _Shades)
				{
					color = _EdgeColor;
				}
				else
				{
					color = (_InnerColor * scale) + _InnerColor / _Shades;
				}

				return color;

				return _InnerColor;
			}
			ENDCG
		}
	}
}
