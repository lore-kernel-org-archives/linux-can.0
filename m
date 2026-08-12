Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2851F4631
	for <linux-can@vger.kernel.org>; Wed, 12 Aug 2026 23:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786579078; cv=pass; b=p2L6X6Ft8hK9MHim2nY9MvYw/oYovJCdJ0judrtMQUf8uNVteuTncDJHwW8R/2v3ey7WablJaoMA5vDW+I78aFouhQtd8xEpGovobgmnTqNNljh3rIEhl++LKJh6ggvdsH2MnSIu3t64pGO/wmTiLWEAnwrmv2591YrOtiBvhTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786579078; c=relaxed/simple;
	bh=cEq8LZFX9K3CVkTE7BIlhTH+Btyzmu+U8WtD1Pcj9Hc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kq68vg+83DgL5NgDdPKaAXQLtP71I3Ivzbr52kcFNNdDX36na5xqlp8plPp8n9qlRoXdBOn+BPVdS5hsbIIUpnHLA/WD9zon6e3WC+OOS2mHNriykrLCDRjz7AFDJlYuyzWHwVC0m5LE5moFqLu9jYr4N4LT4jyg3Cyf4AmLpGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=hHI13FZq; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="hHI13FZq"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso1685350a91.3
        for <linux-can@vger.kernel.org>; Wed, 12 Aug 2026 16:57:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786579076; cv=none;
        d=google.com; s=arc-20260327;
        b=TeOnrZXpPM1WKPaZkH1QPROir0aPGSOyK3eNt0k2MvLJNacrp7ZRshDw2EzceV+Un3
         pPT+xlxY531aQe+pNBa2gTPTGrLgpd+jftTEwjsNFduuGtW6hpTg1xqWxP7lheUHpxl1
         jKvvFo0AD/yqLIZWMrgsu1mFiNqaDetu1SEbKOyBXQjAJVvrbIYdljltuEMRKTqkrKSe
         WqtYGiwrW8yfmYcfBELyacJuotxcanL690I+PuvYDORBq0DCf5mmmFEUd0yIh/0co4hR
         8EP3/TnrXYtjCma+gK3P8lxlAmqGWd2ZRFkrT4agx8lvdO8pbxwxi3GCMYs6/0+quDoG
         etag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BF3EIGfmKfNca6MaV9gZAoGmEk3w7RQtA/KxT1S0FcE=;
        fh=mn2OEbEQjSxsOAKpTVSoUkZAprVtgfRJxk95cXXuLmY=;
        b=nVnOJulUY0520Z1f7mX3lkN3PHKLtnnEw4l0EWxqNNPuK2djeFpmnwmTfw/nPzwERn
         GlewnTspwvADWdBds9nDJwve1xLRu053VgRFjr5ZZj7sWoH00HkW8nFO69bfndHUO9ht
         1xiE28gWCQ8/i7R2BKIj1Q/rz89vH+8u+ad18/KuKXC9npMCS8ifDzBQ1GikmuSqC1i0
         aR3VKA3wq8jW2Mua4r+FoHUdAHfKeT9CxUvoDarkygKq3+TwqzCKHhyXFi6EuldZWhBU
         YgcPiNT5RLbwrJ1nDhoIR/2RORf3Ag+lWqO0gs6J73zGDPcR6wpajQiL3vdJJdR9vsnI
         wxYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1786579076; x=1787183876; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BF3EIGfmKfNca6MaV9gZAoGmEk3w7RQtA/KxT1S0FcE=;
        b=hHI13FZqt5SFzECh+6s/7rLO15zCyMRY4BQjnSvrSd3f/IZ8+tnxPIRrQMtDeYv1A1
         Bp7A2xFy6uAd2jRuIwM4sRFWr5S6nfEFrpgCzdtIMQ97RTdUdRcMWMger+8utzLmU8MP
         3Ud+PQln6yHDSG0cZfEqm63NOoYydE5rAntd/QlVN3IZToIIMDitL7odwvcD23Nf3hbz
         4MXSCm4ifUdEeHLMs9Ov6oD6/YeLIy+Lv67QDxDNPIc0uW6f7k06noM1fGyQLRuUwHbZ
         ul4qClal/jXnOGfZ0iW9VWu0ERu+kZHG/sX22WsAj2yptoyRja9cyIOLslLF8XVYwg84
         tGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786579076; x=1787183876;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BF3EIGfmKfNca6MaV9gZAoGmEk3w7RQtA/KxT1S0FcE=;
        b=EkLbyAIW9nS168uLHJBXsMQujYGpUxZHrVsADBAYgoV5V5g0GhYsZ4Epbd4jZ+8mHa
         hoiEutK4aLfJYmhVRsl0hEIY1k+qLvc1vlGnKwaOczXLFIAT10r0ZKYGhXYGIVN7/sF/
         vZHRysmFD3WS7lQbZcaalGutS9Fou49OBWU7NEd7vL+vA2cZsmFlk4wUyrYvaf2szLvt
         8jLIdf/3CyMtvPtTLckJLPTVnfcgsLAC2xRwgvkDn+Q5xQTk4HdKKdr1i8YIHsqVRQPQ
         irOWTghvo6lbOXPUei/Gtv7ZQPLC1n4YkRYkAsc5/LX75GJuPBeeoEdvUQGpFCoGdy0u
         yYvQ==
X-Gm-Message-State: AOJu0YxbivBh9OsrPHWrZ5xtttmS/FvH2fcUETDd76zQ2MpTnBrhhVxK
	ZvF/Tr8Gj5p2+9SzrzK2NlawJhR0eeACDBvq+jviJsiMNsLEUsrS5VZbdstpWKlLunb6Y/43BLx
	iW1JiaYgOODEbFDYDTFmCBIKa30Cwq/ZlBYkznIQ1
X-Gm-Gg: AR+sD12Mg30L6J5pIhhYX1bq7xWfhgDYdYA+GaIAnDylzSR6Y9pjTFkSBtlrroV4zJw
	TaW4y91ZAixwNAeba6YB6NbPaNfYZFy/4HTigu/hHuZg8IpoOziBOwHpnge5S+NMBNZ/MQC07iD
	q8IY5vDE/IBQuTxhqmvJtZRdItZpsKqpRxbGYcjllYuUpuQa3CwGCy2yStwmIYuCYNE6qRrBvcu
	7hFFQXY7itLpRlPDnaXtUS+ZyuHzBIMHSvb9/EvIrEP/wfE57XvFrHAiU5DjGOsgTWksLz72eiA
	yov1ziwsUVYHHo25TmopcaPN/p3gXoKG9rTd8u4xrajm09pKe9M=
X-Received: by 2002:a17:90b:46:b0:36d:b424:4f17 with SMTP id
 98e67ed59e1d1-3931dfdd5bdmr2330073a91.1.1786579075840; Wed, 12 Aug 2026
 16:57:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706011131.2445034-1-xmei5@asu.edu>
In-Reply-To: <20260706011131.2445034-1-xmei5@asu.edu>
From: Xiang Mei <xmei5@asu.edu>
Date: Wed, 12 Aug 2026 16:57:45 -0700
X-Gm-Features: AUfX_myX2iACpKBbzVSLqTzJI60tqaosc49vHTA4DIPHYNuyc9ot4HnrxoY8CLs
Message-ID: <CAPpSM+Sn2vOg3xQBBRBvt8m-cvW5-f27xPL=N32yiwT5Nqb0Jw@mail.gmail.com>
Subject: Re: [PATCH net] can: j1939: zero the reassembly buffer to avoid
 uninitialized slab leak
To: Robin van der Gracht <robin@protonic.nl>, Oleksij Rempel <o.rempel@pengutronix.de>, 
	Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi maintainers,

Just a reminder to avoid spending time on this. A recent commit fixes
this issue:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=
=3Deb96c5890792

Xiang

On Sun, Jul 5, 2026 at 6:11=E2=80=AFPM Xiang Mei <xmei5@asu.edu> wrote:
>
> j1939_session_fresh_new() allocates the reassembly buffer with alloc_skb(=
)
> and exposes its whole data area via skb_put(skb, size) without zeroing it=
.
>
> For non-ETP sessions j1939_xtp_rx_rts_session_new() sets pkt.total from a=
n
> attacker-controlled byte of the RTS/BAM frame (session->pkt.total =3D
> dat[3]); a mismatch only warns and does not abort. A small pkt.total mark=
s
> the message complete after only a few bytes are copied, and
> j1939_sk_recvmsg() delivers the full skb->len, leaking the untouched tail
> of the buffer as uninitialized slab memory.
>
> Zero the data area with skb_put_zero().
>
> Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> Assisted-by: Claude:claude-opus-4-8
> ---
>  net/can/j1939/transport.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index df93d57907da..2e062f7d277d 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c
> @@ -1568,7 +1568,7 @@ j1939_session *j1939_session_fresh_new(struct j1939=
_priv *priv,
>         }
>
>         /* alloc data area */
> -       skb_put(skb, size);
> +       skb_put_zero(skb, size);
>         /* skb is recounted in j1939_session_new() */
>         return session;
>  }
> --
> 2.43.0
>
