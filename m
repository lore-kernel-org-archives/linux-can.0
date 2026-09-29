Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DD23F4DE9
	for <linux-can@vger.kernel.org>; Tue, 29 Sep 2026 15:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.226.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790697476; cv=pass; b=k5STdYj4/fgfoavEnEJhj54vzK4dXuf8/g4RngoNC50UL8jSQCZDUgynfJ47nuM8azpFot7ovmGyeunU5V+MwsQZGLdV+MqH2nKbdhZ0Y/N+L9NJ3lBlT4WnFSGrgtPbEYVi11YSqKdpM4e1Z9MiPUJJR1h+fk/bkYQgHts5Ohs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790697476; c=relaxed/simple;
	bh=0Xkn/B6B8q84wCCaWbE9AN1vjBCvBec6bVUfEV+VNJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bS9ONcHLrXV3u2ohkUaEVBUOOhDH4n/EuEWUN80lCuw6s4iHqx3CHHMlrYu1MfKzLl8svPTQLmRL/TOD5V553K2gzDhMLPDOrKO0PKyg6e909fDIZ58Vjkkhg/yINAGSNsR6QRPLq/bDt78gg9grVbrhC/TUCb6bRMffDXR2cGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flocksafety.com; spf=pass smtp.mailfrom=flocksafety.com; dkim=pass (2048-bit key) header.d=flocksafety.com header.i=@flocksafety.com header.b=WunLYUD0; arc=pass smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flocksafety.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flocksafety.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flocksafety.com header.i=@flocksafety.com header.b="WunLYUD0"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-982db8d3b79so1179492241.1
        for <linux-can@vger.kernel.org>; Tue, 29 Sep 2026 08:57:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790697473; cv=none;
        d=google.com; s=arc-20260327;
        b=EBX5pdX95/5sctZThyNEKShlTLpIvX5JnyvOus03zkdKP/Ah4P8EupEiJeuxId+5fM
         LEhjSjRo7oJydFDLWYycaKV7dHKWnqVXsi+Yr74WgTLuAiXXCjEPPpdZKwoXOIX+bfkF
         J6+pC1p3TIHpMU1vz4dhswo9qExsP4fRDcjT9rFsPNUeDuoxXaW23tDR/PIpxKWbY6XT
         ENJCUjOKW7gHpvyXu0XdQtDzQmmrWOPm33ex+QLPS6MutKGI2u6XOvFol7YWEHJnP7nD
         qajV3okPa2RQz1MNGfsy/6GyZuClPVf5xuZtT6ZrsGbFqw4pfXZCrrAdxOFbMAFXpIKZ
         7GJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9ANnzi1cug5jRVn6Pwq9l+PSbd41x7msP2E04gg5u6E=;
        fh=AUibsIqy+Jan0XKxEKXEulZWXDZ+sN2J3qXVATkOptA=;
        b=LI94OGCLQQIgMhicUendmUd9jvb70qVqnzL9ich6mrqL5WWkLDe67oL+G7fEu13jHZ
         o6FBFleGfucxRgJVTlW0TbTa5CA5Kykwc3MHMzCya9FlZ6xd/eflbbsNsNUiJmsQb5gO
         aKPN3FJjd4vond4tPuUXUDTviwFJ1+STnqNngge0kQf9/7eFd4Gcw4KLRmGBiA2eTL83
         X2woCjnwA6OuKdSxCBpcIiSCn7lqaHCI7xO/R3Db3E/0cm435iynSGD8P7lxUGnw5iyS
         RzP+pYROSVLxVVo/Pk3s8sYtlRzBUVjzJc14wjBu2Nj/2t8AL2c8jtWm6vpZPFXe81x1
         SoJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flocksafety.com; s=google; t=1790697473; x=1791302273; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9ANnzi1cug5jRVn6Pwq9l+PSbd41x7msP2E04gg5u6E=;
        b=WunLYUD0F+AhGsuScM1HX0vyD6QPF2loXjURSPiNBHwpJvdpm1s7B1LZi9jPtK/eW+
         JjFbFoCOO1CxNGa4GxjtzxKQ0MHAfiFSF9U0B0Om/3GDF+42+C24oYgPseY98/B36JCr
         H4lNjRiro2PtiUshMh35ZK0U/FJzYUxRVv1vv4KWpI38xrPt6U5dOWCS1aaUlCGbnWNp
         8Me1EsBnl2UMxZ1Zd+Xz/MRS1pmuefqYVeHloT3uc9XzTWTsvZhYymtNNYEDG6Kk9bUR
         /4IP5B0hpYBh0T6xcxHaFzxn+TA+r6yhaUCAbATZuub/wEEwGji/Es3e5+Hh0r3rY4fo
         cTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790697473; x=1791302273;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9ANnzi1cug5jRVn6Pwq9l+PSbd41x7msP2E04gg5u6E=;
        b=xrz6liL+4jb2DOhb2U7HtNk4Cmw6VKTVAODkj1iAyJ/UuNB/GAM7QAqJoRsCobLt1H
         8OK+i/VP8gYHQiBhsOvwaSS58tvzRcMPkZmI3Mo/fLKO7Rc0YMvZ23YStOOgtYzOUBSF
         glWJ7OcFKkn4DxO9ucnghEdUo6J0ESX+b5fkCeyNLjWoI3xKZJLyBME0eDVa5OY/gzxR
         kV6rd6jCsDXzGJ1FUfSFGdWH5pbAPSQ+HTpAyeCyUB4mR0aRIuTkL6x/RHT5FtPXXaYp
         KSemJkB6Ijb53xHOfQtpWwUJ+m7Z+u/ZoFEshhwnFy1uhqdBPxnI3mEZjrkzKPjpMBAZ
         7qzw==
X-Forwarded-Encrypted: i=1; AKwUvBxWzhgt9/6Ru2/den9/aHV87jDdUmfadGgEcCMaWUJR31lnsEN9JSGJLN2aqKToSgBCj3xucQ+y3/Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYJdRAInR5C/BqxciBm03H9zXKwCqAnCx2Nvf7oXiDFAHljBfPsn
	uOfbJ3bdgO7rn4hp1iOqqTijy/Odpvgw9gOdWT0ZxNAw6ugdEPFebhSwaibRm1YkXrLWxszuzSW
	A1OFZxk6dYxcsitgEPOYmcHVH6NZ0zWaPRJuwmQJGCrieSAshgPM46jjWJA==
X-Gm-Gg: AYBFou3rNrifgA1Gc/hRpiJ+/bRZrQiJ4l1VTVSZqMsubO91xk1QNwM51JgdvocUfwS
	EmoUfcgl5WamHTO5xaUZlPN4oibdz8V4sFzYB19l2whPO39P6ngBrx9CiwckPz0LYe98xVO/dTN
	8SfWgQDAfnHbZvXJT3YsBaei58LIEhmSO8tpVF5P9nqGbBonMxaAAYBPVwZ+hxQe9X/YAgfdwew
	81cLwDIH9kuQrKtQ2EAhBVin5KkgtXSQ0eLbW8F9QoKNU/iv14QXt1zNEmjPl00Ayc1OF7q4lhm
	ZdHZhD/pXViByPuO/CulOVIRCmUo6KODNU2oLH5O1b26PCqYmrhr9C4=
X-Received: by 2002:a05:6102:5707:b0:7a4:85a8:fbc5 with SMTP id
 ada2fe7eead31-7af1d1bb461mr5221468137.16.1790697472984; Tue, 29 Sep 2026
 08:57:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922-upstream-can-rx-offload-batching-v1-1-099e7ca12c91@flocksafety.com>
 <20260929-intrepid-hopping-ibex-f5349c-mkl@pengutronix.de>
In-Reply-To: <20260929-intrepid-hopping-ibex-f5349c-mkl@pengutronix.de>
From: Chris Strong <chris.strong@flocksafety.com>
Date: Tue, 29 Sep 2026 11:57:41 -0400
X-Gm-Features: AclHuK8iY9QtdGOUHMH7zCl-KAW0zQEGd3GX_tnL_qvKVNzOTjheFapgAU19FNg
Message-ID: <CAFe7wHOKH8my0zXRNsLNf_vHeiP+ZoZi=Qa-X6CiJ0FkSVZYNw@mail.gmail.com>
Subject: Re: [PATCH net] can: mcp251xfd: flush RX offload queue during long IRQs
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Chris Strong via B4 Relay <devnull+chris.strong.flocksafety.com@kernel.org>, 
	Vincent Mailhol <mailhol@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Thomas Kopp <thomas.kopp@microchip.com>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marc,

Great! Thanks for the review and feedback. I made the changes and sent
the v2 patch series as suggested.

Best regards,

Chris


On Tue, Sep 29, 2026 at 10:49=E2=80=AFAM Marc Kleine-Budde <mkl@pengutronix=
.de> wrote:
>
> On 22.09.2026 00:01:06, Chris Strong via B4 Relay wrote:
> > From: Chris Strong <chris.strong@flocksafety.com>
> >
> > Under sustained receive traffic, the threaded interrupt handler can
> > continue draining the controller indefinitely. Received SKBs accumulate
> > in skb_irq_queue, but can_rx_offload_threaded_irq_finish() only splices
> > them into the NAPI-visible skb_queue when the handler finishes.
> >
> > The RX-offload overflow checks inspect skb_queue rather than
> > skb_irq_queue. If the handler does not return, the IRQ-local queue can
> > therefore grow without bound while NAPI remains unscheduled. This can
> > exhaust memory and prevent received frames from reaching the networking
> > stack.
> >
> > Add a small RX-offload predicate that reports when the IRQ-local queue
> > has reached the NAPI weight. Use it to stop the dedicated RX interrupt
> > loop, process TEF and the other pending interrupt sources, and then
> > publish the batch. Publish additional batches from the main interrupt
> > loop while the controller remains busy. Since one RX pass can enqueue a
> > complete hardware ring, this keeps each splice near the NAPI weight
> > rather than enforcing a strict limit.
> >
> > Keep this policy in mcp251xfd because its controller-draining loops are
> > the source of the unbounded handler. Accounting for skb_irq_queue in th=
e
> > generic overflow check would cap memory use by dropping frames, but
> > would still leave NAPI unscheduled.
> >
> > Publishing smaller batches narrows the timestamp sorting window.
> > Ordering across batches is already best-effort; RX and TEF events from
> > each controller-status pass are processed before the batch is published=
.
> >
> > Fixes: c757096ea103 ("can: rx-offload: add skb queue for use during ISR=
")
> > Assisted-by: LLM
> > Signed-off-by: Chris Strong <chris.strong@flocksafety.com>
> > ---
> > Hi all,
> >
> > This is my first upstream Linux kernel patch submission, so feedback on=
 both
> > the implementation and the submission format would be appreciated.
>
> You're using b4, this is a good choice and the best tool for this job.
>
> Please split the changes into 2 patches, first add the rx-offload
> helper, then the mcp251xfd changes.
>
> The changes look pretty good to me! Good Work!
>
> If you want to improve you can shorten the patch description. The
> subject already states what you do, the patch description should explain
> in more detail (if needed) and why. Finish with describing your changes
> in imperative mood. See [1] for details.
>
> [1] https://github.com/torvalds/linux/blob/master/Documentation/process/s=
ubmitting-patches.rst#describe-your-changes
>
> regards,
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |



--=20
Chris Strong
Software Engineer III
flocksafety.com
chris.strong@flocksafety.com
