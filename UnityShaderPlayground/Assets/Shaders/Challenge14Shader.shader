Shader "Holistic/Challenge14Shader" {

    Properties {
		_DiffuseTex ("DiffuseTex", 2D) = "white" {}
		_EmissiveTex ("EmissiveTex", 2D) = "white" {}
	}
    
	SubShader {
		
		CGPROGRAM       
		#pragma surface surf Lambert

        sampler2D _DiffuseTex;
        sampler2D _EmissiveTex;

		struct Input {
			float2 uv_DiffuseTex;
            float2 uv_EmissiveTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			o.Emission = tex2D (_EmissiveTex, IN.uv_EmissiveTex).rgb;
            o.Albedo = tex2D (_DiffuseTex, IN.uv_DiffuseTex).rgb;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
