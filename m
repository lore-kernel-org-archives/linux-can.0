Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.42.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793616850;
	b=T3a1RH6CPj/WM7kRpeoyqJcQ7O4qkr3bra7j1Sr4RQk7G6A6r/U4WeFcX+jcAl3TxQ+R
	 Z1tROIkeZxvubk9b3XnLOIWkXog2tEcKW6oi6j8q+RWEue2TQ036g0GReiqvH49rfokBv
	 wEe80hqbpYT2umRcZg3YXJDtUidZw0smST2yPTOfmPaI4Gzl1w2QL723r+X75Pz4fBuBK
	 y8Pc+HCRU5phT6Tz4WOrXKYNgkY0FZtMeOpk5IJx71b4fFXskd63qyPjo1mEOOwCw3pk8
	 FuV2dOJI47dUmxe2miwJ2wbSOucsj/90mrTw7jYEurd4omUyf7cNbHadAZQCFqvJ4Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616850;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9eB0qwozAyzDEAHNTNmt2NdRxbl4rNCwUZ3msvguFng=;
	b=kx68el1ckVCRTqpszoapprjMznsu2peD8+mtM4Ifov3f11tp+zym2/LSD1YNALvHAw3J
	 c5G97QoNA9POdIvHFZBahn0KeeMv1MYgqL4mMMJ1X2sXy+t+4WHJ5bvFurXWIbR2sJs89
	 mlsWj8Av65Q8DS2FHlLfBKp3vo9yyM2PTqPThR6u91f2qSGpjKya7v/N606K/w7ZkdzGb
	 uRcCuwKL791btnMfhiG1atoBHc3GqDPqo7Yw9fO9IJOvjOhZ5SP1qufgZnuM4hUqYArQp
	 DACb9I2mw/VsBTqpWVrCZu96tlQSrBigwpUVuTaXkCliLtYSGogK/YAcICEB3bsQeDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=free.fr;
	spf=pass smtp.mailfrom=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=dQsWBTnN;
	arc=none smtp.remote-ip=212.27.42.6
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AAD606A330;
	Mon,  2 Nov 2026 10:54:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13AAD606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=dQsWBTnN
Received: from stf-laptop (unknown [82.96.140.143])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 28D9578034D;
	Mon,  2 Nov 2026 11:53:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1793616847;
	bh=9eB0qwozAyzDEAHNTNmt2NdRxbl4rNCwUZ3msvguFng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dQsWBTnNmgsKsgR80ClBs11WaT/GetNo4uFxM0IxMh9kFnXnFwcw3B/nrX4Eb5qv1
	 0af1URbn4ZdR0VKKkQ6U+xQmFHqAisJPbLViM5xoNuvOmmYpm7lqZkizQSPi9iX2MN
	 tY9T4090lgU7q/Lz93lK2nOIG44fYA7Q3lVfi1pGoaXYBOafPfyjxOrgzcILCFvmgJ
	 9tA3yVZySJff++tUb5K6Z8q4XQyQ2uhqlVjB8Q6pa2awnEEyc3hAfyA8rHZeAmApXk
	 U8GvGzN/duWGXLCexJ6ypzHj2wlCLC9N78DzFqWuI7oO6J2k3heooFA1a4RoLCMcAB
	 Mu2g+mEwxFLcg==
From: =?UTF-8?q?St=C3=A9phane=20Grosjean?= <stephane.grosjean@free.fr>
To: netdev-bot+sashiko@kernel.org
Cc: mkl@pengutronix.de,
	mailhol@kernel.org,
	wg@grandegger.com,
	error27@gmail.com,
	lukas.magel@posteo.net,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tristmd@gmail.com,
	kuba@kernel.org
Subject: Re: [PATCH v7 08/13] can: peak_usb: reject records for unset channels in PCAN-USB Pro
Date: Mon,  2 Nov 2026 11:53:33 +0100
Message-ID: <20261102105337.29362-2-stephane.grosjean@free.fr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179349932896.3127.17824384205890325119@kernel.org>
References: <20261030-canfd_check_channel_idx-v7-0-fc4a3faf3acf@peak-system.fr> <20261030-canfd_check_channel_idx-v7-8-fc4a3faf3acf@peak-system.fr> <179349932896.3127.17824384205890325119@kernel.org>
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 01/11/2026 03:15, netdev-bot+sashiko@kernel.org wrote:
[...]
> [Severity: Low]
> When the slot is empty, pcan_usb_pro_handle_canmsg() returns -EINVAL.
[...]
> This is still better than the NULL dereference that happened before.
> Later in the series, "can: peak_usb: register the netdevs only once all
> channels are set up" registers the netdevs in peak_usb_probe() only
> after every channel's dev_init() has filled its slot. That way RX
> cannot run while a slot is NULL.

Yes, this is intended, as discussed on v6: the case can't happen once
patch 9 is applied, and patch 12 dumps the URB once, rate limited.

[...]
> [Severity: Medium]
> This is a pre-existing issue, not one introduced by this patch, but it
> is in the caller of these handlers. pcan_usb_pro_decode_buf() reads
> pr->data_type before it checks that rec_ptr is still below msg_end:
[...]
> [Severity: High]
> This isn't a bug introduced by this patch, but pdev->usb_if is only set
> here.

Both pre-existing, and fixed later in the series, as you note: the
first one by patch 11, the second one by patch 9.

Thanks!

Stéphane
