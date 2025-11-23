Shader "AGC/ShaderProperties" 
{
    Properties
    {
        _rimColor("Rim Color", Color) = (1,1,1,1)
        _rimPower("Rim Power", Range(0, 1)) = 0
    }

    SubShader {
        CGPROGRAM
            #pragma surface surf Lambert

            struct Input {
                float3 viewDir;
            };

            float4 _rimColor;
            float _rimPower;

            void surf(Input IN, inout SurfaceOutput o) {
                half rim = saturate(dot(normalize(IN.viewDir), o.Normal)); // -1 to 1
                //Ternary operator
                // condition ? value_if_true : value_if_false
                o.Emission = rim > 0.7 ? _rimColor * _rimPower : rim > 0.5 ? float3(1,0,0) : float3(0,0,0);
            }
        ENDCG
    }
}