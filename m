Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7413B582F;
	Fri,  9 Oct 2026 14:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791556595; cv=none; b=tX6NAJUtYbWRaMKLBQFHUDruqhkKvuWVisOoWjAYXtNmc+0/r0eLoqxUnB8W3is/Ro7l8M2rnB3bUglRgUDqc/3jmyL4ziTYb/Wo+PY3jqJZ2/eWlaqETGl4/+hic9EZZWWEXIWi3ZTOli2+9ni0Q7n6i3TW3RRN8Kw8GO6k2es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791556595; c=relaxed/simple;
	bh=+jSclIzN4t88VdxCPV6a1J468w5G6J8oAk6fFTE4g0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUDMvwkzwhyPhSalMjW/Pubz7FT+nLHdi/lJy7bse60wIWtg1aST/9zLOqjvxlKGxoYhvQFvykSPxvoDxvy6JMY8K6jpKxRS92NzfiIsp14QmlqZukCkmtAdXBFp2xD4zwMCKaWN0545YiDMNtpMjRkC3frbJlkuR0/xg0asqfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRn/gwZI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRn/gwZI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5F41F00893;
	Fri,  9 Oct 2026 14:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791556594;
	bh=+jSclIzN4t88VdxCPV6a1J468w5G6J8oAk6fFTE4g0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JRn/gwZIBcFoxDDgNKh7CnJNRVlAAx5HMPjGmppCqzedeA+7vTMvLlbIw3zXOCzyV
	 V6sx6RFjfAh7QamSUsas62pDyagFswyBHAAoPTwSaQZnRaCY7Tp+2szNN1kRtjYfiG
	 z2MrN8KsZeKsWPVI7ozOY6VO4jCwrgASmehnL7SDqRWSSM7Qk+YpqXGekdMMllkq3Q
	 9gCXi4+lzPE2o3w5tlN3fG2ErUE99TltghSsh9VTv2D5mjS1f94lQrigh2YpEWwgXC
	 THwXmMcQ5QFXDrxM2wsAhV236g83KGI2k+zLvDgXVRIZAJJx4gSHi05dA27YGswjC9
	 B1KPF+VgJZ6VA==
Date: Fri, 9 Oct 2026 15:36:27 +0100
From: Conor Dooley <conor@kernel.org>
To: Quchaosheng <quchaosheng000406@163.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: net: can: bosch,cc770: Convert to DT
 schema
Message-ID: <20261009-a240a8a6a649d0a48c50b5be@squawk>
References: <20261009105557.301855-1-quchaosheng000406@163.com>
 <20261009105557.301855-2-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9TCiyUllOsKRDT5L"
Content-Disposition: inline
In-Reply-To: <20261009105557.301855-2-quchaosheng000406@163.com>

--9TCiyUllOsKRDT5L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 09, 2026 at 06:55:56PM +0800, Quchaosheng wrote:
> From: Chaosheng Qu <quchaosheng000406@163.com>
>=20
> Convert the Bosch CC770 and Intel AN82527 controller binding from
> free-form text to DT schema, and reference the common can-controller.yaml
> schema.
>=20
> The driver reads one more property than the old text documented:
> "bosch,no-comperator-bypass", which is checked at cc770_platform.c:94.
> It is documented here so that it can be used. Its spelling is kept as
> the driver spells it.
>=20
> The interrupt is obtained with platform_get_irq(), so interrupts is
> required. The register window is described with the chip select, the
> address offset and the size, as the original text and the existing
> device trees on the local bus use three cells. The size is usually 0x80.
>=20
> unevaluatedProperties is used rather than additionalProperties so that
> properties provided by can-controller.yaml, such as termination-gpios,
> remain usable.
>=20
> Assisted-by: LLM
> Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable


--9TCiyUllOsKRDT5L
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCasj76wAKCRB4tDGHoIJi
0rZaAQCCz4QXTKRiGj7noBp3SZ2jaXar3aw/bIeluFLozTrlWwEAm7lBexA7i268
yCAFHc7ExiY6UwmXO1tLZ3xNGPgHUgg=
=f88G
-----END PGP SIGNATURE-----

--9TCiyUllOsKRDT5L--
