Shader "ACG/RimShader" 
{
    Properties {
        _rimColor ("Rim Color", Color) = (1,1,1,1)
        _rimPower ("Rim Power", Range(0, 5)) = 0
    }

    SubShader {
        CGPROGRAM
            #pragma surface surf Lambert
            
            float _rimPower;
            fixed4 _rimColor;

            struct Input {
                float3 viewDir;
            };

            void surf(Input IN, inout SurfaceOutput o) {
                half rim = dot(normalize(IN.viewDir), o.Normal);
                half negRim = 1 - rim;
                half intensity = pow(rim, _rimPower);
                half negIntensity = pow(negRim, _rimPower);

                o.Emission = _rimColor.rgb * negIntensity;
            }
        ENDCG
    }
}