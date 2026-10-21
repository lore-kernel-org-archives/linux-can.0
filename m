Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792623532;
	b=Z9xtWjd9zB8eZZ4zd9pPqQ1wzwoaj3wE2B563ZWGSd9QdfLBoNcPTp3KDGk3igDseNRs
	 i4WNWRHfxfB9LBSzMZPm3+kS/3vueY36NCwMxR1hziAcQZ3bY9XrB57275xQ03tqG9188
	 dTleexIxo0lGBIleSE6IzqjK8N3VOyJ8naqrml6OiDFtuKjK7qH/f0D9r60eaoytLtusU
	 ooRv7aL8k+mo3v57JNNyH6zhkzIPo3BrHrGxvlHa6iD+CErNfoD6eNuschlCEdXMdKeDw
	 Mzq5JW/nhNIvGKqcYh17XuYLPku3IgqpRB1L5UseFqtSwiemZVr0LEHvP+kJ8Cl/3OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792623532;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Qrw0QTI4Cx2Pl9bMSUFk83e+oqBDqQpK6OC1OOm7cuU=;
	b=cV8B4qDExEJXxc89DAOpbzJrFDpPBaSjhHauFu1oCPutPuhP314PPzyuj3GRwDcflRlW
	 sJWvt0K1d9/uzaRKRiL7gpYynNF3iPfoB4QZfQSxxFU27MfqbgEIh7ag5N/aoWmc5pDDb
	 4V1UeFiHbz9hn/CCI5j7kx7fdZZ7kTP6dWCeDbx1erXBx4VoUS3zJ1cC8AUlLdosYhR25
	 4t1W03dlAkCQ8kOLo748ugFpUmWItHsNeXe7nZhH2gQDZ/z0LU5s1xrFJYRxcmICnmWbd
	 4nq+y1q3QB44z25mloXMMaw9QvMfNMjSvVFnO0SuejeS0uVAWhD3x+r/1yeLou25agg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NaxNiRGE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546F7606A325;
	Wed, 21 Oct 2026 22:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NaxNiRGE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A184D1F000C2;
	Wed, 21 Oct 2026 22:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792623532;
	bh=Qrw0QTI4Cx2Pl9bMSUFk83e+oqBDqQpK6OC1OOm7cuU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NaxNiRGEsz1LdRQV13UUqpjgN+3aQplIMY/lkTQ3mvOlxYQrg6sHE/SV0Dgv+5fOC
	 rDeKxAujpFeIzW3U4Fd+NPtAeVWghsa78UBh5nnQkYl6NPk9ocvm/Zje/6u4bBXdkg
	 wp4q0LC1XH82dtdkFTZqz0DNEDMkyJM2UkXnDZeB3zzWfkNkQzaiySOkFeF5cJzR9x
	 NdaQsckws1hD+WD/jcMXEI2Tcpf78J1o0TBhiiniuJWT9fixCC4ureJb1VTRt+c9gm
	 CjXI6uUUE3JnXxShkU2Dl87BLdpTDZPvU3FhiOIENVzKoVuyhDxfPjNMKCnqjZc+uo
	 BmZ9RUDnj6I6g==
Subject: Re: [PATCH v3 07/10] can: peak_usb: fix RX cursor desync for
 self-received RTR frames with SRR
From: netdev-bot+sashiko@kernel.org
To: stephane.grosjean@free.fr
Cc: mkl@pengutronix.de, mailhol@kernel.org, error27@gmail.com,
 wg@grandegger.com, s.grosjean@peak-system.fr, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Wed, 21 Oct 2026 22:58:51 +0000
Message-ID: <179262353124.3131.13235647451945152794@kernel.org>
In-Reply-To:
 <20261020-canfd_check_channel_idx-v3-7-74d17c5a599e@peak-system.fr>
References:
 <20261020-canfd_check_channel_idx-v3-7-74d17c5a599e@peak-system.fr>
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

- [Low] The rx_bytes counter in pcan_usb_decode_data()
  (drivers/net/can/usb/peak_usb/pcan_usb.c) can now count bytes from a…
- [Low] This patch is tagged `Cc: stable@vger.kernel.org` with `Fixes:
  3a7939495ce8`, but it is written against the tree after the earlier…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but
  pcan_usb_encode_msg() and pcan_usb_decode_data() use different payload…

--

can: peak_usb: fix RX cursor desync for self-received RTR frames with SRR

This commit moves the skip of the SRR client private id byte in
pcan_usb_decode_data() out of the non-RTR branch. The byte is now skipped
whenever PCAN_USB_TX_SRR is set. This matches pcan_usb_encode_msg(), which
appends the writer id byte for both RTR and non-RTR frames.

> Fixes: 3a7939495ce8 ("can: peak_usb: PCAN-USB: add support of loopback and one-shot mode")
> Cc: stable@vger.kernel.org

[Severity: Low]
Will this apply cleanly to stable trees? The hunk removed here is the
braced form that includes the mc->end bounds check:

	if (can_id_flags & PCAN_USB_TX_SRR) {
		if ((mc->ptr + 1) > mc->end)
			goto decode_failed;
		mc->ptr++;
	}

That bounds check comes from the earlier patch in this series, "can:
peak_usb: harden PCAN-USB message validation", and that patch is not
tagged for stable. Stable trees that have 3a7939495ce8 but not the
hardening patch still have:

	if (can_id_flags & PCAN_USB_TX_SRR)
		mc->ptr++;

The hardening patch has a Fixes: tag, so it may get picked up anyway.
Even so, should this patch name the prerequisite, for example with a
"Cc: stable@vger.kernel.org # <prereq>" annotation as described in
stable-kernel-rules? Or should the hardening patch also be Cc: stable?

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
> index 93da0fd4f10e7..4c8cfed31634a 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
> @@ -697,16 +697,19 @@ static int pcan_usb_decode_data(struct pcan_usb_msg_context *mc, u8 status_len)
>  		memcpy(cf->data, mc->ptr, cf->len);
>  		mc->ptr += rec_len;

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch. Can
the RX cursor overshoot here when the DLC nibble is 9..15?

pcan_usb advertises CAN_CTRLMODE_CC_LEN8_DLC. In that mode rec_len is
status_len & PCAN_USB_STATUSLEN_DLC, which can be up to 15, and
can_frame_set_cc_len() caps cf->len at 8. mc->ptr is then advanced by
rec_len, not by cf->len.

On the TX side, pcan_usb_encode_msg() writes the raw DLC into the
status/len byte. It then copies only cf->len data bytes before the SRR
writer id:

	/* status/len byte */
	*pc = can_get_cc_dlc(cf, dev->can.ctrlmode);
	...
	/* can data */
	if (!(cf->can_id & CAN_RTR_FLAG)) {
		memcpy(pc, cf->data, cf->len);
		pc += cf->len;
	}

Suppose the device puts only 8 payload bytes in an RX record with a DLC
of 9..15. The cursor would then skip rec_len - 8 bytes of the next
record. That is the same kind of desync this patch fixes for RTR+SRR.

This depends on the firmware's RX record layout, which I could not
confirm from the code. The mc->ptr += rec_len line dates back to
46be265d3388. The len8_dlc handling came with 4c01fc87675e ("can:
drivers: add len8_dlc support for various CAN adapters"), which carries a
Tested-by.

>  
> -		/* Ignore next byte (client private id) if SRR bit is set */
> -		if (can_id_flags & PCAN_USB_TX_SRR) {
> -			if ((mc->ptr + 1) > mc->end)
> -				goto decode_failed;
> -			mc->ptr++;
> -		}
> -
>  		/* update statistics */
>  		mc->netdev->stats.rx_bytes += cf->len;
>  	}
> +
> +	/* Ignore next byte (client private id) if SRR bit is set.
> +	 * Note: this test must be done even when the frame is an RTR frame.
> +	 */
> +	if (can_id_flags & PCAN_USB_TX_SRR) {
> +		if ((mc->ptr + 1) > mc->end)
> +			goto decode_failed;
> +		mc->ptr++;
> +	}

[Severity: Low]
Can rx_bytes now count bytes from a frame that is then dropped?

Before this patch, the SRR bounds check in the non-RTR branch ran before
the rx_bytes update. Take a non-RTR record with PCAN_USB_TX_SRR set whose
URB data ends right after the payload. pcan_usb_decode_data() now does:

	memcpy(cf->data, mc->ptr, cf->len);
	mc->ptr += rec_len;
	mc->netdev->stats.rx_bytes += cf->len;
	...
	if ((mc->ptr + 1) > mc->end)
		goto decode_failed;

decode_failed frees the skb, and rx_packets++ is skipped. rx_bytes is
then out of step with rx_packets by up to 8 bytes. Hitting this needs a
truncated URB from a faulty or malicious device.

Would it make sense to move the rx_bytes update after the SRR check, next
to rx_packets++?

> +
>  	mc->netdev->stats.rx_packets++;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020-canfd_check_channel_idx-v3-0-74d17c5a599e%40peak-system.fr
