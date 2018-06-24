Shader "Holistic/Sec3_21Chal" {
	Properties {
		_normal ("Normal map", 2D) = "bump" {}
		_myCube ("Cube Map", CUBE) = "white" {}
	}
	SubShader {
		LOD 200

		CGPROGRAM
		#pragma surface surf Lambert

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _normal;
        samplerCUBE _myCube;

		struct Input {
			float2 uv_myBump;
            float3 worldRefl; INTERNAL_DATA
		};
              
		void surf (Input IN, inout SurfaceOutput o) {
			// Albedo comes from a texture tinted by color
            o.Normal = UnpackNormal(tex2D (_normal, IN.uv_myBump))*0.3;
			o.Albedo = texCUBE (_myCube,  WorldReflectionVector (IN, o.Normal)).rgb;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
