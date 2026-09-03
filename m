Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DFB3164C5
	for <linux-can@vger.kernel.org>; Thu,  3 Sep 2026 08:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788424145; cv=none; b=soLED3DJxFbJ/rYruXu9dNeT/C54zTV/EJLhMldlvuTRVSl47/Ax5S9rIQb8UnFUhBOejqtDWJqzauvBoejWtLhI7IXbPepCEy1WVySqWHMcZrAlmmegyflhiZTgPCdm8t0FHyr4w8J7sgo1KTuvFacCDLze80I0stgFzuGR6Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788424145; c=relaxed/simple;
	bh=j/YkXCRb+DA7nNO9q31K7pBUxD0nnB4tRARb3P9panw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=l9NYxxWs3Yc4YXjiL45WGPACNnb/pOdVtpRCDjUgSaS+Nn56iwPGoscVeuxcxJwxJR4yTephZDnukdpCiVQpuCEkCRqgRNOD5W/9DANppjVeEwlvvGRyp5k1I5tL2v4haaeRVi35GHP5uO0ef5j4TNsBZ1ehZF9V2lKM31T9q40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=mRFGQaQd; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="mRFGQaQd"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47de0093c42so2101671f8f.3
        for <linux-can@vger.kernel.org>; Thu, 03 Sep 2026 01:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788424141; x=1789028941; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=G4vKdHGO8+zOlAPBdoXMqgNoiUhAKGdphTDuXcL4XSA=;
        b=mRFGQaQde7qdWnv+c98cI5KLyy/7vLcC8qeD9geIQc+8meImGBg7E2P6M+RiM5FP8Y
         znQoySRkWarZkGMDGV93PPL6m4iXWuy74nkscUMmRYaaTpY35QUwXa2vm+ovvm1fCnU3
         k+0mLyNheymZn6BYr7bg1qZwpX5vFSy815omfyPycxGMyrhQ91pcVFIocR9NWZQdLE/a
         1+zbTYsgEl6M60qQeXjBhd7eo8fQQmA2D5cOaBPEhAVFg1t1Pxov+pcwCChLqMLPkaA1
         3LRKwntbu4qUyV5VOZeL1Tbh45EgGZN2d9zLp5qAeVbV8OfCZDy0w04WP9ktkTpc2wQZ
         ohWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788424141; x=1789028941;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=G4vKdHGO8+zOlAPBdoXMqgNoiUhAKGdphTDuXcL4XSA=;
        b=g6gA41CN9vjolNzCvFJOSDy4bZEMyPaCxL6wI75cb4KlnEETuw81WG4BAjZQH1D1SN
         WOhSTJFZ/uWtpS78kCRmPHNURtghbV6hJ9OeYZIdqpa3JcoOzmguwSi3LE8KVXddG3v5
         v6B0QscVv7BAJwcP+UKO59aJSPsWfIFX+fa8T166R3VA8RUfV8pEQiSnMvniLCIvzij2
         1ebF48bxb8XmKwTvGjC95kjUDBO6r9LLjskuYOaHLerBT7goJ603EFVXm0qZJp9DGU4A
         Gi2fRV1oJsJ3L2AYpvCeiWeEUCOo0T0MRTUorN+lqB9y+LOtPRVcbD68fqfqd92EUnpt
         9jvg==
X-Forwarded-Encrypted: i=1; AKwUvBzWUP8OsvsBWjfQVBAIootncRHUmhEvV1Vv0Xu6lxPDvSYS0eprdjvYdPl37k8S2rBYFdZBPdquAOA=@vger.kernel.org
X-Gm-Message-State: AFuF++ltD+qPewrjc917SPnmBu/0K5ZD3QhKixB2aXyppTFSzta3vFpn
	9Aq7s+c9ev1jBoi1R4iViX4Ph5JPC7RAjMLA7+oO2aUMSflArQtE0kR8OHIZkvyyFco=
X-Gm-Gg: AYBFou3HY+UzFDni/rheKuoUB71v3JnwVNXAwekvSFhAvJ5uQPamx8saUSXPFKm+248
	vOL8WZDKTZyufaTxW0ssCP6Wn+T61Kj5N8DfDmDtzKzzG2oyUlI39ovY6gdNBh4tcxgVPqzRD6z
	ysBj1KN+fVV1EqFzVW69wNjFsupDWkKeubrmBaJF3GGHmcTfxYa1d6xsvxhrmIzeKn8FxuavJO2
	gT6FSpUQ7jvlfO9iaEF90deavYx45ZQqYIZWcHYXfaLfnZyCXmg9hKpD+QDx3fgZGKtRjOrXolr
	KwCQepqhTpK4U0z34gBS1Uw5NWfTH7qaxyk0vl69z/WdrqqF7MYy8d7oE2CTnGgxdJyyNSzHF5g
	DgAHpk8RZbGUkgOeZSrwyERB5AU6BzIQU9eUkD1AVA1I88ROvQ4EWdsZj9OPN5VKXEMYn2KwFDB
	6Dvzbpm6ydS1rnpO4c8P2q2eco9FUmoNUafmMIB5e5SnpbzlmLc9tVE28h
X-Received: by 2002:a05:6000:186e:b0:47f:8b24:ef01 with SMTP id ffacd0b85a97d-48488deedd2mr18283862f8f.1.1788424140416;
        Thu, 03 Sep 2026 01:29:00 -0700 (PDT)
Received: from localhost ([2001:4090:a244:80d4:489b:7642:1b32:84d6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448eea5b4sm12497978f8f.27.2026.09.03.01.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 01:28:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=a15e01d85f8a611c40ff4ae9385bc153f1f9fa83a0571b2a8a2491377b30;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 03 Sep 2026 10:28:51 +0200
Message-Id: <DL5JFZPXGYZF.2JXFWOJHEMWAF@baylibre.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: can: m_can: add ti,am62-m_can
 compatible
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Kendall Willis" <k-willis@ti.com>, "Markus Schneider-Pargmann"
 <msp@baylibre.com>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Chandrasekar Ramakrishnan" <rcsekar@samsung.com>
Cc: <s-kochidanadu@ti.com>, <a-kaur@ti.com>, <s-tripathi1@ti.com>,
 <vishalm@ti.com>, <linux-can@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0-146-gb5c16ebe1835
References: <20260902-temp-v4-0-3896f7d16ce8@ti.com>
 <20260902-temp-v4-1-3896f7d16ce8@ti.com>
In-Reply-To: <20260902-temp-v4-1-3896f7d16ce8@ti.com>

--a15e01d85f8a611c40ff4ae9385bc153f1f9fa83a0571b2a8a2491377b30
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Kendall,

On Wed Sep 2, 2026 at 11:03 PM CEST, Kendall Willis wrote:
> Add "ti,am62-m_can" to the list of compatible strings for the M_CAN
> controller binding. This compatible identifies TI AM62 SoCs which
> support out-of-band wakeup capability.
>
> Signed-off-by: Kendall Willis <k-willis@ti.com>
> ---
>  Documentation/devicetree/bindings/net/can/bosch,m_can.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml b=
/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> index 2c9d37975bedd652b3060ab11ba75c37565edaad..89e5a44453372c57506e9cf3a=
009b55a70cc4446 100644
> --- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> +++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> @@ -16,7 +16,9 @@ allOf:
> =20
>  properties:
>    compatible:
> -    const: bosch,m_can
> +    enum:
> +      - bosch,m_can
> +      - ti,am62-m_can

I think you should use oneOf here to allow the use of

  compatible =3D "ti,am62-m_can", "bosch,m_can";

Best
Markus

--a15e01d85f8a611c40ff4ae9385bc153f1f9fa83a0571b2a8a2491377b30
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCapkvwxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlMr
dwD+KU6CuPk9zJ8NzOMyi92mXbApr4jbJz7igogpPtqaSJMBAOSyx5B9ln3sgQco
EmRUOaRu3BgZAwDtaQM5wfBkUNEF
=6Jsh
-----END PGP SIGNATURE-----

--a15e01d85f8a611c40ff4ae9385bc153f1f9fa83a0571b2a8a2491377b30--
