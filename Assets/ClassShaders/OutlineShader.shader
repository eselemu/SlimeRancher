Shader "ACG/ToonOutlineShader" {
    Properties {
        _MainTex ("Main Texture", 2D) = "white" {}
        _Colour ("Base Colour", Color) = (1,1,1,1)
        _RampTex ("Ramp Texture", 2D) = "gray" {}
        _OutlineColor ("Outline Color", Color) = (0,0,0,1)
        _Outline ("Outline Width", Range(0.002, 0.5)) = 0.005
    }

    SubShader {

        CGPROGRAM
        #pragma surface surf toonRamp

        sampler2D _MainTex;
        sampler2D _RampTex;
        fixed4 _Colour;

        struct Input {
            float2 uv_MainTex;
        };
        half4 LightingtoonRamp(SurfaceOutput s, fixed3 lightDir, fixed atten) {
            float diff = dot(s.Normal, lightDir);
            float h = diff * 0.5 + 0.5;
            float2 rh = h;
            float3 rampFactor = tex2D(_RampTex, rh).rgb;

            half4 c;
            c.rgb = s.Albedo * rampFactor * _LightColor0.rgb * atten;
            c.a = s.Alpha;
            return c;
        }

        void surf (Input IN, inout SurfaceOutput o) {
            fixed4 tex = tex2D(_MainTex, IN.uv_MainTex) * _Colour;
            o.Albedo = tex.rgb;
            o.Alpha = tex.a;
        }

        ENDCG

        Pass {
            Cull Front

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            float4 _OutlineColor;
            float _Outline;

            struct appdata {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2f {
                float4 pos : SV_POSITION;
                float4 color : COLOR;
            };

            v2f vert (appdata v) {
                v2f o;
                float3 norm = normalize(mul((float3x3)UNITY_MATRIX_IT_MV, v.normal));
                float4 pos = UnityObjectToClipPos(v.vertex);
                float2 offset = TransformViewToProjection(norm.xy);

                pos.xy += offset * pos.z * _Outline;
                o.pos = pos;
                o.color = _OutlineColor;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target {
                return i.color;
            }
            ENDCG
        }
    }

    FallBack "Diffuse"
}
