Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E6547CC61;
	Mon,  5 Oct 2026 12:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791202438; cv=none; b=NPVFVY28+mPB/agDVb74DfpwPsut9vLvaFhq7GhBPMX3R+RwJ3V14x8Z5qPEDDzwC6a5bgYnIqjTm9uDWnpbUKL5wCUZge+2AHuxxGYfve67Ge2qN6mK5/luaxtKhK7nzuBvJg4a9QsT0uzDk/0ZaECR5Pl6FyVFLGbZ8zzk/VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791202438; c=relaxed/simple;
	bh=OZdyrZOK2xUn1je1OQUMStdNQ/ua1+6/hCRqUgLzCq8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XBuONd6NbPs/8UIl0ySjkd/t+OXD+m1uHG0NJ6k0IaBoltbIHMtja3Vxv9YpfqUm/igUFLQb34aFBvqfjiLkcsP9D+HXStYd9iA1xEPSXwMU4vbgW5IHhM37KbSwaYZMujAlQrCLpTj7/zOGSmnZoTQ9/JxPdwkNVLGq+lGpuqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icKkfGQd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icKkfGQd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2102E1F00893;
	Mon,  5 Oct 2026 12:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791202437;
	bh=Dhk/iCQ57gq4ae6wQBVbZpHMPriGe2/uYAANPXTXcH0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=icKkfGQd9OYtPHVjJwhvPVMzhus6cNawwQAy1pvjaEq58px6uN4NQr9FEWccHoLeK
	 /UsazQSYzFHS0g4jCHHgjX+OhNMJ6NvZx6Ec5PW+MeUUtRNT2dJjg67v7XXkIWH6yb
	 TIfVdfv07LMSe/sDkVdjSYsmv9z46SJ2eW8FjjREpkRT2gALCK5i6oXK0qm1QDaoCb
	 a3Zx0lGdr/7F1iZGeygPsxj/sMdGX+sMdkoL8rtdNtHoVLWaAE0DvgM9UkIQlm7ZZt
	 yoL1efsLSy9P8Pe6ZjucnICbuCgVN4LLS1cJySIGs+4HpUjVCP+aowyQPKQa0NWcr4
	 kr+iWTAqvRdVw==
Subject: Re: [PATCH can-next 06/10] can: gs_usb:
 gs_usb_receive_bulk_callback(): add missing call to can_rx_offload_irq_finish
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: mailhol@kernel.org, kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Mon, 05 Oct 2026 12:13:56 +0000
Message-ID: <179120243664.1406898.1673520278617887925@kernel.org>
In-Reply-To:
 <20261004-gs_usb-cleanups-and-fixes-v1-6-7b4b06244a77@pengutronix.de>
References:
 <20261004-gs_usb-cleanups-and-fixes-v1-6-7b4b06244a77@pengutronix.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit fixes a real bug introduced by commit 24bc41b45583
  ("can: gs_usb: convert to NAPI/rx-offload to avoid OoO reception"),…

--

can: gs_usb: gs_usb_receive_bulk_callback(): add missing call to can_rx_offload_irq_finish

The patch fixes one error path in gs_usb_receive_bulk_callback(). That path
runs when the host frame has GS_CAN_FLAG_OVERFLOW set and alloc_can_err_skb()
fails. It now jumps to a new can_rx_offload_irq_finish label instead of going
straight to resubmit_urb.

> If the overflow flag is set for a host frame and the allocation of the
> error SKB fails, the URB should not be resubmitted immediately; instead,
> can_rx_offload_irq_finish() should be called, since an SKB may have been
> added to rx-offload.
>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

[Severity: Low]
The code change looks right. Should the commit message also have a Fixes
tag, so the fix gets backported to stable?

The regression appears to come from:

Fixes: 24bc41b45583 ("can: gs_usb: convert to NAPI/rx-offload to avoid OoO reception")

That commit changed gs_usb_rx_offload() and gs_usb_get_echo_skb() to queue
SKBs on offload->skb_irq_queue. Only can_rx_offload_irq_finish() moves those
SKBs to skb_queue and calls napi_schedule(). The same commit added the
can_rx_offload_irq_finish() call just above resubmit_urb.

The goto resubmit_urb on the overflow path is older (from d08e973a77d1).
After 24bc41b45583, that goto started skipping the new
can_rx_offload_irq_finish() call.

The commit message could also say what the user sees. Here is the sequence:

gs_usb_receive_bulk_callback()
    gs_usb_rx_offload() or gs_usb_get_echo_skb()
        __skb_queue_tail(&offload->skb_irq_queue, skb)
    hf->flags & GS_CAN_FLAG_OVERFLOW
        alloc_can_err_skb() returns NULL
        goto resubmit_urb  /* skips can_rx_offload_irq_finish() */

The RX frame or TX echo frame queued earlier stays on skb_irq_queue, and
NAPI is not scheduled. It is only delivered when a later URB completion calls
can_rx_offload_irq_finish(). On a quiet bus, that could take a long time.

Would it help to mention this delayed delivery in the commit message, along
with the Fixes tag?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261004-gs_usb-cleanups-and-fixes-v1-0-7b4b06244a77%40pengutronix.de
