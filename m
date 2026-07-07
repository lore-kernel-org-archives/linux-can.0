Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02BA34E74D
	for <linux-can@vger.kernel.org>; Tue,  7 Jul 2026 14:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783436075; cv=none; b=un89VOpI+OQTsg43xfxMYqqvJnRYd6gWLEGegwSogpj8VfQxyzOvIrBJcK/1WMNnFXgi/faBwJ05DEVUYhrWXFHifY6/O/XCuh7RcisdTXJVe0diMi3lTPtYm6jXPyWUOYijGZjdJIphf4niuNpSzPjNKrSf3hpNjSz7TkLOsLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783436075; c=relaxed/simple;
	bh=1iFHXRLMhClWhYAZV6swbTtGZsewk6gAzqtbkjRwRVc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RhBK9AglfIfWIN/7KDP32tm638TR9wx2nqGR0cSb2nfQq2Kih4kC0Y4cYHduB5SWgJaJANZuNtV8kD8t1ccIWZVLcd5Pe2LVoc2n+CA+t/Gj2/BEu/pvecLnkT19d7oGY4lG/zUnWO2DcNZIZzYCxXlq2ugmMfyEiAoCcYhOh5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGVIP0Zg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGVIP0Zg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2410F1F000E9;
	Tue,  7 Jul 2026 14:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783436074;
	bh=0CyFQ4adERS/94CpBpZ0O3TO3oJxghZ8Xt4/yzpP9Hs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kGVIP0ZgjN5GzKMqHIhI6MiCfoX+FyJSh6y3GD8yJgEhFu0g3UCOv73t1Y9h0VA6u
	 w1DV0U/oMfeCQg2usOhiTwrpG+a0sk/kKCaIzblcM/585inlY5NotzTGtPbdElnz5D
	 w6Cge+Zjy0T8kIWiVjY/SqM67mINTRF8VO75VkCjt/H98qH7/SmGGsltJtse6O4xA2
	 wFjOJz6WeBzoLZzwWqY2w24aZHd+JIL4CuG4Kuu/YAYQmEbHsQG+EHk4jh9EaLneBB
	 uI/CS9IGmXlfTw5ZMMw1PxEa3+UWKDBC3+EOB2kIZLFef/C7cmuL6mLPeND7CalqWe
	 hHVWIgIvwB7/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/7] can: bcm: fix CAN frame rx/tx statistics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>
In-Reply-To: <20260707-bcm_fixes-v4-4-aa87b8b9d33f@hartkopp.net>
References: <20260707-bcm_fixes-v4-0-aa87b8b9d33f@hartkopp.net>
 <20260707-bcm_fixes-v4-4-aa87b8b9d33f@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 14:54:33 +0000
Message-Id: <20260707145434.2410F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing RCU memory barriers when inserting new bcm_op entries into=
 rx_ops and tx_ops, and incorrect list traversal macro for tx_ops in a lock=
less reader.
--

--- Patch [4]: [PATCH v4 4/7] can: bcm: fix CAN frame rx/tx statistics ---
commit 55dc712979cc536660202ae53cf4b6529bfdf948
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: fix CAN frame rx/tx statistics

This commit fixes a data race detected by KCSAN in bcm_rx_handler by
using atomic types for frame statistics, and adds a lock-protected
helper for updates to avoid races during resets.

> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -229,10 +229,13 @@ static int bcm_proc_show(struct seq_file *m, void *=
v)
> =20
>  	list_for_each_entry_rcu(op, &bo->rx_ops, list) {

[Severity: High]
This isn't a bug introduced by this patch, but there appears to be a
missing RCU barrier when traversing and modifying the bcm_op lists.

Can the lockless reader in bcm_proc_show() observe uninitialized memory
here?

While the reader correctly uses list_for_each_entry_rcu() for rx_ops, the
writer in bcm_rx_setup() adds new entries using the non-RCU list_add():

net/can/bcm.c:bcm_rx_setup() {
    ...
    list_add(&op->list, &bo->rx_ops);
    ...
}

Without list_add_rcu(), the CPU could reorder the initialization of the
bcm_op struct to occur after the node becomes visible in the list.

Similarly, does the tx_ops list traversal lack both writer and reader
RCU protection?

net/can/bcm.c:bcm_tx_setup() {
    ...
    list_add(&op->list, &bo->tx_ops);
    ...
}

And later in bcm_proc_show():

net/can/bcm.c:bcm_proc_show() {
    ...
    list_for_each_entry(op, &bo->tx_ops, list) {
    ...
}

Should these lists be updated to use list_add_rcu() and
list_for_each_entry_rcu() to ensure safe concurrent iteration via procfs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-bcm_fixes-=
v4-0-aa87b8b9d33f@hartkopp.net?part=3D4
