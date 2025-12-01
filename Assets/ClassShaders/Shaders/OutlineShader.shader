Shader "ACG/OutlineShader"
{
    Properties
    {
        _MainTex("Texture", 2D) = "white" {}
        _OutlineColor("Outline Color", Color) = (0,0,0,1)
        _Outline("Outline Width", Range(.001, .1)) = .015   

        // Toon ramp
        _Colour("Colour", Color) = (1,1,1,1)
        _RampTex("Ramp Texture", 2D) = "white" {}
    }

    SubShader
    {
        // ===== PASS DE SUPERFICIE (TOON) =====
        CGPROGRAM
        #pragma surface surf ToonRamp fullforwardshadows
        #pragma target 3.0

        struct Input { float2 uv_MainTex; };

        sampler2D _MainTex;
        float4 _Colour;
        sampler2D _RampTex;

        float _UseProceduralRamp;
        float _Steps;
        float _ShadowBoost;

        half4 LightingToonRamp (SurfaceOutput s, fixed3 lightDir, fixed atten)
        {
            float ndl = dot(s.Normal, lightDir);      // [-1..1]
            float h   = ndl * 0.5 + 0.5;              // [0..1]

            float rampX;
            if (_UseProceduralRamp > 0.5)
            {
                float bands = max(2.0, _Steps);
                rampX = floor(h * bands) / (bands - 1.0);
            }
            else
            {
                rampX = tex2D(_RampTex, float2(h, 0.5)).r;
            }

            rampX = saturate(lerp(rampX, rampX * rampX, _ShadowBoost));

            float3 col = s.Albedo * rampX * _LightColor0.rgb * atten;
            return half4(col, s.Alpha);
        }

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed3 baseTex = tex2D(_MainTex, IN.uv_MainTex).rgb;
            o.Albedo = baseTex * _Colour.rgb;
            o.Alpha  = _Colour.a;
        }
        ENDCG


        // ===== PASS DEL OUTLINE  =====
        Pass
        {
            Name "OUTLINE"
            Cull Front
            ZWrite On
            ZTest  LEqual
            Offset 1,1                

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 pos   : SV_POSITION;
                float4 color : COLOR;
            };

            float4 _OutlineColor;
            float  _Outline;

            v2f vert (appdata v)
            {
                v2f o;
              
                o.pos = UnityObjectToClipPos(v.vertex);

                float3 nView = mul((float3x3)UNITY_MATRIX_IT_MV, normalize(v.normal));
                float2 nProj = TransformViewToProjection(normalize(nView).xy);

                o.pos.xy += nProj * _Outline * o.pos.w;

                o.color = _OutlineColor;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                return i.color;
            }
            ENDCG
        }
    }

    Fallback "Diffuse"
}
