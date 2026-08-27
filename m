Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E521240611
	for <linux-can@vger.kernel.org>; Thu, 27 Aug 2026 12:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787834200; cv=none; b=Mks2Y0pze759w+ecG/wiIiG/Vy8nenzwBluaPGmpO+55jZeHb/Nw8fZbjORIgi2YePM+bIyBGb/RTyAJKWqkdd5paxBDMmjsM4xXRcLPBXa5oCuh9uniLaB1zJvDlIs5vPm8tp+rCtii7lu5DQT8qsoQHIN0x+WRubEv3pOTdzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787834200; c=relaxed/simple;
	bh=ulgNANMVRYH5w7t/TNo1tcKHrsDlTmIFVfhgNG4O1m8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcCCjRy4cijlkm1Ese/xB2glQ/D8McZhqQLUcowjNcWFYP4QV1hxIqyRQXXXMWXMS+WUbRG/9lc5TpGot9Y0pwAT1+jdoSW25SJh8DNxuyCtuVGhQ6mhTNA99R7hA9uH2co4jytDi4q7ivcjQDZRslVlf1q385MdTS5b4MQflvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 28E3C200FF9;
	Thu, 27 Aug 2026 14:36:26 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wzZLG-003bdA-0C;
	Thu, 27 Aug 2026 14:36:26 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id BD3E958D86E;
	Thu, 27 Aug 2026 12:36:25 +0000 (UTC)
Date: Thu, 27 Aug 2026 14:36:25 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: sashiko-bot@kernel.org, fanwu01@zju.edu.cn
Cc: linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>
Subject: Re: [PATCH net 11/14] can: kvaser_pciefd: fix use-after-free in bec
 poll timer
Message-ID: <20260827-cocky-glistening-vulture-638685-mkl@pengutronix.de>
References: <20260826121036.2706424-1-mkl@pengutronix.de>
 <20260826121036.2706424-12-mkl@pengutronix.de>
 <20260827121053.6D2671F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3lhvfdcbozacmmb7"
Content-Disposition: inline
In-Reply-To: <20260827121053.6D2671F000E9@smtp.kernel.org>


--3lhvfdcbozacmmb7
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net 11/14] can: kvaser_pciefd: fix use-after-free in bec
 poll timer
MIME-Version: 1.0

Fan Wu,

can you comment on this?

regards,
Marc

On 27.08.2026 12:10:53, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [Critical] Missing dma_rmb() when reading packets from coherent DMA mem=
ory.
> - [High] Incomplete timer teardown and missing state checks in ndo_stop (=
kvaser_pciefd_stop) causes a polling loop leak, state corruption, and poten=
tial spurious netif_rx calls when the interface is brought down.
> --
>
> commit d6148cc43f3a9adbcbc3d9812cbf816bc0ffca1f
> Author: Fan Wu <fanwu01@zju.edu.cn>
>
> can: kvaser_pciefd: fix use-after-free in bec poll timer
>
> This commit addresses a use-after-free by switching to timer_shutdown_syn=
c()
> in kvaser_pciefd_remove() and kvaser_pciefd_teardown_can_ctrls(). It ensu=
res
> the bec_poll_timer callback completes before freeing the CAN device during
> module removal or probe errors.
>
> Link: https://patch.msgid.link/20260818063832.383829-1-fanwu01@zju.edu.cn
>
> > diff --git a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c b/drive=
rs/net/can/kvaser_pciefd/kvaser_pciefd_core.c
> > index d8c9bfb202304..a0597db720864 100644
> > --- a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
> > +++ b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
>
> [ ... ]
>
> > @@ -1879,7 +1880,7 @@ static void kvaser_pciefd_remove(struct pci_dev *=
pdev)
> >  		struct kvaser_pciefd_can *can =3D pcie->can[i];
> >
> >  		unregister_candev(can->can.dev);
> > -		timer_delete(&can->bec_poll_timer);
> > +		timer_shutdown_sync(&can->bec_poll_timer);
>
> [Severity: High]
> This is a pre-existing issue, but since you are fixing the timer teardown=
 here,
> does the timer also need to be synced during ndo_stop?
>
> In kvaser_pciefd_stop(), the code uses the non-sync timer_delete:
>
> 	iowrite32(0, can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
> 	timer_delete(&can->bec_poll_timer);
> 	can->can.state =3D CAN_STATE_STOPPED;
>
> Because this does not wait for the callback to finish, couldn't a pending=
 status
> request be issued to the hardware right as the interface is brought down?
>
> Furthermore, if a status response arrives via the shared PCIe interrupt a=
fter
> the interface is stopped, kvaser_pciefd_handle_status_packet() and
> kvaser_pciefd_handle_status_resp() do not seem to check if the device was
> intentionally stopped. They overwrite the state to an active state and
> unconditionally re-arm the timer:
>
> drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c:kvaser_pciefd_handle_s=
tatus_packet() {
>     ...
> 	if (can->can.state !=3D CAN_STATE_BUS_OFF &&
> 	    can->can.state !=3D CAN_STATE_ERROR_ACTIVE) {
> 		mod_timer(&can->bec_poll_timer, KVASER_PCIEFD_BEC_POLL_FREQ);
> 	}
>     ...
> }
>
> Could this lead to an infinite polling loop leak and potential spurious
> netif_rx calls on a stopped interface?
>
> [Severity: Critical]
> This is also a pre-existing issue, but I noticed a potential memory order=
ing
> issue in kvaser_pciefd_read_packet().
>
> When reading from the coherent DMA buffer:
>
> drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c:kvaser_pciefd_read_pac=
ket() {
>     ...
> 	size =3D le32_to_cpu(buffer[pos++]);
> 	if (!size) {
> 		*start_pos =3D 0;
> 		return 0;
> 	}
>
> 	p->header[0] =3D le32_to_cpu(buffer[pos++]);
>     ...
> }
>
> Is a dma_rmb() needed before reading the packet contents?
>
> Without a read memory barrier, weakly ordered CPU architectures might
> speculatively read the header and payload before the size read completes.
> If the hardware is actively updating the buffer, couldn't the CPU see the
> new size but process stale header or payload data that was speculatively
> prefetched?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826121036.27=
06424-1-mkl@pengutronix.de?part=3D11
>
>

--
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--3lhvfdcbozacmmb7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCapAvRwAKCRDMOmT6rpmt
0t62AQDaxYVnqdmnEdiDRryZiMAEEUFbFlaWLIMWf3LtcUMM9wEAg6+pG9EnvJj6
tn5x3aU1CkkQxXF1R4uUKcgI9vVDvQw=
=v5Gl
-----END PGP SIGNATURE-----

--3lhvfdcbozacmmb7--
