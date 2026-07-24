Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A923630B0
	for <linux-can@vger.kernel.org>; Fri, 24 Jul 2026 15:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784908563; cv=none; b=PgqBjOeceQwQqGYJOoFcSusXmAvqQ3tdqDikd9w4uAytF76yh5qgNJuxdcNRXWNAsXEOnD5v6A5nKEUJMVADIga8NQFGh/P2LRS6JnPW3RX3P73aMLavEjPlnNClbh54BZ0JIRquh9SBGrKRjy2ErtIIt+KpoNe2SOpTN75qrFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784908563; c=relaxed/simple;
	bh=Pf/YKPTe/+ySb8avhl5ps4GzDqIDAhQVMKpyYyS81go=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MTzfPlSuXcCVlhEESPl7lLcmu8iIhmmjxchkDg8ev0WTW9FiZU55coilLhG2BuQ3GyCA6srWC3w20p7caL+qeYVejOo6mwRZZaoCTg2nANcBLIEQ/JehcG3xbODb300UX1ZQD3XEt65nIGt5dw2YL7plMD9ZmfvBXXFrxQVFoNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghWclZjO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghWclZjO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C9A1F000E9;
	Fri, 24 Jul 2026 15:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784908561;
	bh=jY4/eH5Jirsh6FH3hvPzU1T/iKMxXry5Fte5LhDBEJo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ghWclZjOOUMEQvNspYJeShGcUTclaswdjDACxfKIfZ2heVRxDEu1CK/tnJH41rfLv
	 4urfL02qmqILEt/9V0LMecA3CQa5YKBIytjMBNo9Q5PFizzr2gdQSeVIApF5B9ZfBV
	 womtpox3ripF6gcnuI45EoJPaaiB07VFYsGMlURYxgLiM3McEA7nV0rdrfbaSna+0b
	 hupIkGV3ksRJRWCewHal0LHVLAZ/r7Jptlw+zBjJr8Gh2NTOpHtdRFDtIePr8a5t+r
	 jUhERCjQfFpb+FkvBcNApcCHXugXHf7L1snSZjjIm344ncXAq5DLFYtfWWA9eNSVIs
	 leFOEKbpBPxkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] can: ctucanfd: mark error-active controller status
 valid
Reply-To: sashiko-reviews@lists.linux.dev
To: "Avi Weiss" <thnkslprpt@gmail.com>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260723155543.318414-1-thnkslprpt@gmail.com>
References: <20260723155543.318414-1-thnkslprpt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 15:56:00 +0000
Message-Id: <20260724155601.48C9A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] When Bus Error Reporting is enabled, the Bus Error Interrupt (BEI)=
 is unhandled and uncleared, leading to an infinite interrupt loop and devi=
ce lockup.
--

--- Patch [1]: [PATCH net] can: ctucanfd: mark error-active controller stat=
us valid ---
commit 5feac9571eb44c72dffa41f1990bff2ccac15e3e
Author: Avi Weiss <thnkslprpt@gmail.com>

can: ctucanfd: mark error-active controller status valid
   =20
In the CAN_STATE_ERROR_ACTIVE case, cf->data[1] is set to
CAN_ERR_CRTL_ACTIVE, but cf->can_id is not set with CAN_ERR_CRTL in
that path.

> diff --git a/drivers/net/can/ctucanfd/ctucanfd_base.c b/drivers/net/can/c=
tucanfd/ctucanfd_base.c
> index 0ea1ff28dfce8..8f8b1c097ec6d 100644
> --- a/drivers/net/can/ctucanfd/ctucanfd_base.c
> +++ b/drivers/net/can/ctucanfd/ctucanfd_base.c
> @@ -869,7 +869,7 @@ static void ctucan_err_interrupt(struct net_device *n=
dev, u32 isr)
>  			break;
>  		case CAN_STATE_ERROR_ACTIVE:
>  			if (skb) {
> -				cf->can_id |=3D CAN_ERR_CNT;
> +				cf->can_id |=3D CAN_ERR_CRTL | CAN_ERR_CNT;
>  				cf->data[1] =3D CAN_ERR_CRTL_ACTIVE;
>  				cf->data[6] =3D bec.txerr;
>  				cf->data[7] =3D bec.rxerr;

[Severity: High]
This isn't a bug introduced by this patch, but could there be an issue with
handling the Bus Error Interrupt (BEI) in ctucan_interrupt() when Bus Error
Reporting is enabled?

While ctucan_err_interrupt() has code to handle BEI, it appears it might ne=
ver
be called if only the BEI interrupt is asserted:

drivers/net/can/ctucanfd/ctucanfd_base.c:ctucan_interrupt() {
        ...
        /* Error interrupts */
        if (FIELD_GET(REG_INT_STAT_EWLI, isr) ||
            FIELD_GET(REG_INT_STAT_FCSI, isr) ||
            FIELD_GET(REG_INT_STAT_ALI, isr)) {
                icr =3D isr & (REG_INT_STAT_EWLI | REG_INT_STAT_FCSI | REG_=
INT_STAT_ALI);

                ctucan_netdev_dbg(ndev, "some ERR interrupt: clearing 0x%08=
x\n", icr);
                ctucan_write32(priv, CTUCANFD_INT_STAT, icr);
                ctucan_err_interrupt(ndev, isr);
        }
        ...
}

Because REG_INT_STAT_BEI is omitted from both the if-condition and the icr =
mask,
does this leave the BEI status unhandled and uncleared?

If a bus error occurs, would this lead to an infinite interrupt loop and
ultimately lock up the device?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723155543.3184=
14-1-thnkslprpt@gmail.com?part=3D1
