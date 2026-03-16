Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E094C85C4A
	for <linux-can@vger.kernel.org>; Mon, 16 Mar 2026 13:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773667778; cv=none; b=VjQKFyhf/qE8OzTvipTdQpj+hDv8aZZvciMFc8t9Od80RtMUZnpGlA1DSUUr4oH/p0j6R5DzkC70jmAsK0eXyI+XJU1XPNAezk/weto5WLay92Z+H5NDCIyuvqv4ol1te2ET7eZCgkSzb8O0sNsmRrvIrvThtXhcFbc8N5IgAqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773667778; c=relaxed/simple;
	bh=Ewljs4HTBN8eqYjdhoANaHlrnITqiTKi+tNVwOrMiZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzS5Mt8sWT2F6XqQeegsuNtUo/ZWkTen6e2ZwTeCpnfe5Qtge861cUc2u3SnqQICRvSyvlCXguRsnBc3TvueiWbwhh71nUStJSohY8GLa9oTzHihqRpXw0Ufq5HfSm/nPjGPW6We0lkA5ifbk7EM6o3VNAzWRSGz1yzwToRZ3us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w280O-0004iE-Mh; Mon, 16 Mar 2026 14:29:12 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w280O-000ZtE-16;
	Mon, 16 Mar 2026 14:29:12 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 05811504F6E;
	Mon, 16 Mar 2026 13:29:12 +0000 (UTC)
Date: Mon, 16 Mar 2026 14:29:11 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: mani@kernel.org, thomas.kopp@microchip.com, mailhol@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org, 
	konradybcio@kernel.org, linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, mukesh.savaliya@oss.qualcomm.com, 
	anup.kulkarni@oss.qualcomm.com
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: qcs6490-rb3gen2: Enable CAN bus
 controller
Message-ID: <20260316-garrulous-saluki-of-advertising-b0a726-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260316131950.859748-1-viken.dadhaniya@oss.qualcomm.com>
 <20260316131950.859748-4-viken.dadhaniya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r3a2xgkqmsh547pa"
Content-Disposition: inline
In-Reply-To: <20260316131950.859748-4-viken.dadhaniya@oss.qualcomm.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--r3a2xgkqmsh547pa
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: qcs6490-rb3gen2: Enable CAN bus
 controller
MIME-Version: 1.0

On 16.03.2026 18:49:50, Viken Dadhaniya wrote:
> Enable the MCP2518FD CAN controller on the QCS6490 RB3 Gen2 platform.
> The controller is connected via SPI3 and uses a 40=E2=80=AFMHz oscillator.
>
> The setup was tested with CAN-FD loopback and actual data transfer
> using an external PCAN-USB FD adapter.

IIRC a board DT update should go independent of the driver update.

> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---
> v1 -> v2:
>
> - Drop the gpio-hog property.
> - Add the microchip,xstbyen property to enable transceiver standby contro=
l.
>
> v1 Link: https://lore.kernel.org/all/20260108125200.2803112-3-viken.dadha=
niya@oss.qualcomm.com/
> ---
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 22 ++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/bo=
ot/dts/qcom/qcs6490-rb3gen2.dts
> index e3d2f01881ae..245961722f84 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -44,6 +44,14 @@ chosen {
>  		stdout-path =3D "serial0:115200n8";
>  	};
>
> +	clocks {
> +		mcp2518fd_osc: can-clk {
> +			compatible =3D "fixed-clock";
> +			clock-frequency =3D <40000000>;
> +			#clock-cells =3D <0>;
> +		};
> +	};
> +
>  	dp-connector {
>  		compatible =3D "dp-connector";
>  		label =3D "DP";
> @@ -1151,6 +1159,20 @@ platform {
>  	};
>  };
>
> +&spi3 {
> +	status =3D "okay";
> +
> +	can@0 {
> +		compatible =3D "microchip,mcp2518fd";
> +		reg =3D <0>;
> +		interrupts-extended =3D <&tlmm 7 IRQ_TYPE_LEVEL_LOW>;
> +		clocks =3D <&mcp2518fd_osc>;
> +		spi-max-frequency =3D <10000000>;

Why do you limit the frequency to 10 MHz? Is this a HW limitation?

With a 40 MHz clock the chip supports up to 17 MHz (not 20 MHz due to
the erratum).

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--r3a2xgkqmsh547pa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCabgFpQAKCRDMOmT6rpmt
0mj7AQDxU5YgSIHvN2VsfG2GOVsuPCeKz6TJ75DSxolGhm4VugEA6xwrm7zxwuit
rhVCOx+7yZZgWtDvdUq/UK19bjXJyQw=
=+3tl
-----END PGP SIGNATURE-----

--r3a2xgkqmsh547pa--
