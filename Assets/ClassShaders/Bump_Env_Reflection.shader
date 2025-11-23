Shader "ACG/Bump_Env_Reflection" {
    Properties {
        _myTex("Diffuse Texture", 2D) = "white" {}
        _myNormalMap("Normal Texture", 2D) = "bump" {}
        _myBumpRange("Bump amount", Range(0,10)) = 1
        _BumpScale("Bump scale", Range(0,10)) = 1
        _Brightness("Bump brightness", Range(0,1)) = 1
        _Cube("Cubemap", Cube) = "_Skybox" {}
    }

    SubShader {
        CGPROGRAM
            #pragma surface surf Lambert

            sampler2D _myTex;
            sampler2D _myNormalMap;
            half _myBumpRange;
            half _Brightness;
            half _BumpScale;
            samplerCUBE _Cube;

            struct Input {
                float2 uv_myTex;
                float2 uv_myNormalMap;
                float3 worldRefl; INTERNAL_DATA
            };

            void surf(Input IN, inout SurfaceOutput o) {
                //o.Albedo = o.Normal.gbr;
                // o.Albedo = IN.worldRefl;
                o.Albedo = tex2D(_myTex, IN.uv_myTex * _BumpScale).rgb;
                o.Normal = UnpackNormal(tex2D(_myNormalMap, IN.uv_myNormalMap * _BumpScale)) * _Brightness;
                o.Normal.xy *= _myBumpRange;
                o.Emission = texCUBE(_Cube, WorldReflectionVector(IN, o.Normal)).rgb;
            }
        ENDCG
    }
}