Shader "Holistic/Rim" {
	Properties {
		_RimColor ("Rim Color", Color) = (0,0.5,0.5,0.0)
        _RimPower ("Rim Power", Range(0.5,8.0)) = 3.0
        _DiffuseTex ("Tex", 2D) = "white" {}
        _StripSize ("StripeSize", Range(0.1, 0.8)) = 0.4
	}
	SubShader { 

		CGPROGRAM
		#pragma surface surf Lambert
      
		struct Input {
			float3 viewDir;
            float3 worldPos;
            float2 uv_DiffuseTex;
		};
        
		fixed4 _RimColor;
        float _RimPower;
        sampler2D _DiffuseTex;
        float _StripSize;

		void surf (Input IN, inout SurfaceOutput o) {
			half rim = 1 - saturate (dot(normalize(IN.viewDir), o.Normal));
            o.Emission = frac(IN.worldPos.y+10 *0.5) > _StripSize ? 
            float3(0,1,0)*rim:float3(1,0,0) * rim;
            o.Albedo = tex2D(_DiffuseTex, IN.uv_DiffuseTex).rgb;
            //o.Emission = IN.worldPos.y > 1 ? float3(0,1,0):float3(1,0,0);
			//o.Emission = rim > 0.5 ? float3(1,0,0) : rim > 0.3 ? float3(0,1,0):0;
            // /*_RimColor.rgb * */ rim > 0.5 ? float3(1,0,0):0;//* pow(rim,_RimPower);
		}
		ENDCG
	}
	FallBack "Diffuse"
}
