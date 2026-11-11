Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794394384;
	b=SIpFz2LMcrMP2HhhAfkNTIIUC0493kpoQhJ/5PySs9spnrMrIvwPmXGBl0sMlgaK4etq
	 X7/WV1UOUm1ELH27Lo2pAhW6KOjuM8hnrw6cTQaG7LrPg3MdkVQ0VdjqSIKE4E14YB1of
	 i3Wy3W7mDlFtUQQXJTs2JsTTzg0js89yeoUSeUcamRHUMHf6thxiB/MoGRi/WJT7KkWMW
	 uVE+AGHRlsnaZrP9fmXjbNyKkZ9eSFJax4RdMRIKIWMd1ZxtA/3y7XWzb5BFPhQ70YUDn
	 ZRhXUxZTpse5E6euTyAwgs60s/Av3mdr+dbmvrt0/DPvPhuhB74eyf8+t6Kt7uWM+jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794394384;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xyAsKOeEkU9gEq6NVT1lsNdIbUFhQ2YQsZwsMTxzgo8=;
	b=AhzWr58g/bgCJf32JnezYT4eOfN+CzqFPz2MJCLfNMf5kLXj3F572FHHJnfrBd8mDRHo
	 SNANQPPiu6BapYE9RaMMuBWDnKNAX8naSySeJ/VIDMzhSWRWx2y5f6jdbK1/c2RL/Qy+s
	 +Gkz2gwCAO7SFtZEJ26IWOzOhEBH1IWKI7I5Pm4nuJBTxjVRV6Kie3OEXUO319QL+nJ2F
	 V/aOgvDX/L6eDLgKDbOFbjo55fv1npHuHzMaln/9rtcObb2mhbLrEkXuNg6AfiMay97yp
	 q3TQRHLt3RlMQmwCm4cvPcSWAjvZYP4eYHLlFmraiYgAPJdZhP7SbmYjKhrlbaAMvsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SXuOCEX2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C845F606A324
	for <linux-can@vger.kernel.org>; Wed, 11 Nov 2026 10:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SXuOCEX2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 034B91F00A05;
	Wed, 11 Nov 2026 10:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794394384;
	bh=xyAsKOeEkU9gEq6NVT1lsNdIbUFhQ2YQsZwsMTxzgo8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SXuOCEX2n8jwOCI1esi5EWoRrGal09jIVnhUF4EXTZJ3QXTe8HBRr1DwMoEjJJoYA
	 WBM9BWGxdtPMvTvFamwv/fq5/8Qt+P/0UtfC9PF1o9Jj0dWbhywV/cjfLWFLod5pTY
	 Ye6ErdvY+KGwBWoat46jUOTb3x9hC51d9WwLGlEUgKNAVxZxSaXQUDXkVkSUAW65HB
	 w65XjLzNjI584GJ0dqso4iJSPVV51Xm9K2nxwzsVsK4+8GcTlsxQrgUKEhfn4EnJD0
	 peDsetn1fd2RFXyGyIw3lgtQT1jyfU+r7VvLVFmuZ3WNroZK5YYJGIg3RP6Zq/9M3C
	 eqyRV3VJTPegg==
Message-ID: <sashiko-outbox-208835@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v9 4/4] can: j1939: reject a CTS that names more
 packets than the message has
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chaosheng Qu" <chaosheng.qu.linux@gmail.com>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261111-j1939-edpo-v9-v9-4-e779ca334a81@163.com>
References: <20261111-j1939-edpo-v9-v9-0-e779ca334a81@163.com>
 <20261111-j1939-edpo-v9-v9-4-e779ca334a81@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 10:53:03 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] can: j1939: j1939_xtp_rx_cts_one() rejects standard CTS(0)
  frames
--

commit f78a7d16999ed9ed258185b1a1c2d5e0047f0b04
Author: Chaosheng Qu <quchaosheng000406@163.com>

can: j1939: reject a CTS that names more packets than the message has

This commit aborts a J1939 session with J1939_XTP_ABORT_ECTS_TOO_BIG in
j1939_xtp_rx_cts_one() when the received CTS packet number exceeds
session->pkt.total.

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index fc2840f334b5b..377991d36dc6a 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c
> @@ -1512,6 +1512,15 @@ j1939_xtp_rx_cts_one(struct j1939_session *session=
, struct sk_buff *skb)
>  		goto out_session_cancel;
>  	else if (dat[1] > session->pkt.block /* 0xff for etp */)
>  		goto out_session_cancel;
> +	else if (pkt > session->pkt.total) {
> +		/* The responder asks for more packets than the message has.
> +		 * pkt - 1 becomes pkt.tx_acked below, and the transmitter
> +		 * reports that value in an ETP.CM_DPO, where it would name a
> +		 * packet past the end of the message.
> +		 */
> +		err =3D J1939_XTP_ABORT_ECTS_TOO_BIG;
> +		goto out_session_cancel;
> +	}
> =20
>  	/* set packet counters only when not CTS(0) */
>  	session->pkt.tx_acked =3D pkt - 1;

[Severity: Medium]
Does this regression reject standard CTS(0) connection-hold frames?

Per SAE J1939-21 and ISO 11783-6, a CTS(0) frame (dat[1] =3D=3D 0) sets the
next packet number field to 0xff for TP or 0xffffff for ETP.  Because this
check runs unconditionally even when dat[1] is 0, any session with
session->pkt.total smaller than 0xff (TP) or 0xffffff (ETP) will abort with
J1939_XTP_ABORT_ECTS_TOO_BIG upon receiving a CTS(0) instead of reaching
the CTS(0) timeout handler further down in j1939_xtp_rx_cts_one():

net/can/j1939/transport.c:j1939_xtp_rx_cts_one() {
	...
	if (dat[1]) {
		...
	} else {
		/* CTS(0) */
		j1939_tp_set_rxtimeout(session, 550);
	}
}

Also note that updating session->pkt.tx_acked, session->pkt.last, and
session->pkt.tx right below the new check when dat[1] =3D=3D 0 contradicts =
the
"set packet counters only when not CTS(0)" comment unless both the new
bounds check and the packet counter updates are gated on dat[1] !=3D 0.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-j1939-edpo=
-v9-v9-1-e779ca334a81@163.com?part=3D4
