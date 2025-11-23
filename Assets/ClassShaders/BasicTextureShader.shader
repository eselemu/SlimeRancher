Shader "ACG/BasicTextureBlend" {
Properties{
		_MainTex ("Main Texture", 2D) = "white" {}
		_StickerTex ("Sticker Texture", 2D) = "white" {}
		[Toggle] _ShowSticker ("Show Sticker", Float) = 0
	}
	SubShader{
		Tags{
			"Queue" = "Geometry"
		}

		CGPROGRAM
		#pragma surface surf Lambert

		sampler2D _MainTex;
		sampler2D _StickerTex;
		float _ShowSticker;

		struct Input {
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutput o) {
			fixed4 a = tex2D(_MainTex, IN.uv_MainTex);
			fixed4 b = tex2D(_StickerTex, IN.uv_MainTex) * _ShowSticker;
			float th = 0.9;
			//o.Albedo = a.rgb+b.rgb;
			o.Albedo = b.r > th ? b.rgb : a.rgb;
		}
		ENDCG
	}
	FallBack "Diffuse"

}
