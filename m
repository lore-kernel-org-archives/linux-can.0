Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270E93B5310
	for <linux-can@vger.kernel.org>; Sun, 30 Aug 2026 14:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788099177; cv=none; b=P19TN/GT2rqpTkB4+IQ6jzQEGOQyR1I9qtnEm4+0fcBHPgkpYI6zBhPEVl46I+kCCWZtLRSQYSYcEugSL0LIWgoLI10PozBM6nXVN/n6AteT3YJJAnknCsiDolAiGQkerdzQp0Xt10TFI/Dzh2hxJEO+W2N7kXGdipIDuJ6N93s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788099177; c=relaxed/simple;
	bh=11XAJfFuawCc1JZGky2Ntr4cuxkF6yZAsLuEASMyRq4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MXZ2Hf1ceasi68ocBDmdfcAiQYixuyb2V4YZwfMGC3wmqwFdcxrQlIWET+VyElyrogxlQ8kYFdgEno7De4xmH5ACioYoGl6qQNdeea31g9qHBOramZatX+Kwi9+R+uOqhhjsb2inrY8d74wOhonR7iEs/MqH/7lrEYPDZ9K0tIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0Tq1xyN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0Tq1xyN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B82D1F000E9;
	Sun, 30 Aug 2026 14:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788099175;
	bh=v6goPDdLP95Ex1TEcSmBHd5Q3vF4I5uZqJ2teuFVJww=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l0Tq1xyN4diQ4QN4l/WLhfUJ2/aVICiv0uUNIZQVJ+Y5mfRvhEDk5jKIANXIRiTj4
	 7ahjt4+746N9yYs+y32AXeEgs4NvJlO9D3acTxCXFijcoXeHqz067vqHVPN4G/sejS
	 +x+xX3cFQ2MYF7DIhDlNRKAiQ3K7/V1rXXWkc1I5qbcTRUyBhHVZr+0jAceH8p6Y9R
	 T3pBYSWhgCc5uDEQp7tOiKjxojkm1QzJ8b9+yr+kI41LPep8PQdanOaqfuFQk9EDBT
	 YaknhvoojjGsLrj4rebBf4wiHmoTcBbNFRIIly3QD8Pcor9ppjKHv3PKFqHgWdZWED
	 9sPLxQBf4M+Lg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] can: peak_usb: validate response and receive record
 extents
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <20260830135942.19449-1-pengpeng@iscas.ac.cn>
References: <20260830135942.19449-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 14:12:54 +0000
Message-Id: <20260830141255.5B82D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] OOB Read/Write due to unvalidated DLC in CAN frame parsing.
--

commit 3a2ad6057d438a3e936d788c2a9ec4229e3c427c
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>
can: peak_usb: validate response and receive record extents

This commit adds validation to ensure that both record headers and complete
declared records are present in the response and receive paths before
processing them. This prevents out-of-bounds access when parsing USB message
buffers.

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/ca=
n/usb/peak_usb/pcan_usb_pro.c
> index b6be8c19e537f..aaa5f4f7db191 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c

[ ... ]

> @@ -727,7 +740,14 @@ static int pcan_usb_pro_decode_buf(struct peak_usb_d=
evice *dev, struct urb *urb)
>  	msg_end =3D urb->transfer_buffer + urb->actual_length;
>  	rec_cnt =3D le16_to_cpu(*usb_msg.u.rec_cnt_rd);
>  	for (; rec_cnt > 0; rec_cnt--) {
> -		union pcan_usb_pro_rec *pr =3D (union pcan_usb_pro_rec *)rec_ptr;
> +		union pcan_usb_pro_rec *pr;
> +
> +		if (rec_ptr >=3D msg_end) {
> +			err =3D -EBADMSG;
> +			break;
> +		}
> +
> +		pr =3D (union pcan_usb_pro_rec *)rec_ptr;

[Severity: High]
This is a pre-existing issue, but there appears to be an out-of-bounds read
and write in how these records are processed later in
pcan_usb_pro_handle_canmsg().

When handling a CAN message record from an untrusted USB device:

drivers/net/can/usb/peak_usb/pcan_usb_pro.c:pcan_usb_pro_handle_canmsg() {
    ...
    can_frame->len =3D rx->len & 0x0f;
    ...
    } else {
        memcpy(can_frame->data, rx->data, can_frame->len);
    ...
}

If the device sends a message where rx->len & 0x0f is greater than 8, can
this result in an out-of-bounds write since can_frame->data is exactly 8
bytes long?

Could this also pass a malformed frame to userspace with a length greater
than 8, violating the classic CAN API contract?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830135942.1944=
9-1-pengpeng@iscas.ac.cn?part=3D1
