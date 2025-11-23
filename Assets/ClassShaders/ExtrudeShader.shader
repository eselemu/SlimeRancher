Shader "ACG/ExtrudeShader" {
    Properties {
        _MainTex ("Texture", 2D) = "white" {}
        _ExtrudeSpeed ("Extrude Speed", Range(0,10)) = 1.0
        _ExtrudeAmplitude ("Extrude Amplitude", Range(0,1)) = 1.0
    }

    SubShader {
        CGPROGRAM
        #pragma surface surf Lambert vertex:vert

        struct Input {
            float2 uv_MainTex;
        };

        sampler2D _MainTex;
        float _ExtrudeSpeed;
        float _ExtrudeAmplitude;

        struct appdata {
            float4 vertex : POSITION;
            float3 normal : NORMAL;
            float4 texcoord : TEXCOORD0;
        };

        void vert (inout appdata v) {
            // Movimiento suave tipo “respiración”
            float breathing = sin(_Time.y * _ExtrudeSpeed) * _ExtrudeAmplitude;
            v.vertex.xyz += v.normal * breathing;
        }

        void surf (Input IN, inout SurfaceOutput o) {
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
        }

        ENDCG
    }

    Fallback "Diffuse"
}
