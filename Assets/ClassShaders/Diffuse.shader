//Shadelab
//CG OR HLSL()

Shader "ACG/HelloWorld"{
	Properties{ //UI de Unity
		_myColor("Example Color", Color) = (1, 1, 1, 1)
	}
	SubShader{//CG o HLSL (High Level Shader Language)
		CGPROGRAM //<Compiler directive> <shader type> <shader func> <lighting model>
			#pragma surface surf Lambert
			struct Input{//Vertex nomarls uv
				float2 uvMainTex;
			};

			fixed4 _myColor;
			fixed4 _myEmission;

			void surf(Input IN, inout SurfaceOutput o){
				o.Albedo = _myColor.rgb;
			}

		ENDCG
	}
}