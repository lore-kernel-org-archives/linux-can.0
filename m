Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F8E4D37B1
	for <linux-can@vger.kernel.org>; Wed, 14 Oct 2026 15:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791993169; cv=none; b=imLgx3cyYnGDPseWoP1RE8x8zLTPgMUyfyFvtCJ9zviuECLsNFD/YMhAlPU6dnJEJftf8aB29cdf0trKpFGnJ0eTl/mB2I6tEJy8r4y2GwN+6A77Vh2Gfy0byvPlWHGNSV473itk3KLcdbdXz27CUyMk4onO3Qlg4x7EnM92sv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791993169; c=relaxed/simple;
	bh=iObWgIjf7Qi/O5AsBCw48xsRlAgV7Naz0m8ucOcwync=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=MUWyLpYtdy1qA2+pTzkcQXWuiOp5wyiPkTJTVWQyHjcDF2/dYEI4SDbNNMRmRchAOvYlVA8fH/iETXIkJ7/KTIhKCO91vaJOMR1iBkPXCBoBoAqkbt5FS0YmyM10uv/4c6YYDNKNaauw82k/jq7JQI81ugE7frozjtXDz3aaCrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFn7q1NO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFn7q1NO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 230EA1F000C4;
	Wed, 14 Oct 2026 15:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791993168;
	bh=HuFNu2aFJdkixSQ373LLr/7TBNpOOrhFfV62KUcnbw0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jFn7q1NOglSErvPmHCwmcMIp9N9tgmllBp4JQspi+p6tBzTbpiaYoNCsAyn8GXFGc
	 KZwcq56Zl5ACOeFAc3uajqoqC59cWIhFBTzDrLnctmt9fPZLzgr1zq9mdX4NBf+SEY
	 GFZne7Qg3ccnRNx4x52Nape9R49S2F/nHreHrTk/Kl1H8i9lNBxnqyo+mfb9TZ5aga
	 t/muWRbyb5XJbwAoDbVSgXuBKhHstUM/+MjkrbuDDy/eEcN3ByGthURNjo+LrBTUF5
	 T4NJBRAjEEnySNw/C67ZtBSum+j7a4Kgu9T/suHn2MMODBO2ZkdDJ5To6f7n25ZuFb
	 jsuwuo7+gXhtg==
Message-ID: <sashiko-outbox-171497@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH can-next v1 5/8] selftests: can: add J1939 wire-format
 tests against CAN_RAW
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oleksij Rempel" <o.rempel@pengutronix.de>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>
In-Reply-To: <20261014154435.3577983-6-o.rempel@pengutronix.de>
References: <20261014154435.3577983-1-o.rempel@pengutronix.de>
 <20261014154435.3577983-6-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 15:52:47 +0000
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests/can: test_j1939_wire missing assertion for CAN_EFF_FLA=
G on transmitted J1939 frames
--

commit 19b14aab4922e084b42afa782b6d7a0743ee25d8
Author: Oleksij Rempel <o.rempel@pengutronix.de>

selftests: can: add J1939 wire-format tests against CAN_RAW

Add a test that pairs a J1939 socket with a CAN_RAW socket so the actual
CAN frames on the wire are checked in both directions. Both PDU1 (destinati=
on
specific) and PDU2 (broadcast) single frames are covered.

> diff --git a/tools/testing/selftests/net/can/test_j1939_wire.c b/tools/te=
sting/selftests/net/can/test_j1939_wire.c
> new file mode 100644
> index 0000000000000..8f5113394f990
> --- /dev/null
> +++ b/tools/testing/selftests/net/can/test_j1939_wire.c

[ ... ]

> +/* J1939 TX -> CAN_RAW: destination-specific (PDU1) single frame. */
> +TEST_F(j1939_wire, tx_pdu1_to_raw)
> +{
> +	uint8_t payload[8] =3D { 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88=
 };
> +	struct can_frame frame;
> +	canid_t id;
> +
> +	ASSERT_EQ(tx_to_raw_send_recv(self, false, PGN_PDU1, SA_PEER, payload,
> +				      &frame), 0);
> +	id =3D frame.can_id & CAN_EFF_MASK;

[Severity: Medium]
Does this code need to assert that CAN_EFF_FLAG is set before masking it ou=
t?

By applying CAN_EFF_MASK, the extended frame flag is dropped. Should there =
be
a check to verify that the transmitted J1939 frames are actually extended
frames, rather than standard frames that happen to match the lower bits?

> +
> +	EXPECT_EQ(J1939_ID_PRIO(id), PRIO);
> +	EXPECT_EQ(J1939_ID_SA(id), SA_LOCAL);			/* source address */
> +	EXPECT_EQ(J1939_ID_PS(id), SA_PEER);		/* destination (PS) */
> +	EXPECT_EQ(J1939_ID_PF(id), J1939_PF(PGN_PDU1));
> +	ASSERT_EQ(frame.can_dlc, sizeof(payload));
> +	EXPECT_EQ(memcmp(frame.data, payload, sizeof(payload)), 0);
> +}

[ ... ]

> +/* J1939 TX -> CAN_RAW: broadcast (PDU2) single frame. */
> +TEST_F(j1939_wire, tx_pdu2_to_raw)
> +{
> +	uint8_t payload[8] =3D { 1, 2, 3, 4, 5, 6, 7, 8 };
> +	struct can_frame frame;
> +	canid_t id;
> +
> +	ASSERT_EQ(tx_to_raw_send_recv(self, true, PGN_PDU2, J1939_NO_ADDR,
> +				      payload, &frame), 0);
> +	id =3D frame.can_id & CAN_EFF_MASK;

[Severity: Medium]
Similarly, should this test in tx_pdu2_to_raw() also assert that the
CAN_EFF_FLAG is set on the received frame.can_id?

> +
> +	EXPECT_EQ(J1939_ID_PRIO(id), PRIO);
> +	EXPECT_EQ(J1939_ID_SA(id), SA_LOCAL);			/* source address */
> +	EXPECT_EQ((id >> 8) & J1939_PGN_MAX, PGN_PDU2);	/* full broadcast PGN */
> +	ASSERT_EQ(frame.can_dlc, sizeof(payload));
> +	EXPECT_EQ(memcmp(frame.data, payload, sizeof(payload)), 0);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014154435.3577=
983-1-o.rempel@pengutronix.de?part=3D5
