﻿//https://docs.unity3d.com/Manual/SparseTextures.html
Shader "FTPCustom/HLSLSnippets/FeatureBeforeRequire/sparsetex"
{
	Properties 
	{
		_Amount ("Extrusion Amount", Range(-1,1)) = 0.5
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
	}
	SubShader 
	{
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Standard fullforwardshadows vertex:vert
		//#pragma require sparsetex
		//#pragma fragmentoption 
			//ARB_sparse_texture


		sampler2D _MainTex;

		struct Input 
		{
			float2 uv_MainTex;
		};

		half _Glossiness;
		half _Metallic;
		fixed4 _Color;
		float _Amount;

		void vert (inout appdata_full v, out Input o) 
	    {
	          UNITY_INITIALIZE_OUTPUT(Input,o);

	          UNITY_SETUP_INSTANCE_ID (v);

	          v.vertex.xyz += v.normal * _Amount;
	    }

		void surf (Input IN, inout SurfaceOutputStandard o) 
		{
			fixed4 c = fixed4(1,0,0,1);// tex2D(_MainTex, IN.uv_MainTex) * _Color;

			#ifdef UNITY_COMPILER_HLSL2GLSL
			float4 Fetch = float4(0, 0, 0, 0);
			int Code = sparseTexture(_MainTex, IN.uv_MainTex, Fetch);
			if (sparseTexelResident(Code))
			{
				c = Fetch * float4(0, 1, 0, 1);
			}
			else
			{
				c = float4(1, 1, 0, 1);
			}
			#endif

			o.Albedo = c.rgb;
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha = c.a;
			//o.Emission = 0;
			//o.Normal fixed3
			//o.Occlusion = 1;
		}
		ENDCG
	}
}
