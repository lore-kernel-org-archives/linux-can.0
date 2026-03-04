Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7102A3368A0
	for <linux-can@vger.kernel.org>; Wed,  4 Mar 2026 11:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772624306; cv=none; b=poI+UEiHn4r8sq3tN6M431R1v608n1fze9++9pzDAGYpj4376fy8XF63z/C3KRxmKD5b7bunzfu+tAwnswPsaOpyH+Bx6DIPhXsBBwp69QaRVHZFPKJRCCKBEt8QwKCak04Uw1vn8IrRNYzLweo6XPnsih87nzMx9Q7iRygocgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772624306; c=relaxed/simple;
	bh=XwgGHhmEmcfCEL4J1R5XN4zvCNr4OikXeGZzF6e38I0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ELA26eB/D6jovqwIQ/AXqiTOdqSa0VBinATlHkdayxpHfMzU/Q8aIWaEdBLPmcXPxbSx+NuC2L7ByB8HHIF7nWl5ohNffAwau61SI390b5PNAzTveC4J7alJrld90PMUjIWN/AZ7UPuwqc+sarV178XtgSfJdU5Ozpi7KKj8J0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vxkYZ-0005Zn-SX
	for linux-can@vger.kernel.org; Wed, 04 Mar 2026 12:38:23 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vxkYY-003hqu-14
	for linux-can@vger.kernel.org;
	Wed, 04 Mar 2026 12:38:23 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6F1554F76F3
	for <linux-can@vger.kernel.org>; Wed, 04 Mar 2026 11:38:23 +0000 (UTC)
Date: Wed, 4 Mar 2026 12:38:23 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: linux-can@vger.kernel.org
Subject: Linux-CAN Community Meetup at Embedded World 2026
Message-ID: <20260304-comical-illustrious-chowchow-c972e2-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5qzyd5xffycakyzm"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--5qzyd5xffycakyzm
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Linux-CAN Community Meetup at Embedded World 2026
MIME-Version: 1.0

Community meetup for Linux-CAN and related topics at Embedded World 2026
in N=C3=BCrnberg

We invite you to join us for a casual gathering to talk about this and
related Open-Source projects. It's a good opportunity to meet fellow
developers and users in the Linux-CAN community, exchange ideas, and
discuss future directions.

=F0=9F=93=85 Date: Wednesday, March 11th
=F0=9F=95=92 Time: 13:00 @ Pengutronix booth (4-261)

We'll first meet at the Pengutronix booth and walk to a coffee area
together.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--5qzyd5xffycakyzm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCaagZrAAKCRDMOmT6rpmt
0igUAQCtZdRBRRVgfsqVZyzW89RIEdezXGOLzbn4kCF4ustnrwD/V5F1wgU4LeTU
UJkY5UfH0G9/4gaxbxvlZH9fm5XcMAk=
=mTn3
-----END PGP SIGNATURE-----

--5qzyd5xffycakyzm--
