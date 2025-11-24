Shader "ACG/Hologram"
{
    Properties{
		_rimPower("Rim Power", Range(0.3,4)) = 0.3
		_myColor ("Example Color", Color) = (1,1,1,1)
	
	}

	SubShader{


        Tags {"Queue" = "Transparent"}

        Pass {
            ZWrite On
            ColorMask 0
        }

		CGPROGRAM	
			
			#pragma surface surf Lambert alpha:fade
			struct Input{
				
				float3 viewDir;
			
			
			};

			float _rimPower;
			fixed4 _myColor;

			void surf(Input IN, inout SurfaceOutput o){

				half rim = dot(normalize(IN.viewDir), o.Normal);
				half NegativeRim = 1-dot(normalize(IN.viewDir), o.Normal);
				o.Emission = _myColor*pow(NegativeRim,_rimPower);
                o.Alpha = pow(NegativeRim,_rimPower);

				}

		ENDCG
	}






}
