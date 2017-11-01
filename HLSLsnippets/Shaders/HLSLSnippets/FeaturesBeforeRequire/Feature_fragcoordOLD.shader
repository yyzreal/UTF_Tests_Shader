﻿Shader "FTPCustom/HLSLSnippets/FeatureBeforeRequire/fragcoord"
{
	Properties
	{
		_MainTex("_MainTex (RGBA)", 2D) = "white" {}
	}
		SubShader
	{
		Tags{ "RenderType" = "Opaque" }
		LOD 200

		Pass
	{
		CGPROGRAM
#pragma target 3.0
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

	v2f vert(appdata v)
	{
		v2f o;
		o.vertex = UnityObjectToClipPos(v.vertex);
		o.uv = o.vertex.xy/o.vertex.w;
		
		return o;
	}

	fixed4 frag(v2f i) : SV_Target
	{
		fixed4 col = float4(i.uv,0,1);
	return col;
	}
		ENDCG
	}
	}
}