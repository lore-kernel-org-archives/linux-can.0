Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828C442DA4C
	for <linux-can@vger.kernel.org>; Mon, 20 Jul 2026 15:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560063; cv=none; b=nLyNq+eUxmJpfZ9RI7guEi9JLqUtc4Gko45p4TNB2iF5o0UpglBnViTUlC09Rfq2Uf2ofV/wK0pEcegHtju0L+aKCk+l3VNn73uY3B9FCdoAj/6g0OmD/kIfUP/iWIQeedIDPIuYxv4AGQIzqdv1PigkHo3dmNAqOCXDzw3C7LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560063; c=relaxed/simple;
	bh=vkuGjA3NMdWFQw1k/0QtYunT5QITNNsGlujQ+z+ygmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmDLkzUS9KY2sBvU3kfdNNqoKr+UQYu7LBqHAAjccNy/0FkgbwFbLOG30WfkOZNXQaM5B4cQLHpRbNdBo8xSJhJ3okHf2bxdYX77HNmRBrJX+28psBcseNj0hV2sGRKWEksS8fYTmJv/KY6KRTHQD41IdzxIrubUAm9BRKKu7EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 74C7E201FAA;
	Mon, 20 Jul 2026 17:07:38 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wlpak-000QWa-1D;
	Mon, 20 Jul 2026 17:07:38 +0200
Received: from pengutronix.de (unknown [IPv6:2001:678:ed0:ff00::a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id BF31E56E695;
	Mon, 20 Jul 2026 15:07:37 +0000 (UTC)
Date: Mon, 20 Jul 2026 17:07:36 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: sashiko-bot@kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org, 
	Oleksij Rempel <o.rempel@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>
Subject: Re: [PATCH can-next 07/13] can: gs_usb:
 gs_usb_receive_bulk_callback(): reduce scope of several variables
Message-ID: <20260720-enormous-koala-of-persistence-ab6ec6-mkl@pengutronix.de>
References: <20260720-gs_usb-new-features-v1-0-427a8013c380@pengutronix.de>
 <20260720-gs_usb-new-features-v1-7-427a8013c380@pengutronix.de>
 <20260720140024.368601F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rksqaow5bwuufrhk"
Content-Disposition: inline
In-Reply-To: <20260720140024.368601F000E9@smtp.kernel.org>


--rksqaow5bwuufrhk
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-next 07/13] can: gs_usb:
 gs_usb_receive_bulk_callback(): reduce scope of several variables
MIME-Version: 1.0

On 20.07.2026 14:00:23, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
>
> Pre-existing issues:
> - [High] Returning directly on SKB allocation failure drops the USB
> URB instead of resubmitting it, permanently reducing the RX URB pool
> and potentially stalling the receiver entirely.

FTR: this will be fixed with
https://lore.kernel.org/all/20260709-gs_usb-resubmit-urb-v1-1-4dd40030cc84@=
pengutronix.de/

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--rksqaow5bwuufrhk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCal45tgAKCRDMOmT6rpmt
0ptsAQDtp1MYWcUtLFVNfs29Tshuso3j9EqhCdwv3LDzCjVmMAEA2aouqnEq1po4
HzWrSsXuCCw30LXmR0Ga7q67w/tidgM=
=I4mf
-----END PGP SIGNATURE-----

--rksqaow5bwuufrhk--
