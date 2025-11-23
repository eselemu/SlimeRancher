Shader "ACG/StandarPBR"{

	Properties{
			_myColor("Color",Color) = (1,1,1,1)
			_myMetallicTex("Metallic Texture",2D) = "white" {}
			_myMetallic("Metallic", Range(0.0,1.0)) = 0.1
			_myEmission("Emission", Range(0.0,1.0)) = 0.1

		}


	SubShader{
		CGPROGRAM
		#pragma surface surf Standard

		float4 _myColor;
		sampler2D _myMetallicTex;
		half _myMetallic;
		half _myEmission;

		struct Input{
				float2 uv_myMetallicTex;
			};


		void surf(Input IN, inout SurfaceOutputStandard o){
			o.Albedo = _myColor.rgb;
			o.Metallic = _myMetallic;
			o.Smoothness = tex2D( _myMetallicTex, IN.uv_myMetallicTex).r;
			o.Emission = tex2D( _myMetallicTex, IN.uv_myMetallicTex).r*_myEmission;

		}


		ENDCG
		}


	}