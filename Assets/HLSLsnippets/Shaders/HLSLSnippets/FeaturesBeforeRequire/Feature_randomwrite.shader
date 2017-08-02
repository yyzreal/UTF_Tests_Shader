﻿Shader "FTPCustom/HLSLSnippets/FeatureBeforeRequire/randomwrite"
{
	Properties
	{
		_Color("Color", Color) = (1,1,1,1)
		_MainTex("_MainTex (RGBA)", 2D) = "white" {}
	}
		SubShader
	{
		Tags{ "RenderType" = "Opaque" }
		LOD 200

		Pass
	{
		CGPROGRAM
#pragma target 4.5
#pragma vertex vert
#pragma fragment frag

#include "UnityCG.cginc"

		struct appdata
	{
		float4 vertex : POSITION;
		float2 uv : TEXCOORD0;
	};

	struct v2f
	{
		float2 uv : TEXCOORD0;
		float4 vertex : SV_POSITION;
	};

	sampler2D _MainTex;
	float4 _MainTex_ST;
	float4 _Color;

	RWTexture2D<float4> uav: register(u1);
	//Texture2D tex 

	v2f vert(appdata v)
	{
		v2f o;
		o.vertex = UnityObjectToClipPos(v.vertex);
		o.uv = TRANSFORM_TEX(v.uv, _MainTex);
		return o;
	}

	fixed4 frag(v2f i) : SV_Target
	{
		fixed4 col = tex2D(_MainTex, i.uv);

		uav[i.uv] = col+_Color;

		fixed4 tex = uav[i.uv];

		return tex;
	}
		ENDCG
	}
	}
}
