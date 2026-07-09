Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABBA4DB572
	for <linux-can@vger.kernel.org>; Thu,  9 Jul 2026 18:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783622314; cv=none; b=CGPFBpPzj53llaYTHKPp+lVZ7n7YUk6HiTNMMqvDh3MIQIq75X+K0dc36KzcwfjBfxA86TsajNSoyA1UG0735lfYtaKM2J81UaODW0Fai0Q7v8skESK8L9vqMFA6wfSIb4I8WrhY42FPMDAMj409X/TSwYkO3KTU7KCkiVxjJFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783622314; c=relaxed/simple;
	bh=VoI6QBB1ms3u096FaHhmeIA4sw4rkprCpVMpkJVxrag=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XxHPt56EZoB+w614YmmrhVcTANsPvyHIlFJbzriAAUZUjehNdhl/BCsDJJKoO18kZgSLJ35GsiBi90nJmudYI0Q0bHyZuKKFZ6kGbyKu489Ka8qXO3wJquu5Obhf4QtGJ4AP4732bsoMt7QWM0GAFYMJU4d7x0ghp39MhIAqA6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khAZxsUm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khAZxsUm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22521F000E9;
	Thu,  9 Jul 2026 18:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783622311;
	bh=7+mHsds+4ppVUIu5p3fBC7L1SRY0ulpQRBrl7GMEzAs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=khAZxsUm4ITyCNHyqoXjDoY4wZ9joyvSRcIOlCHJDmIB2onCP0YMu5WmF150CmRSu
	 9DT6pQuDf1HSLSz+MGDNKHWI+xoR6AqSCrIdmm9prmqQrdph+XUiQfxPUaM7hm91bV
	 17VDRjm7p95Whxuu847x7+VLCVcr0fiKWPA0YBV6ktDw+o1tPqxvjupt/DKQI8G5L/
	 2a57U5LVMmRWBIBsaBgUKxggTSyZ5krR67USb4aJRnWTWm5ftzpJlKUZtnwA0hOnwW
	 xiIwsAT/c2UNg0sF5h+y8xUe7AcNkdERsVeJyyFxZEYKWAN6G9cfT0iC6PBDatGfC1
	 s56tKo2iREkJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 10/11] can: bcm: fix data race on
 rx_stamp/rx_ifindex in bcm_rx_handler()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Marc Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260709-bcm_fixes-v11-10-067ba11bec5c@hartkopp.net>
References: <20260709-bcm_fixes-v11-0-067ba11bec5c@hartkopp.net>
 <20260709-bcm_fixes-v11-10-067ba11bec5c@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 18:38:30 +0000
Message-Id: <20260709183830.E22521F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unconditional overwrite of `op->rx_stamp` corrupts timestamp metad=
ata for throttled or multiplexed CAN frames.
--

--- Patch [10]: [PATCH v11 10/11] can: bcm: fix data race on rx_stamp/rx_if=
index in bcm_rx_handler() ---
commit 962a73c290cc743e31470d3c9ed820b166d58a79
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: fix data race on rx_stamp/rx_ifindex in bcm_rx_handler()

This commit moves the update of rx_stamp and rx_ifindex under the
bcm_rx_update_lock to prevent concurrent writers from racing each
other, avoiding torn stores on 32-bit platforms. It also ensures
metadata is bundled correctly with the frame content delivered to
userspace.

Link: https://lore.kernel.org/linux-can/20260707145135.5BC831F00A3A@smtp.ke=
rnel.org/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index fbf1cbb7c99fe..10a883b50fc63 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c

[ ... ]

> @@ -815,6 +810,14 @@ static void bcm_rx_handler(struct sk_buff *skb, void=
 *data)
>  			traffic_flags |=3D RX_OWN;
>  	}
> =20
> +	/* save rx timestamp and originator for recvfrom() under lock.
> +	 * For an op subscribed on all interfaces (ifindex =3D=3D 0)
> +	 * bcm_rx_handler() can run concurrently on different CPUs so
> +	 * the CAN content and the meta data must be bundled correctly.
> +	 */
> +	op->rx_stamp =3D skb->tstamp;
> +	op->rx_ifindex =3D skb->dev->ifindex;

[Severity: High]
This is a pre-existing issue, but does this unconditional update of
op->rx_stamp corrupt the timestamp metadata for throttled or multiplexed
CAN frames?

The commit message states that bcm_send_to_user() must report the timestamp
and ifindex of the very same frame whose content it is delivering. However,=
 if
a BCM RX op is configured with a throttle timer, a CAN frame might match a
mask and get queued by the timer. If a second CAN frame arrives on the same
interface, it will unconditionally overwrite the shared op->rx_stamp here
before checking if the frame matches any multiplex index or if it will be
throttled.

When the throttle timer later flushes the first frame:

net/can/bcm.c:bcm_rx_thr_flush() {
    ...
    for (i =3D 1; i < op->nframes; i++)
        updated +=3D bcm_rx_do_flush(op, i);
    ...
}

will all notifications use the single, overwritten op->rx_stamp from the
subsequent frame, rather than the timestamp of the frame actually being
delivered?

> +
>  	if (op->flags & RX_FILTER_ID) {
>  		/* the easiest case */
>  		bcm_rx_update_and_send(op, op->last_frames, rxframe,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-bcm_fixes-=
v11-0-067ba11bec5c@hartkopp.net?part=3D10
