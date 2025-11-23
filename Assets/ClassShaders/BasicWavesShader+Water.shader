    Shader "ACG/WavesShader" {
    Properties {
      _MainTex("Water Texture", 2D) = "white" {}
      _Tint("Colour Tint", Color) = (1,1,1,1)
      _Freq("Frequency", Range(0,5)) = 3
      _Speed("Speed",Range(0,100)) = 10
      _Amp("Amplitude",Range(0,1)) = 0.5
      _Foam("Foam Texture", 2D) = "white" {}
      _ScrollX("Scroll x", Range(-5, 5)) = 1
      _ScrollY("Scroll Y", Range(-5, 5)) = 1
    }
    SubShader {
      CGPROGRAM
        #pragma surface surf Lambert vertex:vert
        
        struct Input {
            float2 uv_MainTex;
            float3 vertColor;
        };

        sampler2D _MainTex;
        float4 _Tint;
        float _Freq;
        float _Amp;
        float _Speed;
        sampler2D _Foam;
        float _ScrollX;
        float _ScrollY;

        struct appdata{
          float4 vertex: POSITION;
          float3 normal: NORMAL;
          float4 texcoord: TEXCOORD0;
          float4 texcoord1: TEXCOORD1;
          float4 texcoord2: TEXCOORD2;
        };

        void vert (inout appdata v, out Input o){
          UNITY_INITIALIZE_OUTPUT(Input, o);
          float t = _Time * _Speed;
          float waveHeight = sin(t + v.vertex.x * _Freq) * _Amp + 
                             sin(t + v.vertex.z)*_Amp;
          float waveSea = sin(t + v.vertex.x * _Freq) * _Amp;
          v.vertex.y += waveHeight;
          v.normal = normalize(float3(v.normal.x + waveHeight, v.normal.y, v.normal.z));
          o.vertColor = waveHeight + 2;
        }

        void surf (Input IN, inout SurfaceOutput o) {
            //float4 c = tex2D(_MainTex, IN.uv_MainTex);
            //o.Albedo = c * IN.vertColor.rgb;
            _ScrollX *= _Time;
            _ScrollY *= _Time;
            //float2 newUV = IN.uv_MainTex + float2(_ScrollX, _ScrollY);
            //o.Albedo = tex2D(_MainTex, newUV);
            float3 water = (tex2D(_MainTex, IN.uv_MainTex +float2(_ScrollX, _ScrollY))).rgb;
            float3 foam = (tex2D(_Foam, IN.uv_MainTex+float2(_ScrollX/2.0, _ScrollY/2.0))).rgb;
            o.Albedo = ((water+foam)/2.0)*IN.vertColor;
        }
      ENDCG

    } 
    Fallback "Diffuse"
  }
