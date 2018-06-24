Shader "Holistic/BumpedDiffuse" {
	Properties {
		_myDiffuse ("Diffuse Texture", 2D) = "white" {}
        _myBump ("Normal Texture", 2D) = "bump" {}
        _mySlider ("Bump Amount", Range(0,10)) = 1
        _myBrightness ("Brigth Amount", Range(1,10)) = 1
        _myCube ("Cube Map", CUBE) = "white" {}
	}
    
	SubShader {      
		CGPROGRAM
		#pragma surface surf Lambert

		#pragma target 3.0

		sampler2D _myDiffuse;
        sampler2D _myBump;
        half _mySlider;
        half _myBrightness;
        samplerCUBE _myCube;
		struct Input {
			float2 uv_myDiffuse;
            float2 uv_myBump;
            float3 worldRefl; INTERNAL_DATA
		};

		void surf (Input IN, inout SurfaceOutput o) {
			o.Albedo = tex2D (_myDiffuse, IN.uv_myDiffuse).rgb;
            //o.Albedo = texCUBE (_myCube, IN.worldRefl).rgb;
            o.Normal = UnpackNormal(tex2D (_myBump, IN.uv_myBump))*_myBrightness;
            o.Normal += float3(_mySlider, _mySlider, 1);
            o.Emission = texCUBE (_myCube, WorldReflectionVector (IN, o.Normal)).rgb;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
