Shader "Custom/BasicStickerShader"{
Properties{
		_MainTex ("Main Texture", 2D) = "white" {}
		_StickerTex ("Sticker Texture", 2D) = "white" {}
		[Toggle] _ShowSticker("Show Sticker", Float) = 0
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
			fixed4 main = tex2D(_MainTex, IN.uv_MainTex);
			fixed4 sticker= tex2D(_StickerTex, IN.uv_MainTex);
			float th = 0.9;
			o.Albedo = (sticker.r >= th && _ShowSticker > 0) ? sticker.rgb : main.rgb;
		}
		ENDCG
	}
	FallBack "Diffuse"

}