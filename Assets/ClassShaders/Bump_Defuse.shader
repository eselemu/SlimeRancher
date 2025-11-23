Shader "ACG/Bump_Defuse" {
    Properties {
        _Texture ("Diffuse Texture", 2D) = "white" {}
        _NormalMap ("Normal Map", 2D) = "bump" {}
        _BumpRange ("Bump amount", Range(0,10)) = 1
    }

    SubShader {
        CGPROGRAM
            #pragma surface surf Lambert

            sampler2D _Texture;
            sampler2D _NormalMap;
            half _BumpRange;

            struct Input {
                float2 uv_Texture;
                float2 uv_NormalMap;
            };

            void surf(Input IN, inout SurfaceOutput o) {
                o.Albedo = tex2D(_Texture, IN.uv_Texture).rgb;
                o.Normal = UnpackNormal(tex2D(_NormalMap, IN.uv_NormalMap));
                o.Normal.xy *= _BumpRange;
            }

        ENDCG
    }
}