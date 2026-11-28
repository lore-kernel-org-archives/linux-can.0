Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795861220;
	b=mjcBlARyqI2dU1dA/T98A5dAMgPXerVsDxTYLZ9ALQ4CH1OzwrhDtSJ76wyN3kEuX0YY
	 djtV1ryhs4T+d/eeup8kQskNdvK4FcgrofJtQSviKknKQqfYMN4PGp6Sgrf4HkDAgb4ah
	 JRurrYcs1ODH/XGTit+JD/XT2uUfV+LdIHyUPdMyLuLwLPNqdVGG8ndo3JyAt0Etc77VK
	 YJhjgrVKAn6lj8MnQXw/kMsQSmvi+7XVSdXzibM1afeFdodP+ansR9JxRrTB/7iijzb2Y
	 43z0ua6R6wL0SoGFUieOns4GkUqw5eFpBKAiQOiLhvmSP4xCU+EpvkAzHCeBYG4hVzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795861220;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=SeyQg306ofwt5p0A9SFDaJWEAIm2Jb2XXo3LWtfnqps=;
	b=1fhQcX38RK4DRtpPWvveSo7URVeR3sbzdLKFng1/eAe33HWMxgsfZ71FBbEg9kGPkkL9
	 hgPfGOqhA9NdGIFhe5AKgt4pvOTLm8W3gQsFR3Kl4b+hj9DoPomCfUHvegQBTAV3JK2Fl
	 nRfFf3Rq0FQ8soqgE5Qf1hs6sMgC9itXpDtNmf8jTqIgLkBPcjBHncHEdsD20UC7Cg/Rl
	 /YO15i7D57XWG7uA1JRah2an/zB8k0dQXHECiZTtXBTZtpCiC+4R828ZPfcth2fXFPKDZ
	 Pk83ruiVpeQF8gE7+SJ6IsRNYBnOKEQIFUlu+OhA4SVUKWyFsFfTbbDK8SArsorAVfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AvtRab6f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C68606A31C
	for <linux-can@vger.kernel.org>; Sat, 28 Nov 2026 10:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AvtRab6f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24EA01F000C1;
	Sat, 28 Nov 2026 10:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795861219;
	bh=SeyQg306ofwt5p0A9SFDaJWEAIm2Jb2XXo3LWtfnqps=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AvtRab6fJrh6qiO4XiOUaiIHocksPnsIIB8PH3UZECqaWdQ+iina3Vmhi7+/hdRor
	 6hZjJIbRiqjcx6j5BcXo3jYJZojUyuSGL18TY4RoxcmieXzf4vzvBtG2Alpo96X81J
	 Bzz8ZJDFmzn/TB1w4pEFCSEo5h19cF6UFZ3QsFo5Q+OlfAtLt2TRh7hpFMGqxJU87u
	 AHpMW7c4RZNq0tYz4ZWsYp09SyjuFMCcGvEljFpjSWAe3zzusBK0BweK2m6LaKnTNp
	 S5kH8FNAEMkaFBzEV0n8sFBsh8Enoy2oZLJZAZHOH8W9UASr9y8k6OBaBjfqABI3QX
	 V4Ro9iTZrf7Hg==
Subject: Re: [PATCH can-next 09/22] can: isotp: drop frames without N_PCI
From: netdev-bot+sashiko@kernel.org
To: socketcan@hartkopp.net
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, sashiko-bot@kernel.org,
 zihanx@nebusec.ai, o.rempel@pengutronix.de, yewentian395@gmail.com,
 kuba@kernel.org
Date: Sat, 28 Nov 2026 10:20:18 +0000
Message-ID: <179586121870.3131.13230679488589682283@kernel.org>
In-Reply-To: <20261126-getsockopt-memcg-isotp-v1-9-681ef8d8c2c9@hartkopp.net>
References: <20261126-getsockopt-memcg-isotp-v1-9-681ef8d8c2c9@hartkopp.net>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit "can: isotp: drop frames without N_PCI" fixes a
  receive-path defect that has existed since ISO-TP was added in commit…

--

can: isotp: drop frames without N_PCI

This commit adds a length check to isotp_rcv() in net/can/isotp.c. CAN
frames whose data length is shorter than the address extension plus the
N_PCI byte are now dropped. Before this, they were decoded from stale data
beyond CAN_DL.

> isotp_rcv() reads the address extension and the N_PCI without checking
> the CAN frame data length. So frames with CAN_DL < ae + N_PCI_SZ are
> processed with stale data beyond CAN_DL, e.g. as SF, CF or FC.
>
> Drop these frames as they are no valid N_PDUs.
>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

[Severity: Low]
Should this patch carry a Fixes: tag?

The unchecked reads of cf->data[0] and cf->data[ae] in isotp_rcv() seem
to date back to the original ISO-TP code:

Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")

Without the tag, stable backporting will probably miss this patch.

Could the commit message also describe the concrete impact? CAN drivers
zero-fill the frame data through alloc_can_skb()->skb_put_zero(). A DLC 0
frame on the rx CAN ID therefore decodes as N_PCI_SF with SF_DL 0.

isotp_rcv_sf() then resets the rx state before it checks the length:

net/can/isotp.c:isotp_rcv_sf() {
	...
	hrtimer_cancel(&so->rxtimer);
	WRITE_ONCE(so->rx.state, ISOTP_IDLE);

	if (!len || len > cf->len - pcilen)
		return 1;
	...
}

So any node on the bus can silently abort a multi-frame reception that is
in progress. The CFs that follow are ignored, and the application gets
neither the PDU nor an error.

The stale bytes may also be non-zero, for example when the frame comes from
a local CAN_RAW or vcan sender. The frame can then be decoded as a CF,
which uses up a sequence number. It can also be decoded as an FC, which
aborts a transmission.

A backport dependency may also be worth recording. The later commit
"can: isotp: check the data length of the last CF" relies on this check:

    isotp_rcv() ensures cf->len >= ae + N_PCI_SZ, so the payload size can
    not underflow

What happens if that commit is backported without this one? The signed
value cf->len - ae - N_PCI_SZ could go negative. It is converted to
unsigned in the comparison, so wouldn't that check then never fire?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9%40hartkopp.net
