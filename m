Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A5135D615
	for <linux-can@vger.kernel.org>; Tue, 16 Jun 2026 09:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781603133; cv=none; b=RXPIgXnQWjz/P8XBl3RtSTlB93jH9HyqLFA2bKCUi+kmdgO8ciovrlB8CZyNCECansVUtPjW+bi0pm2HzZL6Sn+iKULScXQ7EsuvF6aKnXubj/9fREFu79p098KSEsHOGylA6vABa8qV4/nSL0/RXqri/sHxLPZyG+FBwrdZJVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781603133; c=relaxed/simple;
	bh=GYqYxSl4+ndv8/Z0eZSpYF08umPM5cpTPKLz2Tc6FLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ul7Nf9wWUooHB/GsJH3YAeR+tXx6jo2xPA4/qDuxg2upmw6VFUo9fiW1Pigvzkl4NDzygOY0k2eD9NtNYE+VwMFbDJ3c1N3W2QC20Ap0dmuPigoFamaTVdHYumNmbWkyWk4+e2ojjn+dAZyqJNpUuSh7QkXRow7vbs/ysfNJbII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1wZQLy-00039Y-PW; Tue, 16 Jun 2026 11:45:06 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wZQLw-0030m5-1w;
	Tue, 16 Jun 2026 11:45:04 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 46AEC55180D;
	Tue, 16 Jun 2026 09:45:04 +0000 (UTC)
Date: Tue, 16 Jun 2026 11:45:03 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: guoqi0226 <guoqi0226@163.com>
Cc: sashiko-bot@kernel.org, cuiguoqi@kylinos.cn, linux-can@vger.kernel.org, 
	mailhol@kernel.org, mani@kernel.org, thomas.kopp@microchip.com, 
	o.rempel@pengutronix.de, sashiko-reviews@lists.linux.dev, socketcan@hartkopp.net
Subject: Re: [PATCH v2 0/1] can: mcp251x: Add ACPI device ID table for MCP2515
Message-ID: <20260616-elite-umber-mustang-fed3c5-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260616031332.0F34C1F000E9@smtp.kernel.org 20260616-teal-wrasse-of-conversion-348af0-mkl@pengutronix.de>
 <20260616085359.89406-1-guoqi0226@163.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nhghozftnujrx7l5"
Content-Disposition: inline
In-Reply-To: <20260616085359.89406-1-guoqi0226@163.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--nhghozftnujrx7l5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/1] can: mcp251x: Add ACPI device ID table for MCP2515
MIME-Version: 1.0

On 16.06.2026 16:53:58, guoqi0226 wrote:
> Changes in v2:
> 1. MCP2515 is verified, but MCP251XFD has not been tested.

There was a previous attempt to bring ACPI support for the mcp251xfd
mainline, see
https://lore.kernel.org/all/20241210-mcp251xfd-acpi-v2-1-d6694f590d00@pengu=
tronix.de/

It was not successful. I think it's best to only add ACPI support for
devices you have actually tested.

>    When testing MCP2515, MCP251XFD was found missing ACPI support, hence =
this addition.
>    Reference the validated MCP2515 ACPI node as template:
>    Device(CAN0){
>          Name(_HID, "MCP2515")
>          Name(_UID, 0)
>          Name (_DSD, Package() {
> 2. The original 9-character HID "MCP251XFD" violates ACPI format rules;
>    redefine it to standard compliant ACPI ID MCHP15FD.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--nhghozftnujrx7l5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCajEbHQAKCRDMOmT6rpmt
0inmAP9KAsKt/BcB0SxktVuOPl09hxvVxbGvfTb/t1XREz2V7wEAk/rOEAPQXBKZ
D62XgqdVeN/dp+3/fyO4lrAW8W408A0=
=cm2p
-----END PGP SIGNATURE-----

--nhghozftnujrx7l5--
